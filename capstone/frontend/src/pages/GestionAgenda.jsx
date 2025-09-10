import React, { useState, useEffect, useMemo } from 'react';
import { Calendar, momentLocalizer } from 'react-big-calendar';
import moment from 'moment';
import 'moment/locale/es'; // Importamos la localización en español
// Se corrigen las rutas para que sean absolutas desde la raíz del proyecto
import apiClient from '/src/api/axios.js';
import styles from '/src/css/gestionagenda.module.css';
import { Calendar as CalendarIcon } from 'lucide-react';

// Configuramos moment en español
moment.locale('es');
const localizer = momentLocalizer(moment);

const messages = {
  allDay: 'Todo el día',
  previous: 'Anterior',
  next: 'Siguiente',
  today: 'Hoy',
  month: 'Mes',
  week: 'Semana',
  day: 'Día',
  agenda: 'Agenda',
  date: 'Fecha',
  time: 'Hora',
  event: 'Evento',
  noEventsInRange: 'No hay eventos en este rango.',
  showMore: total => `+ Ver más (${total})`
};

export default function GestionAgenda() {
  const [events, setEvents] = useState([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const fetchAgendamientos = async () => {
      try {
        const response = await apiClient.get('/agendamientos/');
        const formattedEvents = response.data.map(a => ({
          id: a.id,
          title: `Vehículo ${a.vehiculo_patente} - ${a.motivo_ingreso}`,
          start: new Date(a.fecha_hora_programada),
          end: new Date(new Date(a.fecha_hora_programada).getTime() + a.duracion_estimada_minutos * 60000),
          resource: a, // Guardamos el objeto original
        }));
        setEvents(formattedEvents);
      } catch (error) {
        console.error("Error al cargar la agenda", error);
      } finally {
        setIsLoading(false);
      }
    };
    fetchAgendamientos();
  }, []);

  if (isLoading) return <p>Cargando agenda...</p>;

  return (
    <div className={styles.pageWrapper}>
      <header className={styles.header}>
        <h1><CalendarIcon size={32} /> Agenda del Taller</h1>
      </header>
      
      <div className={styles.calendarContainer}>
        <Calendar
          localizer={localizer}
          events={events}
          startAccessor="start"
          endAccessor="end"
          style={{ height: '100%' }}
          messages={messages}
          defaultView="week"
          views={['month', 'week', 'day']}
          onSelectEvent={event => alert(`Cita para: ${event.resource.vehiculo_patente}`)}
          onSelectSlot={slotInfo => alert(`Crear evento de ${slotInfo.start} a ${slotInfo.end}`)}
          selectable
        />
      </div>
    </div>
  );
}

