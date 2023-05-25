<%@ page import="jakarta.servlet.http.Cookie" %>
<%
    String sessionToken = (String) request.getSession().getAttribute("sessionToken");
    String usuario = (String) request.getSession().getAttribute("nombreUsuario");
    Cookie usuarioCookie = new Cookie("usuario", usuario);
    usuarioCookie.setMaxAge(3600); // Establecer la duración de la cookie (en segundos)
    usuarioCookie.setPath("/"); // Establecer el ámbito de la cookie a todo el sitio
    response.addCookie(usuarioCookie);

    // Verificar si el usuario tiene una cookie de sesión y obtener el nombre de usuario de la cookie
    Cookie[] cookies = request.getCookies();
    String sessionUsuario = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("nombreUsuario")) {
                sessionUsuario = cookie.getValue();
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta charset="UTF-8">
    <title>Crear Mensaje</title>
    <script>
        window.addEventListener('DOMContentLoaded', (event) => {
            const userInfo = document.getElementById('user-info');
            const logoutForm = document.getElementById('logout-form');
            const pedirAyudaLink = document.getElementById('pedir-ayuda-link');

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
                } else if (rolUsuario === 'contribuyente') {
                    pedirAyudaLink.style.display = 'none';
                }


            } else {
                // Ocultar el nombre de usuario
                userInfo.style.display = 'none';

                // Ocultar el formulario de logout
                logoutForm.style.display = 'none';

                // Ocultar los enlaces de Pedir Ayuda y Ayudar
                pedirAyudaLink.style.display = 'none';

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
    <div class="nav-box" id="pedir-ayuda-link" style="display: none;"><a href="pedir_ayuda.jsp">Pedir Ayuda</a></div>
    <div class="nav-box" id="user-info" style="font-size: 24px"></div>
    <div class="nav-box" id="logout-form"><a href="logout.jsp">Cerrar sesi&oacute;n</a></div>
</header>
<h1 style="text-align: center">Crear Mensaje</h1>
<form class="register-form" action="guardarMensaje" method="post">
    <input type="hidden" name="sessionToken" value="<%= sessionToken %>">
    <label for="titulo">Titulo:</label><br>
    <input type="text" id="titulo" name="titulo"><br>
    <label for="contenido">Contenido:</label><br>
    <textarea class="text-area" id="contenido" name="contenido"></textarea><br><br>
    <button class="button" style="font-size: 18px" type="submit">Guardar Mensaje</button>
    <p>Usuario: <%= sessionUsuario %></p>
</form>

</body>
</html>
