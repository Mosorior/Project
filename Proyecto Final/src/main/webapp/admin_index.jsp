<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="com.example.dao.MensajeDAO" %>
<%@ page import="com.example.model.Mensaje" %>
<%@ page import="java.util.List" %>

<%
    List<Mensaje> mensajes = new MensajeDAO().getMensajes();

    // Obtener el rol del usuario desde la cookie "rolUsuario"
    String rolUsuario = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("rolUsuario")) {
                rolUsuario = cookie.getValue();
                break;
            }
        }
    }

    // Comprobar si el rol del usuario es "contribuyente"
    boolean esadmin = rolUsuario.equals("admin");

    // Obtener el nombre de usuario desde la cookie "nombreUsuario"
    String nombreUsuario = "";
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("nombreUsuario")) {
            nombreUsuario = cookie.getValue();
            break;
        }
    }
%>

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


        .mensaje-container {
            text-align: center;
            margin: 50px auto;
            max-width: 600px;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
        }

        .fecha-usuario {
            font-size: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .fecha {
            font-size: 12px;
            margin-right: 10px;
        }

        .usuario {
            font-size: 12px;
            margin-left: 10px;
        }

        .titulo {
            font-size: 24px;
            margin-top: 10px;
            text-align: center;
        }

        .contenido {
            margin-top: 20px;
            text-align: center;
        }

        .centrar-registro {
            text-align: center;
            margin-top: 50px;
        }

        .button.disabled {
            pointer-events: none;
            opacity: 0.5;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="./css/style.css">
    <script>
        function eliminarMensaje(mensajeId) {
            if (confirm("Estas seguro de eliminar este mensaje?")) {
                // Realizar una solicitud al servidor para eliminar el mensaje mediante su ID
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "eliminar_mensaje.jsp", true);
                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        // Actualizar la página después de eliminar el mensaje
                        location.reload();
                    }
                };
                xhr.send("mensajeId=" + mensajeId);
            }
        }
    </script>
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

            if (isUserLoggedIn()) {
                const username = getUsername();
                const rolUsuario = getCookieValue('rolUsuario');

                userInfo.innerText = username;
                logoutForm.style.display = 'block';

                if (rolUsuario === 'admin') {
                    pedirAyudaLink.style.display = 'block';
                    ayudarLink.style.display = 'block';
                    pedirAyudaButton.style.display = 'block';
                    ayudarButton.style.display = 'block';
                    entrarLink.style.display = 'none';
                    registrarseLink.style.display = 'none';
                    loginMessage.style.display = 'none';
                } else {
                    document.body.innerHTML = '<h1 style="text-align: center;">Acceso denegado. Debes ser un administrador para ver este contenido.</h1>';
                }
            } else {
                userInfo.style.display = 'none';
                logoutForm.style.display = 'none';
                pedirAyudaLink.style.display = 'none';
                ayudarLink.style.display = 'none';
                pedirAyudaButton.style.display = 'none';
                ayudarButton.style.display = 'none';
                entrarLink.style.display = 'block';
                registrarseLink.style.display = 'block';
                loginMessage.style.display = 'block';
            }
        });

        function isUserLoggedIn() {
            const sessionToken = getCookieValue('sessionToken');
            return sessionToken !== '';
        }

        function getCookieValue(cookieName) {
            const cookies = document.cookie.split(';');

            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();

                if (cookie.startsWith(cookieName + '=')) {
                    return cookie.substring(cookieName.length + 1);
                }
            }

            return '';
        }

        function getUsername() {
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
    <div class="nav-box" id="user-info"></div>
    <div class="nav-box">
        <form id="logout-form" action="logout.jsp" method="post" style="display: none;">
            <button type="submit">Cerrar sesi&oacute;n</button>
        </form>
    </div>
</header>
<h1 style="text-align: center; margin-bottom: 20px;">Admin Panel</h1>
<%
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
%>
<%
    for (Mensaje mensaje : mensajes) {
        String fecha = mensaje.getFecha(); // Obtener la fecha sin aplicar formato
%>
<div class="mensaje-container <%= mensaje.getAceptado() == 1 ? "aceptado" : "" %> <%= mensaje.getAceptado() == 1 ? "rechazado" : "" %>">
    <div class="fecha-usuario">
        <div class="fecha"><%= fecha %></div>
        <div class="usuario"><%= mensaje.getUsuario() %></div>
        <div class="id" style="display: none"><%=mensaje.getId()%></div>
    </div>
    <div class="titulo"><%= mensaje.getTitulo() %></div>
    <div class="contenido"><%= mensaje.getContenido() %></div>
    <div class="botones">
        <button onclick="eliminarMensaje(<%= mensaje.getId() %>)">Eliminar mensaje</button>
        <button onclick="eliminarUsuario('<%= mensaje.getUsuario() %>')">Eliminar usuario</button>
    </div>
</div>
<% } %>

</body>
</html>
