<%@ page import="com.example.dao.MensajeDAO" %>
<%@ page import="com.example.model.Mensaje" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
  List<Mensaje> mensajes = new MensajeDAO().getMensajes();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Foro de Mensajes</title>
  <link rel="stylesheet" type="text/css" href="css/style.css">
  <style>
    /* Estilos CSS */

    .mensaje-container {
      border: 1px solid #ccc;
      padding: 10px;
      margin-bottom: 10px;
      text-align: center; /* Centrar el mensaje */
      width: 80%; /* Limitar el ancho al 80% */
      margin-left: auto; /* Centrar horizontalmente */
      margin-right: auto; /* Centrar horizontalmente */
    }

    .mensaje-container.rechazado {
      background-color: #eee; /* Color de fondo gris para mensajes rechazados */
    }

    .fecha {
      font-size: 12px;
      color: #666;
      text-align: left;
      float: left;
    }

    .usuario {
      font-size: 12px;
      color: #666;
      text-align: right;
      float: right;
    }

    .titulo {
      font-size: 16px;
      font-weight: bold;
      clear: both;
    }

    .contenido {
      margin-top: 5px;
    }

    .centrado{
      text-align: center;
    }
  </style>
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
  <div class="nav-box"><a href="index.jsp">Inicio</a></div>
  <div class="nav-box"><a href="pedir_ayuda.jsp" id="pedir-ayuda-link" style="display: none;">Pedir Ayuda</a></div>
  <div class="nav-box"><a href="ayudar.jsp" id="ayudar-link" style="display: none;">Ayudar</a></div>
  <div class="nav-box" id="user-info"></div>
  <div class="nav-box">
    <form action="logout.jsp" method="post">
      <button type="submit">Cerrar sesi&oacute;n</button>
    </form>
  </div>
</header>
<h1 class="centrado">Foro de Mensajes</h1>
<%
  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
%>
<%
  for (Mensaje mensaje : mensajes) {
    String fecha = mensaje.getFecha(); // Obtener la fecha sin aplicar formato
%>
<div class="mensaje-container <%= mensaje.getAceptado() == 1 ? "aceptado" : "" %>">
  <div class="fecha"><%= fecha %></div>
  <div class="usuario"><%= mensaje.getUsuario() %></div>
  <div class="titulo"><%= mensaje.getTitulo() %></div>
  <div class="contenido"><%= mensaje.getContenido() %></div>
  <div>
    <form action="procesar_aceptar.jsp" method="post">
      <input type="hidden" name="action" value="accept">
      <input type="hidden" name="messageId" value="<%= mensaje.getId() %>">
      <input type="hidden" name="username" value="<%= mensaje.getUsuario() %>"> <!-- Agrega este campo -->
      <button type="submit" name="aceptar" value="1">Aceptar</button>
    </form>

    <button onclick="rechazarMensaje(this)">Rechazar</button>
  </div>
</div>
<% } %>

</body>
</html>
