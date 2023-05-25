<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        /* Estilos para los botones */
        .centered-buttons {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .centered-buttons button {
            margin: 0 10px;
            padding: 10px 20px;
            font-size: 16px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="./css/style.css">
    <script>
        window.addEventListener('DOMContentLoaded', (event) => {
            const userInfo = document.getElementById('user-info');
            const logoutForm = document.getElementById('logout-form');
            const pedirAyudaLink = document.getElementById('pedir-ayuda-link');
            const ayudarLink = document.getElementById('ayudar-link');
            const adminLink = document.getElementById('admin-link');
            const loginMessage = document.getElementById('login-message');
            const pedirAyudaButton = document.getElementById('pedir-ayuda-button');
            const ayudarButton = document.getElementById('ayudar-link-button');
            const entrarLink = document.getElementById('entrar-link');
            const registrarseLink = document.getElementById('registrarse-link');

            // Verificar si el usuario ha iniciado sesión y mostrar/ocultar la foto y el nombre de usuario
            if (isUserLoggedIn()) {
                const username = getUsername(); // Obtener el nombre de usuario del backend
                const rolUsuario = getCookieValue('rolUsuario'); // Obtener el rol del usuario

                // Mostrar el nombre de usuario
                userInfo.innerText = username;

                // Mostrar el formulario de logout
                logoutForm.style.display = 'block';

                // Mostrar los enlaces de Pedir Ayuda y Ayudar según el rol del usuario
                if (rolUsuario === 'solicitante' || rolUsuario === 'admin') {
                    pedirAyudaLink.style.display = 'block';
                } else {
                    pedirAyudaLink.style.display = 'none';
                }

                if (rolUsuario === 'contribuyente' || rolUsuario === 'admin') {
                    ayudarLink.style.display = 'block';
                } else {
                    ayudarLink.style.display = 'none';
                }

                // Mostrar el enlace para "admin" si el rol es "admin"
                if (rolUsuario === 'admin') {
                    adminLink.style.display = 'block';
                }

                // Mostrar los botones según el rol del usuario
                if (rolUsuario === 'solicitante' || rolUsuario === 'admin') {
                    pedirAyudaButton.style.display = 'block';
                } else {
                    pedirAyudaButton.style.display = 'none';
                }

                if (rolUsuario === 'contribuyente' || rolUsuario === 'admin') {
                    ayudarButton.style.display = 'block';
                } else {
                    ayudarButton.style.display = 'none';
                }

                // Ocultar los enlaces de Entrar y Registrarse
                entrarLink.style.display = 'none';
                registrarseLink.style.display = 'none';

                // Ocultar el mensaje de iniciar sesión
                loginMessage.style.display = 'none';
            } else {
                // Ocultar el nombre de usuario
                userInfo.style.display = 'none';

                // Ocultar el formulario de logout
                logoutForm.style.display = 'none';

                // Ocultar los enlaces de Pedir Ayuda, Ayudar y "admin"
                pedirAyudaLink.style.display = 'none';
                ayudarLink.style.display = 'none';
                adminLink.style.display = 'none';

                // Ocultar los botones
                pedirAyudaButton.style.display = 'none';
                ayudarButton.style.display = 'none';

                // Mostrar los enlaces de Entrar y Registrarse
                entrarLink.style.display = 'block';
                registrarseLink.style.display = 'block';

                // Mostrar el mensaje de iniciar sesión
                loginMessage.style.display = 'block';
            }
        });

        // Función para verificar si el usuario ha iniciado sesión
        function isUserLoggedIn() {
            // Obtener la cookie de sesión del navegador
            const sessionToken = getCookieValue('sessionToken');

            return sessionToken !== '';
        }

        // Función para obtener el valor de una cookie por su nombre
        function getCookieValue(cookieName) {
            const cookies = document.cookie.split(';');

            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();

                // Verificar si la cookie comienza con el nombre buscado
                if (cookie.startsWith(cookieName + '=')) {
                    // Obtener el valor de la cookie
                    return cookie.substring(cookieName.length + 1);
                }
            }

            return '';
        }

        // Función de ejemplo para obtener el nombre de usuario desde el backend
        function getUsername() {
            // Obtener el nombre de usuario almacenado en la cookie "nombreUsuario"
            return getCookieValue('nombreUsuario');
        }
    </script>
</head>
<body>
<header class='cabecera'>
    <div class="nav-box"><a href="index.jsp">Inicio</a></div>
    <div class="nav-box" id="registrarse-link"><a href="register.jsp">Registrarse</a></div>
    <div class="nav-box" id="entrar-link"><a href="login.jsp">Entrar</a></div>
    <div class="nav-box"><a href="pedir_ayuda.jsp" id="pedir-ayuda-link" style="display: none;">Pedir Ayuda</a></div>
    <div class="nav-box"><a href="ayudar.jsp" id="ayudar-link" style="display: none;">Ayudar</a></div>
    <div class="nav-box" id="admin-link" style="display: none;"><a href="admin.jsp">Admin</a></div>
    <div class="nav-box" id="user-info"></div>
    <div class="nav-box">
        <form id="logout-form" action="logout.jsp" method="post" style="display: none;">
            <button type="submit">Cerrar sesi&oacute;n</button>
        </form>
    </div>
</header>
<h1 style="text-align: center;">Bienvenido al sitio</h1>
<p id="login-message" style="text-align: center; display: none;">Por favor, inicia sesi&oacute;n para acceder a todas las funciones.</p>
<div class="centered-buttons">
    <button onclick="location.href='pedir_ayuda.jsp'" id="pedir-ayuda-button" style="display: none;">Pedir Ayuda</button>
    <button onclick="location.href='ayudar.jsp'" id="ayudar-link-button" style="display: none;">Ayudar</button>
</div>
</body>
</html>
