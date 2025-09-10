import streamlit as st
import pandas as pd
from datetime import datetime, timedelta
import pytz

# --- CONFIGURACIÓN DE LA PÁGINA ---
st.set_page_config(
    page_title="Sistema de Agendamiento",
    page_icon="🗓️",
    layout="centered",
)

# --- CONFIGURACIÓN DE ZONA HORARIA ---
# Configurar zona horaria de Santiago, Chile
TIMEZONE = pytz.timezone('America/Santiago')

# --- CONFIGURACIÓN DEL SISTEMA ---
DIAS_ATENCION = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"]
HORA_INICIO = 9
HORA_FIN = 17  # 5 PM
DURACION_CITA_MINUTOS = 30
HORARIO_ALMUERZO_INICIO = 13  # 1 PM
HORARIO_ALMUERZO_FIN = 14     # 2 PM

# --- FUNCIONES AUXILIARES ---

def generar_horarios(fecha_obj):
    """Genera los horarios disponibles para un día específico"""
    horarios = []
    # Crear datetime con zona horaria
    inicio = TIMEZONE.localize(datetime.combine(fecha_obj, datetime.min.time().replace(hour=HORA_INICIO)))
    fin = TIMEZONE.localize(datetime.combine(fecha_obj, datetime.min.time().replace(hour=HORA_FIN)))
    
    current_time = inicio
    while current_time < fin:
        # Saltar horario de almuerzo
        if not (HORARIO_ALMUERZO_INICIO <= current_time.hour < HORARIO_ALMUERZO_FIN):
            horarios.append(current_time.strftime("%H:%M"))
        current_time += timedelta(minutes=DURACION_CITA_MINUTOS)
        
    return horarios

def obtener_nombre_dia_espanol(fecha):
    """Convierte el nombre del día de inglés a español"""
    dias_semana_es = {
        "Monday": "Lunes", "Tuesday": "Martes", "Wednesday": "Miércoles",
        "Thursday": "Jueves", "Friday": "Viernes", "Saturday": "Sábado", "Sunday": "Domingo"
    }
    return dias_semana_es.get(fecha.strftime("%A"), "Desconocido")

def validar_nombre(nombre):
    """Valida que el nombre ingresado sea válido"""
    if not nombre or len(nombre.strip()) < 2:
        return False
    if not nombre.replace(" ", "").replace("-", "").isalpha():
        return False
    return True

def obtener_citas_por_fecha(fecha_str):
    """Obtiene las citas agendadas para una fecha específica"""
    return [cita for cita in st.session_state.citas_agendadas if cita["fecha"] == fecha_str]

def cancelar_cita(indice):
    """Cancela una cita específica"""
    if 0 <= indice < len(st.session_state.citas_agendadas):
        cita_cancelada = st.session_state.citas_agendadas.pop(indice)
        st.success(f"Cita cancelada: {cita_cancelada['nombre']} - {cita_cancelada['fecha']} {cita_cancelada['hora']}")
        st.rerun()

# --- INICIALIZACIÓN DEL ESTADO DE LA SESIÓN ---
if 'citas_agendadas' not in st.session_state:
    st.session_state.citas_agendadas = []

if 'mostrar_cancelacion' not in st.session_state:
    st.session_state.mostrar_cancelacion = False

# --- INTERFAZ PRINCIPAL ---
st.title("🗓️ Sistema de Agendamiento de Horas")
st.markdown("---")

# Crear dos columnas para mejor organización
col1, col2 = st.columns([2, 1])

with col1:
    st.header("📅 Agende su cita")
    
    # 1. Selección de fecha
    fecha_seleccionada = st.date_input(
        "Seleccione una fecha:",
        value=datetime.now(TIMEZONE).date(),
        min_value=datetime.now(TIMEZONE).date(),
        max_value=datetime.now(TIMEZONE).date() + timedelta(days=30),
        help="Puede agendar citas hasta 30 días en adelante"
    )
    
    # Obtener el nombre del día en español
    nombre_dia_semana = obtener_nombre_dia_espanol(fecha_seleccionada)
    st.write(f"Día seleccionado: **{nombre_dia_semana}, {fecha_seleccionada.strftime('%d de %B de %Y')}**")
    
    # 2. Verificar si el día es laboral
    if nombre_dia_semana in DIAS_ATENCION:
        horarios_disponibles = generar_horarios(fecha_seleccionada)
        
        # Filtrar horarios que ya han sido agendados
        fecha_str = fecha_seleccionada.strftime('%Y-%m-%d')
        citas_en_fecha = [cita["hora"] for cita in obtener_citas_por_fecha(fecha_str)]
        horarios_filtrados = [h for h in horarios_disponibles if h not in citas_en_fecha]
        
        if not horarios_filtrados:
            st.warning("⚠️ No hay horas disponibles para este día.")
        else:
            st.success(f"✅ {len(horarios_filtrados)} horarios disponibles")
            
            # 3. Formulario para agendar
            with st.form("formulario_cita", clear_on_submit=True):
                st.subheader("Datos de la cita")
                
                nombre_cliente = st.text_input(
                    "Nombre completo:",
                    placeholder="Ej: Juan Pérez",
                    help="Ingrese su nombre completo"
                )
                
                telefono = st.text_input(
                    "Teléfono (opcional):",
                    placeholder="Ej: +56912345678",
                    help="Número de contacto para confirmación"
                )
                
                hora_seleccionada = st.selectbox(
                    "Seleccione una hora:",
                    options=horarios_filtrados,
                    help="Seleccione el horario que más le convenga"
                )
                
                motivo = st.text_area(
                    "Motivo de la cita (opcional):",
                    placeholder="Describa brevemente el motivo de su cita",
                    max_chars=200
                )
                
                # Botón para enviar
                submitted = st.form_submit_button("📝 Agendar Cita", type="primary")
                
                if submitted:
                    nombre_limpio = nombre_cliente.strip()
                    
                    if validar_nombre(nombre_limpio):
                        # Guardar la cita
                        nueva_cita = {
                            "nombre": nombre_limpio,
                            "telefono": telefono.strip() if telefono else "",
                            "fecha": fecha_str,
                            "hora": hora_seleccionada,
                            "motivo": motivo.strip() if motivo else "",
                            "fecha_creacion": datetime.now(TIMEZONE).strftime('%Y-%m-%d %H:%M:%S')
                        }
                        
                        st.session_state.citas_agendadas.append(nueva_cita)
                        
                        # Mensaje de éxito con más información
                        st.success(
                            f"✅ ¡Cita agendada con éxito!\n\n"
                            f"**Cliente:** {nombre_limpio}\n"
                            f"**Fecha:** {fecha_seleccionada.strftime('%d/%m/%Y')} ({nombre_dia_semana})\n"
                            f"**Hora:** {hora_seleccionada}\n"
                            f"**Teléfono:** {telefono if telefono else 'No proporcionado'}"
                        )
                        
                        # Auto-refresh para actualizar la lista
                        st.rerun()
                    else:
                        st.error("❌ Por favor, ingrese un nombre válido (mínimo 2 caracteres, solo letras).")
    else:
        st.error(f"❌ Lo sentimos, no atendemos los días {nombre_dia_semana}.\n\nNuestro horario de atención es de Lunes a Viernes.")

with col2:
    st.header("ℹ️ Información")
    
    with st.container():
        st.markdown("""
        **Horarios de atención:**
        - Lunes a Viernes
        - 9:00 AM - 5:00 PM
        - Citas cada 30 minutos
        - Descanso: 1:00 PM - 2:00 PM
        """)
        
        # Mostrar estadísticas rápidas
        total_citas = len(st.session_state.citas_agendadas)
        citas_hoy = len([c for c in st.session_state.citas_agendadas 
                        if c["fecha"] == datetime.now(TIMEZONE).date().strftime('%Y-%m-%d')])
        
        st.metric("Total de citas", total_citas)
        st.metric("Citas para hoy", citas_hoy)

# --- SECCIÓN DE CITAS PROGRAMADAS ---
st.markdown("---")
st.header("📋 Citas Programadas")

if st.session_state.citas_agendadas:
    # Crear DataFrame
    df_citas = pd.DataFrame(st.session_state.citas_agendadas)
    
    # Ordenar por fecha y hora
    df_citas = df_citas.sort_values(by=["fecha", "hora"])
    
    # Agregar columna de día de la semana
    df_citas['dia_semana'] = df_citas['fecha'].apply(
        lambda x: obtener_nombre_dia_espanol(datetime.strptime(x, '%Y-%m-%d').date())
    )
    
    # Reorganizar y renombrar columnas
    columnas_mostrar = ['nombre', 'fecha', 'dia_semana', 'hora', 'telefono', 'motivo']
    df_display = df_citas[columnas_mostrar].copy()
    
    df_display.rename(columns={
        'nombre': 'Nombre',
        'fecha': 'Fecha',
        'dia_semana': 'Día',
        'hora': 'Hora',
        'telefono': 'Teléfono',
        'motivo': 'Motivo'
    }, inplace=True)
    
    # Mostrar tabla con opciones de filtrado
    col_filtro, col_boton = st.columns([3, 1])
    
    with col_filtro:
        filtro_fecha = st.selectbox(
            "Filtrar por fecha:",
            options=["Todas"] + sorted(df_citas['fecha'].unique()),
            index=0
        )
    
    with col_boton:
        st.write("")  # Espaciado
        if st.button("🗑️ Gestionar Citas"):
            st.session_state.mostrar_cancelacion = not st.session_state.mostrar_cancelacion
    
    # Aplicar filtro si es necesario en el momento de mostrar la tabla
    if filtro_fecha != "Todas":
        df_filtrado = df_display[df_display['Fecha'] == filtro_fecha]
    else:
        df_filtrado = df_display
    
    # Mostrar tabla
    st.dataframe(
        df_filtrado, 
        use_container_width=True, 
        hide_index=True,
        column_config={
            "Teléfono": st.column_config.TextColumn(width="medium"),
            "Motivo": st.column_config.TextColumn(width="large")
        }
    )
    
    # Sección de cancelación de citas
    if st.session_state.mostrar_cancelacion:
        st.markdown("---")
        st.subheader("🗑️ Cancelar Cita")
        
        if len(st.session_state.citas_agendadas) > 0:
            opciones_cancelacion = []
            for i, cita in enumerate(st.session_state.citas_agendadas):
                dia = obtener_nombre_dia_espanol(datetime.strptime(cita['fecha'], '%Y-%m-%d').date())
                opciones_cancelacion.append(
                    f"{cita['nombre']} - {cita['fecha']} ({dia}) {cita['hora']}"
                )
            
            cita_a_cancelar = st.selectbox(
                "Seleccione la cita a cancelar:",
                options=range(len(opciones_cancelacion)),
                format_func=lambda x: opciones_cancelacion[x]
            )
            
            col_cancelar, col_cerrar = st.columns(2)
            with col_cancelar:
                if st.button("❌ Confirmar Cancelación", type="primary"):
                    cancelar_cita(cita_a_cancelar)
            
            with col_cerrar:
                if st.button("↩️ Cerrar"):
                    st.session_state.mostrar_cancelacion = False
                    st.rerun()
        else:
            st.info("No hay citas para cancelar.")
    
    # Muestra total de citas
    st.info(f"📊 Total: {len(df_filtrado)} cita(s) mostrada(s) de {len(st.session_state.citas_agendadas)} total(es)")
    
else:
    st.info("📝 Aún no hay citas agendadas. ¡Programe su primera cita!")

# --- pie de pagina ---
st.markdown("---")
st.markdown(
    "<div style='text-align: center; color: gray; font-size: small;'>"
    "Sistema de Agendamiento v2.0 | Desarrollado con Streamlit"
    "</div>", 
    unsafe_allow_html=True
)