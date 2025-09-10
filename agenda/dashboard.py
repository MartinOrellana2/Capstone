import streamlit as st
import pandas as pd
import numpy as np
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import seaborn as sns
import matplotlib.pyplot as plt
from datetime import datetime, timedelta
#pip install streramlit plotly pandas numpy seaborn matplotlib

## creacion de mis datos en forma manual para despues pasarlos a un dataset
np.random.seed(42)
fechas = pd.date_range(start='2023-01-01', end='2023-12-31', freq='D')
n_productos = ['Laptop', 'Mouse', 'Teclado', 'Monitor', 'Auriculares']
regiones = ['Norte', 'Sur', 'Este', 'Oeste', 'Centro']

## Generar dataset
data = []
for fecha in fechas:
    for _ in range(np.random.poisson(10)): # 10 ventas por dia en promedio          
        
        data.append({
            'fecha': fecha,
            'producto': np.random.choice(n_productos),
            'región': np.random.choice(regiones),
            'Cantidad': np.random.randint(1, 6),
            'Precio_Unitario': np.random.uniform(50, 1500),
            'Vendedor': f'Vendedor_{np.random.randint(1, 21)}'
        })
        
df = pd.DataFrame(data)
df['venta_total'] = df['Cantidad'] * df['Precio_Unitario']

#Configiracion de la app Frontend
st.set_page_config(page_title="Dashboard de Ventas", layout="wide")

# Titulo Principal
st.title("📊 Dashboard de Ventas")
st.markdown("---")

# Slidebar para filtros
st.sidebar.header("🔧 Filtros")
productos_seleccionados = st.sidebar.multiselect("Selecciona Productos", 
                                                 options=df['producto'].unique(), 
                                                 default=df['producto'].unique())

regiones_seleccionadas = st.sidebar.multiselect("Selecciona Regiones", 
                                               options=df['región'].unique(),
                                               default=df['región'].unique())

# Filtro adicional de fechas
fecha_inicio = st.sidebar.date_input("Fecha de inicio", df['fecha'].min())
fecha_fin = st.sidebar.date_input("Fecha de fin", df['fecha'].max())

# Filtrar datos basados en seleccion
df_filtered = df[
    (df['producto'].isin(productos_seleccionados)) &
    (df['región'].isin(regiones_seleccionadas)) &
    (df['fecha'] >= pd.to_datetime(fecha_inicio)) &
    (df['fecha'] <= pd.to_datetime(fecha_fin))
]

# Mostrar cantidad de registros filtrados
st.sidebar.markdown(f"**Registros mostrados:** {len(df_filtered):,} de {len(df):,}")

#Metricas Principales (ACTUALIZADAS CON FILTROS)
col1, col2, col3, col4 = st.columns(4)
with col1:
    total_ventas = df_filtered['venta_total'].sum()
    st.metric("💰 Ventas Totales", f"${total_ventas:,.0f}")

with col2:
    promedio_venta = df_filtered['venta_total'].mean() if len(df_filtered) > 0 else 0
    st.metric("📊 Promedio por Venta", f"${promedio_venta:,.0f}")

with col3:
    numero_ventas = len(df_filtered)
    st.metric("📈 Número de Ventas", f"{numero_ventas:,}")

with col4:
    # Calcular crecimiento basado en datos filtrados
    df_temp = df_filtered.copy()
    df_temp['mes'] = df_temp['fecha'].dt.to_period('M')
    ventas_por_mes = df_temp.groupby('mes')['venta_total'].sum()
    
    if len(ventas_por_mes) >= 2:
        crecimiento = ((ventas_por_mes.iloc[-1] / ventas_por_mes.iloc[-2]) - 1) * 100
        st.metric("📅 Crecimiento vs Mes Anterior", f"{crecimiento:.1f}%")
    else:
        st.metric("📅 Crecimiento", "N/A")

st.markdown("---")

# GRÁFICOS DINÁMICOS (ACTUALIZADOS CON FILTROS)
col1, col2 = st.columns(2)

with col1:
    # Ventas por mes (FILTRADO)
    df_monthly_filtered = df_filtered.groupby(df_filtered['fecha'].dt.to_period('M'))['venta_total'].sum().reset_index()
    df_monthly_filtered['fecha'] = df_monthly_filtered['fecha'].astype(str)
    
    fig_monthly = px.line(df_monthly_filtered, x='fecha', y='venta_total', 
                         title='📈 Ventas Mensuales (Filtrado)', 
                         labels={'venta_total': 'Ventas ($)', 'fecha': 'Mes'})
    fig_monthly.update_traces(line=dict(width=3, color='#1f77b4'))
    fig_monthly.update_layout(height=400)
    st.plotly_chart(fig_monthly, use_container_width=True)

with col2:
    # Top productos (FILTRADO)
    df_productos_filtered = df_filtered.groupby('producto')['venta_total'].sum().sort_values(ascending=True)
    fig_productos = px.bar(x=df_productos_filtered.values, y=df_productos_filtered.index,
                           orientation='h', title='🏆 Ventas por Producto (Filtrado)',
                           labels={'x': 'Ventas ($)', 'y': 'Producto'},
                           color=df_productos_filtered.values,
                           color_continuous_scale='viridis')
    fig_productos.update_layout(height=400)
    st.plotly_chart(fig_productos, use_container_width=True)

# Segunda fila de gráficos
col3, col4 = st.columns(2)

with col3:
    # Análisis por región (FILTRADO)
    df_regiones_filtered = df_filtered.groupby('región')['venta_total'].sum().reset_index()
    fig_regiones = px.pie(df_regiones_filtered, values='venta_total', names='región', 
                          title='🌍 Distribución de Ventas por Región (Filtrado)',
                          color_discrete_sequence=px.colors.qualitative.Set3)
    fig_regiones.update_layout(height=400)
    st.plotly_chart(fig_regiones, use_container_width=True)

with col4:
    # Distribución de ventas (FILTRADO)
    fig_dist = px.histogram(df_filtered, x='venta_total', nbins=30, 
                           title='📊 Distribución de Ventas Individuales (Filtrado)',
                           labels={'venta_total': 'Venta Total ($)', 'count': 'Frecuencia'},
                           color_discrete_sequence=['#ff7f0e'])
    fig_dist.update_layout(height=400)
    st.plotly_chart(fig_dist, use_container_width=True)

st.markdown("---")

# Tabla de datos y análisis adicional
st.subheader("📋 Análisis Detallado")

tab1, tab2, tab3 = st.tabs(["Datos Filtrados", "Top Vendedores", "Correlaciones"])

with tab1:
    st.dataframe(df_filtered.head(100), use_container_width=True)
    
    # Botón para descargar datos filtrados
    csv = df_filtered.to_csv(index=False)
    st.download_button(
        label="⬇️ Descargar datos filtrados como CSV",
        data=csv,
        file_name=f'ventas_filtradas_{datetime.now().strftime("%Y%m%d")}.csv',
        mime='text/csv'
    )

with tab2:
    # Top vendedores (FILTRADO)
    df_vendedores = df_filtered.groupby('Vendedor').agg({
        'venta_total': ['sum', 'count', 'mean']
    }).round(2)
    df_vendedores.columns = ['Total Ventas', 'Número Ventas', 'Promedio por Venta']
    df_vendedores = df_vendedores.sort_values('Total Ventas', ascending=False).head(10)
    
    st.dataframe(df_vendedores, use_container_width=True)
    
    # Gráfico de top vendedores
    fig_vendedores = px.bar(df_vendedores.reset_index(), x='Vendedor', y='Total Ventas',
                           title='🏅 Top 10 Vendedores (Filtrado)',
                           color='Total Ventas',
                           color_continuous_scale='blues')
    st.plotly_chart(fig_vendedores, use_container_width=True)

with tab3:
    if len(df_filtered) > 0:
        # Correlación entre variables (FILTRADO)
        df_corr_filtered = df_filtered[['Cantidad', 'Precio_Unitario', 'venta_total']].corr()
        fig_heatmap = px.imshow(df_corr_filtered, text_auto=True, aspect="auto", 
                                title='🔥 Correlación entre Variables Numéricas (Filtrado)',
                                color_continuous_scale='RdBu_r')
        fig_heatmap.update_layout(height=400)
        st.plotly_chart(fig_heatmap, use_container_width=True)
        
        # Estadísticas descriptivas
        st.subheader("📊 Estadísticas Descriptivas (Datos Filtrados)")
        st.dataframe(df_filtered.describe(), use_container_width=True)
    else:
        st.warning("⚠️ No hay datos para mostrar con los filtros seleccionados.")

# Footer con información adicional
st.markdown("---")
st.markdown("""
<div style='text-align: center; color: #666;'>
    <p>Dashboard creado con Streamlit 📊 | Datos actualizados en tiempo real según filtros seleccionados</p>
</div>
""", unsafe_allow_html=True)