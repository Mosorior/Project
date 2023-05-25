<%--
  Created by IntelliJ IDEA.
  User: mosorior
  Date: 22/5/23
  Time: 9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.example.dao.MensajeDAO" %>
<%@ page import="com.example.model.Mensaje" %>
<%@ page import="com.example.dao.UsuarioDAO" %>
<%@ page import="com.example.model.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="css/style.css">
  <title>Procesar Aceptar</title>
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
<div style="background-color: #f0f0f0; padding: 10px;">
  <button class="button" onclick="goBack()">⇦ Volver</button>
</div>
<script>
  function goBack() {
    window.history.back();
  }
</script>
<%
  // Obtener parámetros de la solicitud
  String action = request.getParameter("action");
  int messageId = Integer.parseInt(request.getParameter("messageId"));

  if (action.equals("accept")) {
    // Aceptar el mensaje
    MensajeDAO mensajeDAO = new MensajeDAO();
    mensajeDAO.aceptarMensaje(messageId);

    // Obtener el mensaje aceptado
    Mensaje mensaje = mensajeDAO.getMensajeById(messageId);

    // Obtener el número de teléfono del usuario
    String usuario = mensaje.getUsuario();
    String telefono = "";
    UsuarioDAO usuarioDAO = new UsuarioDAO();
    telefono = usuarioDAO.getTelefonoByUsuario(usuario);

    String texto = "";
    if (telefono == null) {
      texto = "El usuario " + usuario + " no tiene un teléfono asignado.";
    } else {
      texto = "El número de teléfono del usuario '" + usuario + "' es " + telefono + ".";
    }
%>
<h1 style="text-align: center">Mensaje Aceptado</h1>
<p style="text-align: center">El mensaje ha sido aceptado. <%= texto %></p>
<%
} else {
%>
<h1>Acción Inválida</h1>
<p>La acción especificada no es válida.</p>
<%
  }
%>
</body>
</html>
