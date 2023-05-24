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
</head>
<body>
<div style="background-color: #f0f0f0; padding: 10px;">
  <button onclick="goBack()">Volver</button>
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
%>
<h1>Mensaje Aceptado</h1>
<p>El mensaje ha sido aceptado. El número de teléfono del usuario "<%= usuario %>" es: <%= telefono %></p>
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
