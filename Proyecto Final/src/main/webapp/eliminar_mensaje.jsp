<%--
  Created by IntelliJ IDEA.
  User: mosorior
  Date: 24/5/23
  Time: 12:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.example.dao.MensajeDAO" %>
<%@ page import="com.example.model.Mensaje" %>

<%
    // Obtener el parámetro "id" enviado desde el botón eliminar mensaje
    int idMensaje = Integer.parseInt(request.getParameter("id"));

    // Eliminar el mensaje de la base de datos
    MensajeDAO mensajeDAO = new MensajeDAO();
    mensajeDAO.eliminarMensaje(idMensaje);

    // Redireccionar de vuelta a la página anterior
    response.sendRedirect(request.getHeader("referer"));
%>

