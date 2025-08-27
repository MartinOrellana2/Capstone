
from rest_framework import serializers
from django.contrib.auth import get_user_model, authenticate

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):

    rol = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'first_name', 'last_name', 'email', 'rol']
    
    def get_rol(self, obj):

        group = obj.groups.first()
        return group.name if group else None

class LoginSerializer(serializers.Serializer):

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

    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)

    def validate_new_password(self, value):

        from django.contrib.auth.password_validation import validate_password
        validate_password(value, self.context['request'].user)
        return value