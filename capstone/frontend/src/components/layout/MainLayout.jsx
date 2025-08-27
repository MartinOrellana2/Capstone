import React, { useState } from 'react';
import { NavLink } from 'react-router-dom';
import { useUserStore } from '../../store/authStore';

export default function MainLayout({ children }) {
    const { user } = useUserStore();
    const [isComponentsOpen, setIsComponentsOpen] = useState(false);

    return (
        <div id="wrapper">
            <ul className="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
                <NavLink className="sidebar-brand d-flex align-items-center justify-content-center" to="/dashboard">
                    <div className="sidebar-brand-icon rotate-n-15">
                        <i className="fas fa-truck"></i>
                    </div>
                    <div className="sidebar-brand-text mx-3">PepsiCo Taller</div>
                </NavLink>

                <hr className="sidebar-divider my-0" />

                <li className="nav-item">
                    <NavLink className="nav-link" to="/dashboard">
                        <i className="fas fa-fw fa-home"></i>
                        <span>Inicio</span>
                    </NavLink>
                </li>
                
                <li className="nav-item">
                    <NavLink className="nav-link" to="/profile">
                        <i className="fas fa-fw fa-user"></i>
                        <span>Mi Perfil</span>
                    </NavLink>
                </li>

                <hr className="sidebar-divider" />

                <div className="sidebar-heading">Interfaz</div>

                <li className="nav-item">
                    <a 
                        className={`nav-link ${!isComponentsOpen ? 'collapsed' : ''}`} 
                        href="#" 
                        onClick={() => setIsComponentsOpen(!isComponentsOpen)}
                    >
                        <i className="fas fa-fw fa-cog"></i>
                        <span>Componentes</span>
                    </a>
                    <div className={`collapse ${isComponentsOpen ? 'show' : ''}`}>
                        <div className="bg-white py-2 collapse-inner rounded">
                            <h6 className="collapse-header">Custom Components:</h6>
                            <NavLink className="collapse-item" to="/buttons">Botones</NavLink>
                            <NavLink className="collapse-item" to="/cards">Cartas</NavLink>
                        </div>
                    </div>
                </li>
            </ul>

            <div id="content-wrapper" className="d-flex flex-column">
                <div id="content">
                    <nav className="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                        <span className="ml-4">Bienvenido, {user?.first_name}</span>
                    </nav>

                    <div className="container-fluid">
                        {children}
                    </div>
                </div>
            </div>
        </div>
    );
}
