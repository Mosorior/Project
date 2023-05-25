<%@ page import="com.example.dao.MensajeDAO" %>
<%@ page import="com.example.model.Mensaje" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="jakarta.servlet.http.Cookie" %>

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
  boolean esContribuyente = rolUsuario.equals("contribuyente");

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
  <meta charset="UTF-8">
  <link rel="stylesheet" type="text/css" href="css/style.css">
  <title>Foro de Mensajes</title>
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
<h1 style="text-align: center; margin-bottom: 20px;">Pide Ayuda</h1>
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
<div class="mensaje-container <%= mensaje.getAceptado() == 1 ? "aceptado" : "" %> <%= mensaje.getAceptado() == 1 ? "rechazado" : "" %>">
  <div class="fecha-usuario">
    <div class="fecha"><%= fechaFormateada %> - <%= horaFormateada   %></div>
    <div class="usuario"><%= mensaje.getUsuario() %></div>
  </div>
  <div class="titulo"><%= mensaje.getTitulo() %></div>
  <div class="contenido"><%= mensaje.getContenido() %></div>
</div>
<% } %>

<div class="centrar-registro">
  <button class="button <%= esContribuyente ? "disabled" : "" %>" style="cursor: pointer">
    <a href="crear.jsp" style="text-decoration: none; color: white;">Pedir ayuda</a>
  </button>
</div>

</body>
</html>
