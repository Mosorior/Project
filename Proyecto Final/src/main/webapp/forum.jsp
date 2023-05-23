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
    <style>
        .mensaje-container {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
            text-align: center; /* Centrar el mensaje */
            width: 80%; /* Limitar el ancho al 80% */
            margin-left: auto; /* Centrar horizontalmente */
            margin-right: auto; /* Centrar horizontalmente */
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

        .aceptado {
            border-color: green;
        }

        .rechazado {
            border-color: red;
        }

        .float-button {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #008CBA;
            color: white;
            font-size: 20px;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            text-align: center;
            line-height: 40px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<h1>Foro de Mensajes</h1>
<%
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
%>
<%
    for (Mensaje mensaje : mensajes) {
        String fecha = mensaje.getFecha().toString(); // Obtener la fecha sin aplicar formato
%>
<div class="mensaje-container <%= mensaje.getAceptado() == 1 ? "aceptado" : "" %> <%= mensaje.getAceptado() == 1 ? "rechazado" : "" %>">
    <div class="fecha"><%= fecha %></div>
    <div class="usuario"><%= mensaje.getUsuario() %></div>
    <div class="titulo"><%= mensaje.getTitulo() %></div>
    <div class="contenido"><%= mensaje.getContenido() %></div>
    <div>
        <button>Aceptar</button>
        <button>Rechazar</button>
    </div>
</div>
<% } %>

<div class="float-button">
    <a href="crear.jsp">+</a>
</div>

</body>
</html>