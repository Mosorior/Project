<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="./css/style.css">
    <script>
        window.addEventListener('DOMContentLoaded', (event) => {
            const userInfo = document.getElementById('user-info');
            const logoutForm = document.getElementById('logout-form');
            const pedirAyudaLink = document.getElementById('pedir-ayuda-link');
            const ayudarLink = document.getElementById('ayudar-link');
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
                if (rolUsuario === 'solicitante') {
                    pedirAyudaLink.style.display = 'block';
                    ayudarLink.style.display = 'none';
                } else if (rolUsuario === 'contribuyente') {
                    pedirAyudaLink.style.display = 'none';
                    ayudarLink.style.display = 'block';
                }

                // Mostrar los botones según el rol del usuario
                if (rolUsuario === 'solicitante') {
                    pedirAyudaButton.style.display = 'block';
                    ayudarButton.style.display = 'none';
                } else if (rolUsuario === 'contribuyente') {
                    pedirAyudaButton.style.display = 'none';
                    ayudarButton.style.display = 'block';
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

                // Ocultar los enlaces de Pedir Ayuda y Ayudar
                pedirAyudaLink.style.display = 'none';
                ayudarLink.style.display = 'none';

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
    <div class="centrar-logo"><img class="logo" src="Imagenes/logo.png"/></div>
    <div class="nav-box"><a href="index.jsp">Inicio</a></div>
    <div class="nav-box" id="registrarse-link"><a href="register.jsp">Registrarse</a></div>
    <div class="nav-box" id="entrar-link"><a href="login.jsp">Entrar</a></div>
    <div class="nav-box" id="pedir-ayuda-link" style="display: none;"><a href="pedir_ayuda.jsp">Pedir Ayuda</a></div>
    <div class="nav-box" id="ayudar-link" style="display: none;"><a href="ayudar.jsp">Ayudar</a></div>
    <div class="nav-box" id="user-info" style="font-size: 24px"></div>
    <div class="nav-box" id="logout-form"><a href="logout.jsp">Cerrar sesi&oacute;n</a></div>
</header>
<h1 style="text-align: center;">Contrinquire</h1>
<p id="login-message" style="text-align: center; display: none;">Por favor, inicia sesi&oacute;n para acceder a todas
    las funciones.</p>
<div class="portada-informacion">
    <img class="portada-foto" src="Imagenes/portada.jpg"/>
    <div>
    <p class="informacion-pagina">Bienvenido a Contrinquire, la plataforma en l&iacute;nea que conecta personas
        dispuestas a ayudar con aquellos que necesitan asistencia.</p>

    <p class="informacion-pagina">En Contrinquire, puedes enviar peticiones de ayuda para cualquier tipo de situaci&oacute;n, ya sea necesitar
        apoyo emocional, asesoramiento acad&eacute;mico o simplemente una mano amiga. </p>
    <p class="informacion-pagina"> Nuestra comunidad de voluntarios est&aacute; lista para ofrecer
        su tiempo y habilidades para brindar la ayuda que necesitas. </p>
    <p class="informacion-pagina"> Adem&aacute;s, tambi&eacute;n puedes convertirte en un
        colaborador y brindar tu ayuda a otros.</p>
        <p class="informacion-pagina"> Juntos, podemos crear un mundo m&aacute;s solidario y conectado. &Uacute;nete a
        Contrinquire y marca la diferencia
        en la vida de las personas.</p>
        <div class="flex flex-row justify-center align-center">
            <button class="button" onclick="location.href='pedir_ayuda.jsp'" id="pedir-ayuda-button" style="display: none;">Pedir Ayuda
            </button>
            <button class="button" onclick="location.href='ayudar.jsp'" id="ayudar-link-button" style="display: none;">Ayudar</button>
        </div>
    </div>

</div>


</body>
</html>
