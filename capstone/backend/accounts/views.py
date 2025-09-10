from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import status, generics, permissions
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes
from django.contrib.auth.tokens import default_token_generator
from django.core.mail import send_mail
from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from django.contrib.auth.password_validation import validate_password

# Se importan todos los serializers necesarios
from .serializers import LoginSerializer, UserSerializer, ChangePasswordSerializer, UserCreateUpdateSerializer

User = get_user_model()


# --- CLASE DE PERMISO ---
# Define la regla de que solo los supervisores pueden acceder a ciertas vistas.
class IsSupervisor(permissions.BasePermission):
    """
    Permiso personalizado para permitir el acceso solo a usuarios 
    que pertenezcan al grupo "Supervisor".
    """
    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.groups.filter(name='Supervisor').exists()


# --- VISTAS DE AUTENTICACIÓN Y PERFIL (Sin cambios) ---
class LoginView(generics.GenericAPIView):
    serializer_class = LoginSerializer
    permission_classes = [AllowAny]
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        refresh = RefreshToken.for_user(user)
        user_data = UserSerializer(user).data
        return Response({
            'refresh': str(refresh),
            'access': str(refresh.access_token),
            'user': user_data
        }, status=status.HTTP_200_OK)

class PasswordResetRequestView(generics.GenericAPIView):
    permission_classes = [AllowAny]
    def post(self, request):
        email = request.data.get('email')
        if not email:
            return Response({"error": "Se requiere el correo"}, status=status.HTTP_400_BAD_REQUEST)
        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            return Response({"message": "Si el correo está registrado, se enviará un enlace de recuperación."}, status=status.HTTP_200_OK)
        token = default_token_generator.make_token(user)
        uid = urlsafe_base64_encode(force_bytes(user.pk))
        reset_link = f"http://localhost:5173/set-new-password?uid={uid}&token={token}" 
        send_mail(
            "Restablecer contraseña para Taller PepsiCo",
            f"Hola {user.first_name},\n\nUsa este enlace para restablecer tu contraseña: {reset_link}\n\nSi no solicitaste esto, ignora este mensaje.",
            "noreply@pepsico-taller.com",
            [email],
            fail_silently=False,
        )
        return Response({"message": "Si el correo está registrado, se enviará un enlace de recuperación."}, status=status.HTTP_200_OK)

class PasswordResetConfirmView(generics.GenericAPIView):
    permission_classes = [AllowAny]
    def post(self, request):
        uidb64 = request.data.get('uid')
        token = request.data.get('token')
        new_password = request.data.get('password')
        if not uidb64 or not token or not new_password:
            return Response({"error": "Datos incompletos"}, status=status.HTTP_400_BAD_REQUEST)
        try:
            uid = urlsafe_base64_decode(uidb64).decode()
            user = User.objects.get(pk=uid)
        except (TypeError, ValueError, OverflowError, User.DoesNotExist):
            return Response({"error": "El enlace de restablecimiento es inválido."}, status=status.HTTP_400_BAD_REQUEST)
        if not default_token_generator.check_token(user, token):
            return Response({"error": "El enlace de restablecimiento es inválido o ha expirado."}, status=status.HTTP_400_BAD_REQUEST)
        try:
            validate_password(new_password, user)
        except ValidationError as e:
            return Response({"error": list(e.messages)}, status=status.HTTP_400_BAD_REQUEST)
        user.set_password(new_password)
        user.save()
        return Response({"message": "Contraseña restablecida con éxito"}, status=status.HTTP_200_OK)

class UserDetailView(generics.RetrieveAPIView):
    serializer_class = UserSerializer
    permission_classes = [IsAuthenticated]
    def get_object(self):
        return self.request.user

class ChangePasswordView(generics.GenericAPIView):
    serializer_class = ChangePasswordSerializer
    permission_classes = [IsAuthenticated]
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = request.user
        old_password = serializer.validated_data['old_password']
        new_password = serializer.validated_data['new_password']
        if not user.check_password(old_password):
            return Response({"error": "La contraseña actual es incorrecta."}, status=status.HTTP_400_BAD_REQUEST)
        user.set_password(new_password)
        user.save()
        return Response({"message": "Contraseña cambiada con éxito."}, status=status.HTTP_200_OK)

# --- VISTAS PARA LA GESTIÓN DE USUARIOS ---

class UserListView(generics.ListAPIView):
    """
    Devuelve la lista de todos los usuarios.
    Solo accesible para Supervisores.
    """
    queryset = User.objects.all().order_by('first_name')
    serializer_class = UserSerializer
    permission_classes = [IsSupervisor]

class UserCreateAPIView(generics.CreateAPIView):
    """
    Permite a un Supervisor crear un nuevo usuario.
    """
    queryset = User.objects.all()
    serializer_class = UserCreateUpdateSerializer
    permission_classes = [IsSupervisor]

class UserRetrieveUpdateAPIView(generics.RetrieveUpdateAPIView):
    """
    Permite a un Supervisor ver, actualizar (PUT) o desactivar (PATCH) un usuario.
    """
    queryset = User.objects.all()
    serializer_class = UserCreateUpdateSerializer
    permission_classes = [IsSupervisor]
    lookup_field = 'id'

# views.py
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from django.utils.timezone import now, timedelta
from django.db.models import Count, Avg, F, ExpressionWrapper, fields
from django.db.models.functions import TruncDay
from .models import Orden, Agendamiento
from .views import IsSupervisor

# Asegúrate de importar tus modelos y el permiso IsSupervisor
from .models import Orden, Agendamiento
from .views import IsSupervisor # Asumiendo que IsSupervisor está en el mismo archivo

# Mapeo de días de la semana para el gráfico
dias_semana = {0: 'Lun', 1: 'Mar', 2: 'Mié', 3: 'Jue', 4: 'Vie', 5: 'Sáb', 6: 'Dom'}

@api_view(['GET'])
@permission_classes([IsSupervisor]) # ¡Importante! Solo los supervisores pueden ver esto.
def supervisor_dashboard_stats(request):
    """
    Calcula y devuelve todas las estadísticas necesarias para el dashboard del supervisor.
    """
    today = now().date()
    start_of_month = today.replace(day=1)
    start_of_week = today - timedelta(days=today.weekday())

    # --- KPIs ---
    vehiculos_en_taller = Orden.objects.filter(
        estado__in=['Ingresado', 'En Diagnostico', 'En Proceso', 'Pausado']
    ).count()

    agendamientos_hoy = Agendamiento.objects.filter(
        fecha_hora_programada__date=today, estado='Programado'
    ).count()

    ordenes_finalizadas_mes = Orden.objects.filter(
        estado='Finalizado', fecha_entrega_real__gte=start_of_month
    ).count()

    # Cálculo del tiempo promedio de reparación en días
    ordenes_completadas = Orden.objects.filter(estado='Finalizado', fecha_entrega_real__isnull=False)
    tiempo_promedio_dias = ordenes_completadas.aggregate(
        avg_duration=Avg(F('fecha_entrega_real') - F('fecha_ingreso'))
    )['avg_duration']
    
    tiempo_promedio_str = "N/A"
    if tiempo_promedio_dias:
        total_dias = tiempo_promedio_dias.total_seconds() / (60 * 60 * 24)
        tiempo_promedio_str = f"{total_dias:.1f} Días"

    # --- Gráfico: Órdenes por estado ---
    ordenes_por_estado = list(Orden.objects.filter(
        estado__in=['Ingresado', 'En Diagnostico', 'En Proceso', 'Pausado']
    ).values('estado').annotate(cantidad=Count('id')))

    # --- Gráfico: Órdenes en la última semana ---
    ordenes_semana_raw = Orden.objects.filter(fecha_ingreso__date__gte=start_of_week) \
        .annotate(dia_semana=TruncDay('fecha_ingreso')) \
        .values('dia_semana') \
        .annotate(creadas=Count('id')).order_by('dia_semana')

    # Formateamos los datos para que coincidan con el frontend ('Lun', 'Mar', etc.)
    ordenes_ultima_semana = []
    for item in ordenes_semana_raw:
        dia_nombre = dias_semana.get(item['dia_semana'].weekday(), '')
        ordenes_ultima_semana.append({'dia': dia_nombre, 'creadas': item['creadas']})

    # --- Tabla: Órdenes recientes ---
    ordenes_recientes = list(Orden.objects.select_related('vehiculo', 'usuario_asignado')
        .order_by('-fecha_ingreso')[:5]
        .values('id', 'vehiculo__patente', 'estado', 'usuario_asignado__first_name', 'usuario_asignado__last_name'))
    
    # Formateamos los datos para la tabla
    ordenes_recientes_data = [
        {
            'id': o['id'],
            'patente': o['vehiculo__patente'],
            'estado': o['estado'],
            'mecanico': f"{o['usuario_asignado__first_name'] or ''} {o['usuario_asignado__last_name'] or ''}".strip()
        } for o in ordenes_recientes
    ]

    return Response({
        'kpis': {
            'vehiculosEnTaller': vehiculos_en_taller,
            'agendamientosHoy': agendamientos_hoy,
            'ordenesFinalizadasMes': ordenes_finalizadas_mes,
            'tiempoPromedioRep': tiempo_promedio_str,
        },
        'ordenesPorEstado': ordenes_por_estado,
        'ordenesUltimaSemana': ordenes_ultima_semana,
        'ordenesRecientes': ordenes_recientes_data,
    })


from .models import Vehiculo
from .serializers import VehiculoSerializer
from rest_framework import viewsets # 👈 Asegúrate de importar viewsets

class VehiculoViewSet(viewsets.ModelViewSet):
    """
    ViewSet que proporciona un CRUD completo (Crear, Ver, Actualizar, Eliminar)
    para el modelo Vehiculo.
    """
    queryset = Vehiculo.objects.all().order_by('patente')
    serializer_class = VehiculoSerializer
    # ¡MUY IMPORTANTE! Solo los Supervisores pueden gestionar vehículos.
    permission_classes = [IsSupervisor] 
