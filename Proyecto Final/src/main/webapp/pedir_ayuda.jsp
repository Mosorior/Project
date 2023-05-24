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
  <style>
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
</head>
<body>
<header class='cabecera'>
  <div class="nav-box"><a href="index.jsp">Inicio</a></div>
  <div class="nav-box"><p id="user-info"><%= nombreUsuario %></p></div>
  <div class="nav-box">
    <form id="logout-form" action="logout.jsp" method="post">
      <button type="submit">Cerrar sesi&oacute;n</button>
    </form>
  </div>
</header>
<h1 style="text-align: center; margin-bottom: 20px;">Pide Ayuda</h1>
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
