import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/eliminarMensajeServlet")
public class EliminarMensajeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del mensaje a eliminar desde la URL
        int mensajeId = Integer.parseInt(request.getParameter("mensajeId"));

        // Eliminar el mensaje de la base de datos
        eliminarMensaje(mensajeId);

        // Redireccionar a la página principal u otra página deseada
        response.sendRedirect("index.jsp");
    }

    private void eliminarMensaje(int mensajeId) {
        String url = "jdbc:sqlite:/home/mosorior/Documentos/GitHub/Project/DB";

        try (Connection conn = DriverManager.getConnection(url);
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM mensaje WHERE usuario = ?")) {

            stmt.setInt(1, mensajeId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            // Manejar el error adecuadamente
        }
    }
}
