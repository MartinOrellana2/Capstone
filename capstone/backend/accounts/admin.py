from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import (
    Usuario, Vehiculo, Agendamiento, Orden,
    OrdenDocumento, OrdenHistorialEstado, OrdenItem,
    Producto, Servicio
)
# El formulario UsuarioCreationForm probablemente ya no es necesario
# si no tienes campos personalizados complejos al crear un usuario.
# Si sigue siendo necesario, asegúrate de que no haga referencia a 'rol'.

@admin.register(Usuario)
class UsuarioAdmin(UserAdmin):
    # Ya no se necesita el add_form si no tienes campos complejos
    model = Usuario
    # Se elimina 'rol' y se añade un método para mostrar el grupo
    list_display = ('username', 'get_rol', 'email', 'first_name', 'last_name', 'is_staff')
    
    # Se elimina 'rol' de los fieldsets
    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        ('Información personal', {'fields': ('first_name', 'last_name', 'email', 'rut', 'telefono')}),
        # La gestión de roles se hace aquí, a través de los grupos
        ('Permisos', {'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')}),
        ('Fechas importantes', {'fields': ('last_login', 'date_joined')}),
    )
    
    list_filter = ('groups', 'is_staff', 'is_superuser', 'is_active')
    search_fields = ('username', 'first_name', 'last_name', 'email')

    # Método para mostrar el primer grupo del usuario en el listado
    @admin.display(description='Rol (Grupo)')
    def get_rol(self, obj):
        return obj.groups.first().name if obj.groups.exists() else 'Sin Rol'

# El admin para Rol se elimina porque el modelo ya no existe
# @admin.register(Rol) ... -> ELIMINADO

@admin.register(Vehiculo)
class VehiculoAdmin(admin.ModelAdmin):
    list_display = ('patente', 'marca', 'modelo', 'anio', 'kilometraje')
    search_fields = ('patente', 'marca', 'modelo')

@admin.register(Agendamiento)
class AgendamientoAdmin(admin.ModelAdmin):
    list_display = ('id', 'vehiculo', 'fecha_hora_programada', 'estado', 'creado_por')
    list_filter = ('estado', 'fecha_hora_programada')
    search_fields = ('vehiculo__patente',)

# --- Mejoras para la gestión de Órdenes ---
# Usamos "inlines" para ver y editar los detalles de una orden
# directamente desde la página de la orden. ¡Mucho más práctico!

class OrdenItemInline(admin.TabularInline):
    model = OrdenItem
    extra = 1  # Cuántos campos vacíos mostrar para añadir nuevos items
    autocomplete_fields = ['producto', 'servicio']

class OrdenDocumentoInline(admin.TabularInline):
    model = OrdenDocumento
    extra = 1

class OrdenHistorialEstadoInline(admin.TabularInline):
    model = OrdenHistorialEstado
    extra = 0 # No mostrar campos vacíos por defecto
    readonly_fields = ('estado', 'fecha', 'usuario', 'motivo') # Solo lectura

@admin.register(Orden)
class OrdenAdmin(admin.ModelAdmin):
    list_display = ('id', 'vehiculo', 'estado', 'fecha_ingreso', 'usuario_asignado')
    list_filter = ('estado', 'fecha_ingreso')
    search_fields = ('id', 'vehiculo__patente')
    readonly_fields = ('fecha_ingreso',)
    
    # Aquí agregamos los inlines para una gestión centralizada
    inlines = [
        OrdenItemInline,
        OrdenDocumentoInline,
        OrdenHistorialEstadoInline
    ]

@admin.register(Producto)
class ProductoAdmin(admin.ModelAdmin):
    list_display = ('sku', 'nombre', 'marca', 'precio_venta', 'stock')
    search_fields = ('sku', 'nombre', 'marca')

@admin.register(Servicio)
class ServicioAdmin(admin.ModelAdmin):
    list_display = ('id', 'nombre', 'precio_base')
    search_fields = ('nombre',)