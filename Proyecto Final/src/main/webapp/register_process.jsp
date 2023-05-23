<%--
    Document   : register_process
    Created on : 28 abr. 2023, 19:43:29
    Author     : mosorior
--%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="java.io.*" %>
<%@ page import="com.example.util.CookieGenerator" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>Procesar Registro</title>
</head>
<body>
    <%
    boolean registrationSuccessful = false;

    String usuario = request.getParameter("usuario");
    String contrasena = request.getParameter("contrasena");
    String rol = request.getParameter("rol");
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String habilidades = null;
    String telefono = null;

    if (rol.equals("solicitante")) {
        String telString = request.getParameter("telefono");
        if (telString != null && telString.matches("\\d+")) {
            telefono = telString;
        } else {
            telefono = null; // Asignar null cuando el teléfono no sea numérico
        }
    } else if (rol.equals("contribuyente")) {
        habilidades = request.getParameter("habilidades");
    }

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("org.sqlite.JDBC");
        con = DriverManager.getConnection("jdbc:sqlite:/home/mosorior/Documentos/GitHub/Project/DB");

        // Inicio de la transacción explícitamente
        con.setAutoCommit(false);

        // Verificar si el usuario ya existe
        String checkQuery = "SELECT COUNT(*) FROM usuario WHERE usuario = ?";
        PreparedStatement checkStatement = con.prepareStatement(checkQuery);
        checkStatement.setString(1, usuario);
        ResultSet resultSet = checkStatement.executeQuery();
        if (resultSet.next()) {
            int count = resultSet.getInt(1);
            if (count > 0) {
                // El usuario ya existe, muestra un mensaje de error y finaliza la ejecución
                %>
<h1>Error en el registro</h1>
<p>El usuario ya existe en la base de datos. Por favor, elige otro nombre de usuario.</p>
    <%
                return;
            }
        }

        // Crear la consulta INSERT con parámetros
        String query = "INSERT INTO usuario (usuario, contrasena, rol, nombre, apellido, habilidades, telefono) VALUES (?, ?, ?, ?, ?, ?, ?)";
        ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, usuario);
        ps.setString(2, contrasena);
        ps.setString(3, rol);
        ps.setString(4, nombre);
        ps.setString(5, apellido);
        ps.setString(6, habilidades);

        if (telefono != null) {
            ps.setString(7, telefono);
        } else {
            ps.setNull(7, Types.NULL);
        }

        // Ejecución de la consulta INSERT
        int rowsInserted = ps.executeUpdate();

        if (rowsInserted > 0) {
            // Obtener el ID generado para el usuario
            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                int userId = generatedKeys.getInt(1);

                // Confirmar los cambios en la base de datos
                con.commit();

                // Obtener un token de sesión ionic utilizando CookieGenerator
                String sessionToken = CookieGenerator.generateSessionToken();

                // Realizar la actualización en la base de datos para guardar el token de sesión asociado al ID del usuario
                query = "UPDATE usuario SET session_token = ? WHERE id = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, sessionToken);
                ps.setInt(2, userId);
                ps.executeUpdate();

                // Configurar la cookie de sesión en la respuesta
                Cookie sessionCookie = new Cookie("sessionToken", sessionToken);
                sessionCookie.setMaxAge(3600); // Establecer la duración de la cookie (en segundos)
                sessionCookie.setPath("/"); // Establecer el ámbito de la cookie a todo el sitio
                response.addCookie(sessionCookie);

                // Registro exitoso
                %>
<title>Registro</title>
<body>
<header class='cabecera'>
    <div class="nav-box"><a href="index.jsp">Inicio</a></div>
    <div class="nav-box"><a href="register.jsp">Registrarse</a></div>
    <div class="nav-box"><a href="login.jsp">Entrar</a></div>
</header>
<div style="width: 100%; height: 100%">

    <div class="centrar-registro">
        <h1>Registro exitoso</h1>

        <p> ¡El registro se ha realizado correctamente! Inicie sesi&oacute;n para continuar:</p>
        <button class="button" style="cursor: pointer">
            <a href="logout.jsp" style="text-decoration: none; color: white;" >Iniciar Sesi&oacute;n</a>
        </button>
    </div>
</div>
<%
        } else {
            // No se pudo obtener el ID generado
            throw new SQLException("No se pudo obtener el ID generado para el usuario.");
        }
    } else {
        // No se pudo insertar el registro
        throw new SQLException("No se pudo insertar el registro en la base de datos.");
    }
} catch (Exception e) {
    // Manejo de excepciones
    if (con != null) {
        try {
            // Deshacer cualquier cambio pendiente en caso de error
            con.rollback();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    e.printStackTrace();
%>

<h1>Error en el registro</h1>
<p>Ha ocurrido un error durante el registro. Por favor, int&eacute;ntalo nuevamente.</p>
<%
    } finally {
        // Cierre de recursos
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
%>
</body>
</html>
