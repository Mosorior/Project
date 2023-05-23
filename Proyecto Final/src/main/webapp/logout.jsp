<%--
  Created by IntelliJ IDEA.
  User: mosorior
  Date: 11/5/23
  Time: 12:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Eliminar la cookie de sesión
    Cookie sessionCookie = new Cookie("sessionToken", "");
    sessionCookie.setMaxAge(0); // Establecer una duración de 0 segundos para eliminar la cookie
    sessionCookie.setPath("/");
    response.addCookie(sessionCookie);

    // Redirigir al usuario a la página de inicio de sesión después de cerrar sesión
    response.sendRedirect("login.jsp"); // Reemplaza "login.jsp" con la página a la que deseas redirigir
%>

