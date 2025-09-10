from rest_framework import serializers
from django.contrib.auth import get_user_model, authenticate
from django.contrib.auth.models import Group
from django.contrib.auth.password_validation import validate_password

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    """
    Serializador para LEER la información de los usuarios.
    """
    rol = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = User
        fields = [
            'id', 'username', 'first_name', 'last_name',
            'email', 'rol', 'is_active', 'rut', 'telefono'
        ]
    
    def get_rol(self, obj):
        group = obj.groups.first()
        return group.name if group else None


class UserCreateUpdateSerializer(serializers.ModelSerializer):
    """
    Serializador para CREAR y ACTUALIZAR usuarios.
    """
    rol = serializers.CharField(write_only=True)
    password = serializers.CharField(write_only=True, required=False, allow_blank=True)

    class Meta:
        model = User
        fields = [
            'username', 'first_name', 'last_name', 'email',
            'password', 'is_active', 'rol', 'rut', 'telefono'
        ]

    def validate_password(self, value):
        """Valida la contraseña con las reglas de Django (mínimo, comunes, etc.)."""
        if value:  # Solo si viene password
            validate_password(value)
        return value

    def create(self, validated_data):
        rol_name = validated_data.pop('rol')
        password = validated_data.pop('password', None)
        user = User(**validated_data)
        if password:
            user.set_password(password)
        user.save()
        try:
            group = Group.objects.get(name=rol_name)
            user.groups.add(group)
        except Group.DoesNotExist:
            pass
        return user

    def update(self, instance, validated_data):
        if 'rol' in validated_data:
            rol_name = validated_data.pop('rol')
            instance.groups.clear()
            try:
                group = Group.objects.get(name=rol_name)
                instance.groups.add(group)
            except Group.DoesNotExist:
                pass
        
        password = validated_data.pop('password', None)
        if password:
            validate_password(password, instance)
            instance.set_password(password)

        return super().update(instance, validated_data)


class LoginSerializer(serializers.Serializer):
    """
    Serializador para el INICIO DE SESIÓN.
    Valida las credenciales.
    """
    username = serializers.CharField()
    password = serializers.CharField(write_only=True)
    user = serializers.HiddenField(default=None)

    def validate(self, data):
        user = authenticate(username=data['username'], password=data['password'])
        if not user:
            raise serializers.ValidationError("Credenciales incorrectas. Inténtalo de nuevo.")
        if not user.is_active:
            raise serializers.ValidationError("Esta cuenta de usuario está inactiva.")
        data['user'] = user
        return data


class ChangePasswordSerializer(serializers.Serializer):
    """
    Serializador para que un usuario CAMBIE SU PROPIA CONTRASEÑA.
    """
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)

    def validate_new_password(self, value):
        validate_password(value, self.context['request'].user)
        return value



from .models import Vehiculo

class VehiculoSerializer(serializers.ModelSerializer):
    """
    Serializador para el modelo Vehiculo.
    Convierte los datos del vehículo a formato JSON para la API.
    """
    class Meta:
        model = Vehiculo
        fields = '__all__' # Incluye todos los campos del modelo


from rest_framework import serializers
from django.contrib.auth import get_user_model, authenticate
from django.contrib.auth.models import Group
# 👇 Se importa timedelta para cálculos de tiempo
from datetime import timedelta

# 👇 Se importa el modelo Agendamiento
from .models import Vehiculo, Agendamiento 

User = get_user_model()



# --- 👇 AÑADE ESTOS NUEVOS SERIALIZERS AL FINAL DEL ARCHIVO ---


class AgendamientoSerializer(serializers.ModelSerializer):
    """
    Serializador para crear y mostrar agendamientos.
    Incluye la validación anti-solapamiento.
    """
    # Para mostrar la patente en la lectura de datos
    vehiculo_patente = serializers.CharField(source='vehiculo.patente', read_only=True)
    
    class Meta:
        model = Agendamiento
        fields = [
            'id', 'vehiculo', 'vehiculo_patente', 'chofer_asociado', 
            'fecha_hora_programada', 'duracion_estimada_minutos', 
            'motivo_ingreso', 'estado', 'creado_por'
        ]
        # Hacemos que creado_por sea de solo lectura para que se asigne automáticamente
        read_only_fields = ['creado_por']

    def validate(self, data):
        """
        Validación personalizada para evitar solapamiento de citas.
        """
        start_time = data.get('fecha_hora_programada')
        duration = data.get('duracion_estimada_minutos', 60) # Default 60 mins
        end_time = start_time + timedelta(minutes=duration)
        vehiculo = data.get('vehiculo')

        # Buscamos citas existentes para el mismo vehículo que se solapen
        solapamientos = Agendamiento.objects.filter(
            vehiculo=vehiculo,
            fecha_hora_programada__lt=end_time, # Una cita existente que empieza ANTES de que la nueva TERMINE
            # Y cuya hora de fin es DESPUÉS de que la nueva EMPIECE
        ).exclude(
            # Si estamos actualizando, excluimos la propia cita de la comprobación
            pk=self.instance.pk if self.instance else None
        )
        
        # Para calcular la hora de fin de las citas existentes, lo hacemos en Python
        for cita in solapamientos:
            cita_end_time = cita.fecha_hora_programada + timedelta(minutes=cita.duracion_estimada_minutos)
            if cita_end_time > start_time:
                raise serializers.ValidationError(
                    f"Conflicto de horario. Ya existe una cita para el vehículo {vehiculo.patente} de "
                    f"{cita.fecha_hora_programada.strftime('%H:%M')} a {cita_end_time.strftime('%H:%M')}."
                )

        return data

