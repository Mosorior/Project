<%-- 
    Document   : login
    Created on : 28 abr. 2023, 19:43:29
    Author     : mosorior
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="./css/style.css">
    <style>
        .centered-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .message {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .button {
            padding: 10px 20px;
            font-size: 16px;
        }
    </style>
    <script>
        window.addEventListener('DOMContentLoaded', (event) => {
            const isLoggedIn = isUserLoggedIn();
            const loginForm = document.getElementById('login-form');
            const messageContainer = document.getElementById('message-container');
            const volverAlInicioButton = document.getElementById('volver-al-inicio-button');

            if (isLoggedIn) {
                loginForm.style.display = 'none';
                messageContainer.style.display = 'block';
            } else {
                messageContainer.style.display = 'none';
            }

            volverAlInicioButton.addEventListener('click', () => {
                window.location.href = 'index.jsp';
            });
        });

        // Función de ejemplo para verificar si el usuario ha iniciado sesión
        function isUserLoggedIn() {
            // Obtener todas las cookies presentes en el navegador
            const cookies = document.cookie.split(';');

            // Verificar si la cookie de sesión está presente
            const isLoggedIn = cookies.some(cookie => cookie.trim().startsWith('sessionToken='));

            return isLoggedIn;
        }
    </script>
</head>
<body>
<header class='cabecera'>
    <div class="nav-box"><a href="index.jsp">Inicio</a></div>
    <div class="nav-box"><a href="register.jsp">Registrarse</a></div>
    <div class="nav-box"><a href="login.jsp">Entrar</a></div>
</header>

<div class="centered-content">
    <h1 style="text-align: center">Formulario de Inicio de Sesión</h1>

    <form class="register-form" id="login-form" method="POST" action="login_process.jsp">
        <label for="usuario">Usuario:</label>
        <input type="text" id="usuario" name="usuario" required>

        <label for="contrasena">Contraseña:</label>
        <input type="password" id="contrasena" name="contrasena" required>

        <p style="text-align: center; font-size: 16px;">
            ¿No tienes una cuenta? ¡<a href="register.jsp">Regístrate</a>!
        </p>

        <input class="button" type="submit" value="Iniciar Sesión">
    </form>

    <div id="message-container" style="display: none;">
        <p class="message" style="text-align: center; font-size: 16px;">Ya has iniciado sesión</p>
        <button class="button" id="volver-al-inicio-button">Volver al inicio</button>
    </div>
</div>

</body>
</html>
