import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useUserStore } from "../store/authStore";
import apiClient from "../api/axios";
import styles from "../css/csslogin.module.css";

export default function LoginPage() {
  const navigate = useNavigate();
  const { setAuth } = useUserStore();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [showLogin, setShowLogin] = useState(false);

  const handleLogin = async (e) => {
    e.preventDefault();
    setError("");

    if (!username || !password) {
      setError("Debes completar todos los campos");
      return;
    }

    try {
      const res = await apiClient.post("/login/", { username, password });
      setAuth({
        user: res.data.user,
        token: res.data.access,
      });
      navigate("/dashboard");
    } catch (err) {
      const errorMessage =
        err.response?.data?.detail || "Usuario o contraseña incorrectos";
      setError(errorMessage);
    }
  };

  return (
    <div className={styles.containerFormWrapper}>
      {!showLogin ? (
        <div className={`${styles.containerForm} ${styles.welcomeCard}`}>
          <h2 className={styles.welcomeTitle}>Bienvenido a PepsicoTaller</h2>
          <p className={styles.welcomeSubtitle}>
            Presiona el botón para continuar
          </p>
          <button
            type="button"
            className={styles.gradientBorderButton}
            onClick={() => setShowLogin(true)}
          >
            Iniciar Sesión
          </button>
        </div>
      ) : (
        <form className={`${styles.containerForm} ${styles.formulario}`} onSubmit={handleLogin}>
          <h2 className={styles.createAccount}>Iniciar Sesión</h2>
          <div className={styles.iconos}></div>
          <p className={styles.cuentaGratis}>Ingrese sus credenciales</p>

          <input
            type="text"
            placeholder="Nombre de usuario"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            className={styles.formularioInput}
          />
          <input
            type="password"
            placeholder="Contraseña"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className={styles.formularioInput}
          />

          {error && (
            <p style={{ color: "red", marginTop: "1rem" }}>{error}</p>
          )}

          <button type="submit" className={styles.slideButton}>
            <span className={styles.slideContent}>
              <span className={styles.text}>Iniciar Sesión</span>
              <span className={styles.icon}>
                <i className="fas fa-arrow-right"></i>
              </span>
            </span>
          </button>

          <button
            type="button"
            className={styles.resetPasswordBtn}
            onClick={() => navigate("/reset-password")}
            style={{
              marginTop: "1rem",
              background: "transparent",
              color: "#fff",
              border: "none",
              textDecoration: "underline",
              cursor: "pointer",
            }}
          >
            ¿Olvidaste tu contraseña?
          </button>
        </form>
      )}
    </div>
  );
}
