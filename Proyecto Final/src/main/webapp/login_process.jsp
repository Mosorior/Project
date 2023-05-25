<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Procesar Inicio de Sesión</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    // Obtener parámetros del formulario
    String usuario = request.getParameter("usuario");
    String contrasena = request.getParameter("contrasena");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("org.sqlite.JDBC");
        con = DriverManager.getConnection("jdbc:sqlite:C:/Users/susej/OneDrive/Escritorio/Project/DB");

        // Crear la consulta SELECT para verificar las credenciales del usuario
        String query = "SELECT * FROM usuario WHERE usuario = ? AND contrasena = ?";
        ps = con.prepareStatement(query);
        ps.setString(1, usuario);
        ps.setString(2, contrasena);

        // Ejecutar la consulta SELECT
        rs = ps.executeQuery();

        if (rs.next()) {
            // Las credenciales son válidas, el usuario está autenticado
            // Generar un token de sesión (puedes usar una biblioteca más segura para esto)
            String sessionToken = usuario + System.currentTimeMillis();

            // Configurar la cookie de sesión en la respuesta
            Cookie sessionCookie = new Cookie("sessionToken", sessionToken);
            sessionCookie.setMaxAge(3600); // Establecer la duración de la cookie (en segundos)
            sessionCookie.setPath("/"); // Establecer el ámbito de la cookie a todo el sitio
            response.addCookie(sessionCookie);

            // Obtener el rol del usuario
            String rolUsuario = "";
            String rolQuery = "SELECT rol FROM usuario WHERE usuario = ?";
            try (PreparedStatement rolStatement = con.prepareStatement(rolQuery)) {
                rolStatement.setString(1, usuario);
                ResultSet rolResult = rolStatement.executeQuery();
                if (rolResult.next()) {
                    rolUsuario = rolResult.getString("rol");
                }
            }

            // Configurar la cookie de rol en la respuesta
            Cookie rolCookie = new Cookie("rolUsuario", rolUsuario);
            rolCookie.setMaxAge(3600); // Establecer la duración de la cookie (en segundos)
            rolCookie.setPath("/"); // Establecer el ámbito de la cookie a todo el sitio
            response.addCookie(rolCookie);

            // Configurar la cookie de nombre de usuario en la respuesta
            Cookie nombreCookie = new Cookie("nombreUsuario", usuario);
            nombreCookie.setMaxAge(3600); // Establecer la duración de la cookie (en segundos)
            nombreCookie.setPath("/"); // Establecer el ámbito de la cookie a todo el sitio
            response.addCookie(nombreCookie);

            // Guardar el usuario en la base de datos
            try (PreparedStatement guardarUsuarioStatement = con.prepareStatement("UPDATE mensaje SET usuario = ? WHERE session_token = ?")) {
                guardarUsuarioStatement.setString(1, usuario);
                guardarUsuarioStatement.setString(2, sessionToken);
                guardarUsuarioStatement.executeUpdate();
            }

            // Redirigir al usuario a una página de inicio o a donde desees después del inicio de sesión exitoso
            response.sendRedirect("index.jsp");
        } else {
            // Las credenciales son inválidas, el inicio de sesión ha fallado
            // Redirigir al usuario a una página de error o a donde desees después del inicio de sesión fallido
            response.sendRedirect("login.jsp?error=1");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        // Cerrar las conexiones y recursos
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
</body>
</html>
