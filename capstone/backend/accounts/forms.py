
from django import forms
from django.contrib.auth.forms import UserCreationForm
from .models import Usuario

class UsuarioCreationForm(UserCreationForm):
    """
    Formulario para crear nuevos usuarios en el panel de administración.
    Actualizado para no incluir el campo 'rol'.
    """
    class Meta:
        model = Usuario
        fields = ('username', 'first_name', 'last_name', 'email', 'rut', 'telefono')