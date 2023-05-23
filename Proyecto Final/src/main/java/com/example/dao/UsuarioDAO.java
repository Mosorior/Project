package com.example.dao;

import java.sql.*;

public class UsuarioDAO {
    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:sqlite:/home/mosorior/Documentos/GitHub/Project/DB");
    }

    public String getRolByToken(String sessionToken) {
        String rol = null;

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT rol FROM usuario WHERE session_token = ?")) {
            statement.setString(1, sessionToken);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                rol = resultSet.getString("rol");
                if (resultSet.wasNull()) {
                    rol = null;  // Manejar explícitamente el caso de valor nulo
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rol;
    }

    public String getNameByToken(String sessionToken) {
        String name = null;

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT usuario FROM usuario WHERE session_token = ?")) {
            statement.setString(1, sessionToken);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                name = resultSet.getString("usuario");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return name;
    }

    public String getTelefonoByUsuario(String usuario) {
        String telefono = null;

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT telefono FROM usuario WHERE usuario = ?")) {
            statement.setString(1, usuario);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                telefono = resultSet.getString("telefono");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return telefono;
    }
}
