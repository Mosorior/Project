package com.example.controller;

import com.example.dao.MensajeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/rechazarMensaje")
public class RechazarMensajeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int messageId = Integer.parseInt(request.getParameter("messageId"));

        MensajeDAO mensajeDAO = new MensajeDAO();
        mensajeDAO.rechazarMensaje(messageId);

        response.sendRedirect("forum.jsp");
    }
}
