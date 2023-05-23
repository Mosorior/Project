package com.example.dao;

import com.example.model.Mensaje;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDateTime;


public class MensajeDAO {
    private static final String DB_URL = "jdbc:sqlite:/home/mosorior/Documentos/GitHub/Project/DB";

    public void aceptarMensaje(int messageId) {
        try (Connection con = DriverManager.getConnection(DB_URL);
             PreparedStatement ps = con.prepareStatement("UPDATE mensaje SET aceptado = 1 WHERE id = ?")) {

            ps.setInt(1, messageId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void rechazarMensaje(int messageId) {
        try (Connection con = DriverManager.getConnection(DB_URL);
             PreparedStatement ps = con.prepareStatement("UPDATE mensaje SET aceptado = 0 WHERE id = ?")) {

            ps.setInt(1, messageId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Mensaje getMensajeById(int messageId) {
        Mensaje mensaje = null;

        try (Connection con = DriverManager.getConnection(DB_URL);
             PreparedStatement ps = con.prepareStatement("SELECT * FROM mensaje WHERE id = ?")) {

            ps.setInt(1, messageId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int id = rs.getInt("id");
                    String titulo = rs.getString("titulo");
                    String contenido = rs.getString("contenido");
                    String fecha = rs.getString("fecha");
                    String usuario = rs.getString("usuario");
                    int aceptado = rs.getInt("aceptado");
                    String sessionToken = rs.getString("session_token");

                    mensaje = new Mensaje(id, titulo, contenido, fecha, usuario, aceptado, sessionToken);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return mensaje;
    }

    public List<Mensaje> getMensajes() {
        List<Mensaje> mensajes = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(DB_URL);
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM mensaje ORDER BY id DESC")) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String titulo = rs.getString("titulo");
                String contenido = rs.getString("contenido");
                String fecha = rs.getString("fecha");
                String usuario = rs.getString("usuario");
                int aceptado = rs.getInt("aceptado");
                String sessionToken = rs.getString("session_token");

                Mensaje mensaje = new Mensaje(id, titulo, contenido, fecha, usuario, aceptado, sessionToken);
                mensajes.add(mensaje);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return mensajes;
    }

    public void guardarMensaje(String titulo, String contenido, String fecha, String usuario, int aceptado, String sessionToken) throws SQLException {
        try (Connection con = DriverManager.getConnection(DB_URL);
             PreparedStatement ps = con.prepareStatement("INSERT INTO mensaje (titulo, contenido, fecha, usuario, aceptado, session_token) VALUES (?, ?, ?, ?, ?, ?)")) {

            ps.setString(1, titulo);
            ps.setString(2, contenido);
            ps.setString(3, fecha);
            ps.setString(4, usuario);
            ps.setInt(5, aceptado);
            ps.setString(6, sessionToken);

            ps.executeUpdate();
        }
    }
}
