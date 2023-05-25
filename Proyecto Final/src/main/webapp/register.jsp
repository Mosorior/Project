<%--
    Document   : register
    Created on : 28 abr. 2023, 19:43:29
    Author     : mosorior
--%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>Registro</title>
    <style>
        .show-none {
            display: none;
        }
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
            const registerForm = document.getElementById('register-form');
            const messageContainer = document.getElementById('message-container');
            const logoutButton = document.getElementById('logout-button');

            if (isLoggedIn) {
                registerForm.style.display = 'none';
                messageContainer.style.display = 'block';
            } else {
                messageContainer.style.display = 'none';
            }

            logoutButton.addEventListener('click', () => {
                window.location.href = 'logout.jsp';
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

        function mostrarCamposAdicionales() {
            const rol = document.getElementById('rol').value;
            const campoTelefono = document.getElementById('campo-telefono');
            const campoHabilidad = document.getElementById('campo-habilidad');

            campoTelefono.style.display = (rol === 'solicitante') ? 'block' : 'none';
            campoHabilidad.style.display = (rol === 'contribuyente') ? 'block' : 'none';
        }
    </script>
</head>
<body>

<header class='cabecera'>
    <div class="centrar-logo"> <img class="logo" src="Imagenes/logo.png"/></div>
    <div class="nav-box"><a href="index.jsp">Inicio</a></div>
    <div class="nav-box"><a href="register.jsp">Registrarse</a></div>
    <div class="nav-box"><a href="login.jsp">Entrar</a></div>
</header>

<div class="centered-content">
    <h1 style="text-align: center">Formulario de Registro</h1>

    <form class="register-form" id="register-form" method="post" action="register_process.jsp">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre">

        <label for="apellido">Apellido:</label>
        <input type="text" id="apellido" name="apellido">

        <label for="usuario">Usuario:</label>
        <input type="text" id="usuario" name="usuario" required>

        <label for="contrasena">Contrase&ntilde;a:</label>
        <input type="password" id="contrasena" name="contrasena" required>

        <label for="rol">Rol:</label>
        <select id="rol" name="rol" required onchange="mostrarCamposAdicionales()">
            <option value="">Seleccione un rol</option>
            <option value="solicitante">Solicitante</option>
            <option value="contribuyente">Contribuyente</option>
        </select>

        <div class="show-none" id="campo-telefono">
            <label for="telefono">Telefono:</label>
            <input type="text" id="telefono" name="telefono">
        </div>
        <div class="show-none" id="campo-habilidad">
            <label for="habilidad">Habilidad:</label>
            <input type="text" id="habilidad" name="habilidad">
        </div>

        <input class="button" type="submit" value="Registrarse">
        <p class="message" style="font-size: 12px; text-align: center; margin-top: 10px;">&#191;Ya tienes una cuenta? <a href="login.jsp">&iexcl;Inicia sesi&oacute;n!</a></p>
    </form>

    <div id="message-container" style="display: none;">
        <p class="message" style="text-align: center; font-size: 16px;">Ya has iniciado sesi&oacute;n</p>
        <button class="button" id="logout-button">&#191;Cerrar sesi&oacute;n?</button>
    </div>
</div>

</body>
</html>
