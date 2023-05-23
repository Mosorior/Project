<%@ page import="jakarta.servlet.http.Cookie" %>
<%
    String sessionToken = (String) request.getSession().getAttribute("sessionToken");
    String usuario = (String) request.getSession().getAttribute("nombreUsuario");
    Cookie usuarioCookie = new Cookie("usuario", usuario);
    usuarioCookie.setMaxAge(3600); // Establecer la duración de la cookie (en segundos)
    usuarioCookie.setPath("/"); // Establecer el ámbito de la cookie a todo el sitio
    response.addCookie(usuarioCookie);

    // Verificar si el usuario tiene una cookie de sesión y obtener el nombre de usuario de la cookie
    Cookie[] cookies = request.getCookies();
    String sessionUsuario = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("nombreUsuario")) {
                sessionUsuario = cookie.getValue();
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta charset="UTF-8">
    <title>Crear Mensaje</title>
</head>
<body>
<header class='cabecera'>
    <div class="nav-box"><a href="index.jsp">Inicio</a></div>
    <div id="registrarse" class="nav-box"><a href="register.jsp">Registrarse</a></div>
    <div id="entrar" class="nav-box"><a href="login.jsp">Entrar</a></div>
    <div class="nav-box"><p id="user-info"></p></div>
    <form id="logout-form" action="logout.jsp" method="post" style="display: none;">
        <input class="button" type="submit" value="Cerrar sesión">
    </form>
    </div>
</header>
<h1 style="text-align: center">Crear Mensaje</h1>
<form class="register-form" action="guardarMensaje" method="post">
    <input type="hidden" name="sessionToken" value="<%= sessionToken %>">
    <label for="titulo">Titulo:</label><br>
    <input type="text" id="titulo" name="titulo"><br>
    <label for="contenido">Contenido:</label><br>
    <textarea class="text-area" id="contenido" name="contenido"></textarea><br><br>
    <button class="button" style="font-size: 18px" type="submit">Guardar Mensaje</button>
    <p>Usuario: <%= sessionUsuario %></p>
</form>

</body>
</html>
