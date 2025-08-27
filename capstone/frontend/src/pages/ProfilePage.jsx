import { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import apiClient from '../api/axios';

export default function ProfilePage() {
  const [userProfile, setUserProfile] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState('');
  const [changePasswordError, setChangePasswordError] = useState('');

  const [oldPassword, setOldPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [message, setMessage] = useState('');
  
  const navigate = useNavigate();

  useEffect(() => {
    const fetchUserProfile = async () => {
      try {
        const response = await apiClient.get('/users/me/');
        setUserProfile(response.data);
      } catch (err) {
        setError('No se pudo cargar el perfil del usuario. Intenta iniciar sesión de nuevo.');
      } finally {
        setIsLoading(false);
      }
    };
    fetchUserProfile();
  }, []);

  const handleChangePassword = async (e) => {
    e.preventDefault();
    setChangePasswordError('');
    setMessage('');
    if (newPassword.length < 8) {
      setChangePasswordError('La nueva contraseña debe tener al menos 8 caracteres.');
      return;
    }
    try {
      const response = await apiClient.post('/users/me/change-password/', {
        old_password: oldPassword,
        new_password: newPassword,
      });
      setMessage(response.data.message + " Redirigiendo al dashboard...");
      setTimeout(() => {
        navigate('/dashboard');
      }, 2000);
    } catch (err) {
      const errorData = err.response?.data?.error;
      if (Array.isArray(errorData)) {
        setChangePasswordError(errorData.join(" "));
      } else {
        setChangePasswordError(errorData || 'Ocurrió un error al cambiar la contraseña.');
      }
    }
  };

  if (isLoading) {
    return <p className="text-white text-center p-8">Cargando perfil...</p>;
  }
  if (error) {
    return <p className="text-red-500 text-center p-8">{error}</p>;
  }

  return (
    <div className="p-4 md:p-8 text-white max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Mi Perfil</h1>
      
      {/* Sección de Datos del Usuario */}
      {userProfile && (
        <div className="bg-gray-800 p-6 rounded-lg mb-8 shadow-lg">
          <h2 className="text-xl font-semibold mb-4 text-cyan-400">Información de la Cuenta</h2>
          <div className="space-y-2">
            <p><strong>Nombre de Usuario:</strong> {userProfile.username}</p>
            <p><strong>Nombre:</strong> {userProfile.first_name} {userProfile.last_name}</p>
            <p><strong>Email:</strong> {userProfile.email}</p>
            <p><strong>Rol:</strong> {userProfile.rol}</p>
          </div>
        </div>
      )}

      {/* Sección para Cambiar Contraseña */}
      <div className="bg-gray-800 p-6 rounded-lg shadow-lg">
        <h2 className="text-xl font-semibold mb-4 text-cyan-400">Cambiar Contraseña</h2>
        <form onSubmit={handleChangePassword} className="space-y-4">
          <div>
            <label htmlFor="old_pass" className="block text-sm font-medium">Contraseña Actual</label>
            <input
              id="old_pass"
              type="password"
              value={oldPassword}
              onChange={(e) => setOldPassword(e.target.value)}
              className="w-full p-2 bg-gray-700 rounded mt-1 border border-gray-600 focus:ring-cyan-500 focus:border-cyan-500"
              required
            />
          </div>
          <div>
            <label htmlFor="new_pass" className="block text-sm font-medium">Nueva Contraseña</label>
            <input
              id="new_pass"
              type="password"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
              className="w-full p-2 bg-gray-700 rounded mt-1 border border-gray-600 focus:ring-cyan-500 focus:border-cyan-500"
              placeholder="Mínimo 8 caracteres"
              required
            />
          </div>
          {changePasswordError && <p className="text-red-500 text-sm">{changePasswordError}</p>}
          {message && <p className="text-green-500 text-sm">{message}</p>}
          
          {/* CONTENEDOR CON LOS BOTONES Y ESTILOS EN LÍNEA, IGUAL QUE EL DASHBOARD */}
          <div className="flex items-center space-x-4 pt-2">
            <button 
              type="submit"
              style={{
                padding: "10px 20px",
                fontSize: "1rem",
                color: "#fff",
                backgroundColor: "#007bff", 
                border: "none",
                borderRadius: "5px",
                cursor: "pointer",
              }}
            >
              Actualizar Contraseña
            </button>
            <Link 
              to="/dashboard"
              style={{
                padding: "10px 20px",
                fontSize: "1rem",
                color: "#fff",
                backgroundColor: "#dc3545",
                border: "none",
                borderRadius: "5px",
                cursor: "pointer",
                textDecoration: "none",
              }}
            >
              Volver
            </Link>
          </div>
        </form>
      </div>
    </div>
  );
}