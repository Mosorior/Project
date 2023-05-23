package com.example.controller;

import com.example.dao.MensajeDAO;
import com.example.model.Usuario;
import com.example.dao.UsuarioDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/guardarMensaje")
public class GuardarMensajeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sessionToken = request.getParameter("sessionToken");
        String titulo = request.getParameter("titulo");
        String contenido = request.getParameter("contenido");
        String fecha = LocalDateTime.now().toString();

        // Obtener el usuario de la cookie
        String usuario = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("nombreUsuario")) {
                    usuario = cookie.getValue();
                    System.out.println("Valor de la cookie de usuario: " + usuario); // Depuración
                    break;
                }
            }
        }


        MensajeDAO mensajeDAO = new MensajeDAO();
        try {
            mensajeDAO.guardarMensaje(titulo, contenido, fecha, usuario, 0, sessionToken);
            response.sendRedirect("pedir_ayuda.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Manejo de errores: redirigir a una página de error o mostrar un mensaje de error en la página actual
        }
    }
}
