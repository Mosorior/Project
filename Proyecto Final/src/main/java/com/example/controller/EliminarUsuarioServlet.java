package com.example.controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/eliminarUsuarioServlet")
public class EliminarUsuarioServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el nombre de usuario a eliminar desde la URL
        String usuario = request.getParameter("usuario");

        // Eliminar el usuario y los mensajes asociados de la base de datos
        eliminarUsuario(usuario);

        // Redireccionar a la página principal u otra página deseada
        response.sendRedirect("index.jsp");
    }

    private void eliminarUsuario(String usuario) {
        String url = "jdbc:sqlite:/home/mosorior/Documentos/GitHub/Project/DB";

        try (Connection conn = DriverManager.getConnection(url);
             PreparedStatement stmtMensajes = conn.prepareStatement("DELETE FROM mensaje WHERE usuario = ?");
             PreparedStatement stmtUsuario = conn.prepareStatement("DELETE FROM usuario WHERE usuario = ?")) {

            // Eliminar los mensajes asociados al usuario
            stmtMensajes.setString(1, usuario);
            stmtMensajes.executeUpdate();

            // Eliminar el usuario
            stmtUsuario.setString(1, usuario);
            stmtUsuario.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            // Manejar el error adecuadamente
        }
    }
}
