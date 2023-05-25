<%@ page import="com.example.dao.MensajeDAO" %>
<%@ page import="com.example.model.Mensaje" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Date" %>

<%
    List<Mensaje> mensajes = new MensajeDAO().getMensajes();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Foro de Mensajes</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script>
        // Verificar si el usuario ha iniciado sesión y mostrar/ocultar elementos de la página
        window.addEventListener('DOMContentLoaded', (event) => {
            const userInfo = document.getElementById('user-info');
            const mensajeContainers = document.getElementsByClassName('mensaje-container');
            const pedirAyudaLink = document.getElementById('pedir-ayuda-link');
            const ayudarLink = document.getElementById('ayudar-link');

            if (isUserLoggedIn()) {
                const username = getUsername(); // Obtener el nombre de usuario del backend

                // Mostrar/ocultar enlaces de la barra de navegación según el rol del usuario
                const rolUsuario = getCookieValue('rolUsuario');

                if (rolUsuario === 'solicitante') {
                    pedirAyudaLink.style.display = 'block';
                    ayudarLink.style.display = 'none';
                } else if (rolUsuario === 'contribuyente') {
                    pedirAyudaLink.style.display = 'none';
                    ayudarLink.style.display = 'block';
                }

                // Mostrar el nombre de usuario
                userInfo.innerText = username;

                // Mostrar los contenedores de mensaje
                Array.from(mensajeContainers).forEach(container => {
                    container.style.display = 'block';
                });
            } else {
                // Ocultar el nombre de usuario
                userInfo.style.display = 'none';

                // Ocultar los contenedores de mensaje
                Array.from(mensajeContainers).forEach(container => {
                    container.style.display = 'none';
                });

                // Ocultar enlaces de la barra de navegación
                pedirAyudaLink.style.display = 'none';
                ayudarLink.style.display = 'none';
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

        function rechazarMensaje(element) {
            element.parentNode.parentNode.classList.add('rechazado');
            element.disabled = true;
        }
    </script>
</head>
<body>
<header class='cabecera'>
    <div class="centrar-logo"><img class="logo" src="Imagenes/logo.png"/></div>
    <div class="nav-box"><a href="index.jsp">Inicio</a></div>
    <div class="nav-box" id="pedir-ayuda-link" style="display: none;"><a href="pedir_ayuda.jsp">Pedir Ayuda</a></div>
    <div class="nav-box" id="ayudar-link" style="display: none;"><a href="ayudar.jsp">Ayudar</a></div>
    <div class="nav-box" id="user-info" style="font-size: 24px"></div>
    <div class="nav-box"><a href="logout.jsp">Cerrar sesi&oacute;n</a></div>
</header>
<h1 class="centrado">Foro de Mensajes</h1>
<%
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
%>
<%
    for (Mensaje mensaje : mensajes) {
        //2023-05-20T19:24:15.123456
        String[] fechaYHora = mensaje.getFecha().split("T"); // Obtener la fecha y hora por separado
        //[2023-05-20, 19:24:15.123456]
        String fecha = fechaYHora[0]; //Obtener fecha
        String[] separacion = fecha.split("-"); //Dividir año, mes y dia
        //[2023, 05, 20]
        String fechaFormateada =
                separacion[2] + "/" + separacion[1] + "/" + separacion[0]; //Poner dia, mes y año, usando / como separador
        // 20/05/2023
        String hora = fechaYHora[1];
        // 19:24:15.123456
        String horaFormateada = hora.substring(0, hora.lastIndexOf('.'));
        //19:24:15
%>
<div class="mensaje-container <%= mensaje.getAceptado() == 1 ? "aceptado" : "" %>">
    <div class="fecha"><%= fechaFormateada %> - <%= horaFormateada %>
    </div>
    <div class="usuario"><%= mensaje.getUsuario() %>
    </div>
    <div class="titulo"><%= mensaje.getTitulo() %>
    </div>
    <div class="contenido"><%= mensaje.getContenido() %>
    </div>
    <div>
        <form action="procesar_aceptar.jsp" method="post">
            <input type="hidden" name="action" value="accept">
            <input type="hidden" name="messageId" value="<%= mensaje.getId() %>">
            <input type="hidden" name="username" value="<%= mensaje.getUsuario() %>"> <!-- Agrega este campo -->
            <div class="flex flex-row justify-end margen-arriba">
                <button class="rechazar button" onclick="rechazarMensaje(this)">Rechazar</button>
                <button class="aceptar button" type="submit" name="aceptar" value="1">Aceptar</button>
            </div>

        </form>

    </div>
</div>
<% } %>

</body>
</html>
