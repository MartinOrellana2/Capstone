import { Navigate, Outlet } from 'react-router-dom';
import { useUserStore } from '../store/authStore';
import MainLayout from './layout/MainLayout'; 

const PrivateRoute = () => {
  const { user } = useUserStore();


  if (!user) {
    return <Navigate to="/" replace />;
  }


  return (
    <MainLayout>
      <Outlet />
    </MainLayout>
  );
};

export default PrivateRoute;