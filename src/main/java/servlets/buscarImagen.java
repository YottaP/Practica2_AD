package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import db.Database;
import clases.Image;
import java.util.List;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;



/**
 *
 * @author alumne
 */
@WebServlet(urlPatterns = {"/BuscarImagen"})
public class buscarImagen extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        // Verificar sesión
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("http://localhost:8080/Practica2AD/Login.jsp");
            return;
        }
        
        String usuarioActual = (String) session.getAttribute("usuario");
        Database db = new Database();
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            
            // Recoger parámetros de búsqueda
            String id = request.getParameter("id");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String keywords = request.getParameter("keywords");
            String author = request.getParameter("author");
            String creator = request.getParameter("creator");
            String captureDateFrom = request.getParameter("captureDateFrom");
            String captureDateTo = request.getParameter("captureDateTo");
            String storageDateFrom = request.getParameter("storageDateFrom");
            String storageDateTo = request.getParameter("storageDateTo");
            
            // Realizar búsqueda en la base de datos
            List<Image> resultados = db.buscarImagenes(id, title, description, keywords, 
                                                        author, creator, captureDateFrom, 
                                                        captureDateTo, storageDateFrom, storageDateTo);
            
            // Generar página HTML con resultados
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
            out.println("<title>Resultados de Búsqueda</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Resultados de Búsqueda</h1>");
            out.println("<p><strong>Usuario actual:</strong> " + escapeHtml(usuarioActual) + "</p>");
            
            if(resultados == null || resultados.isEmpty()) {
                out.println("<p><strong>No se encontraron imágenes con los criterios especificados.</strong></p>");
                out.println("<br>");
                out.println("<a href='http://localhost:8080/Practica2AD/buscarImagen.jsp'>Realizar otra búsqueda</a> | ");
                out.println("<a href='http://localhost:8080/Practica2AD/menu.jsp'>Volver al Menú</a>");
            } else {
                out.println("<p>Se encontraron <strong>" + resultados.size() + "</strong> imagen(es).</p>");
                out.println("<table border='1' cellpadding='5' cellspacing='0'>");
                out.println("<tr>");
                out.println("<th>ID</th>");
                out.println("<th>Título</th>");
                out.println("<th>Descripción</th>");
                out.println("<th>Palabras Clave</th>");
                out.println("<th>Autor</th>");
                out.println("<th>Creador</th>");
                out.println("<th>Fecha Captura</th>");
                out.println("<th>Fecha Almacenamiento</th>");
                out.println("<th>Acciones</th>");
                out.println("</tr>");
                
                for(Image img : resultados) {
                    out.println("<tr>");
                    out.println("<td>" + img.getID() + "</td>");
                    out.println("<td>" + escapeHtml(img.getTitle()) + "</td>");
                    out.println("<td>" + escapeHtml(img.getDescription()) + "</td>");
                    out.println("<td>" + escapeHtml(img.getKeywords()) + "</td>");
                    out.println("<td>" + escapeHtml(img.getAuthor()) + "</td>");
                    out.println("<td>" + escapeHtml(img.getCreator()) + "</td>");
                    out.println("<td>" + formatearFecha(img.getCaptureDate()) + "</td>");
                    out.println("<td>" + formatearFecha(img.getStorageDate()) + "</td>");
                    
                    // Mostrar acciones solo si el creador es el usuario actual
                    out.println("<td>");
                    if(img.getCreator() != null && img.getCreator().equals(usuarioActual)) {
                        out.println("<a href='http://localhost:8080/Practica2AD/modificarImagen.jsp?id=" + 
                                   img.getID() + "'>Modificar</a> | ");
                        out.println("<a href='http://localhost:8080/Practica2AD/eliminarImagen.jsp?id=" + 
                                   img.getID() + "' onclick='return confirm(\"¿Está seguro de eliminar esta imagen?\");'>Eliminar</a>");
                    } else {
                        out.println("-");
                    }
                    out.println("</td>");
                    out.println("</tr>");
                }
                
                out.println("</table>");
                out.println("<br>");
                out.println("<a href='http://localhost:8080/Practica2AD/buscarImagen.jsp'>Nueva búsqueda</a> | ");
                out.println("<a href='http://localhost:8080/Practica2AD/menu.jsp'>Volver al Menú</a>");
            }
            
            out.println("</body>");
            out.println("</html>");
            
        } catch (ClassNotFoundException e) {
            System.err.println("Error al cargar el driver: " + e.getMessage());
            response.sendRedirect("http://localhost:8080/Practica2AD/error.jsp");
        } catch (Exception e) {
            System.err.println("Error en búsqueda: " + e.getMessage());
            response.sendRedirect("http://localhost:8080/Practica2AD/error.jsp");
        } finally {
            db.Shutdown();
        }
    }
    
    /**
     * Método auxiliar para escapar caracteres HTML y prevenir XSS
     */
    private String escapeHtml(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#x27;");
    }

     /**
     * Método auxiliar para estandarizar los formatos de fechas entre páginas
     */
    
    private String formatearFecha(String fecha) {
        if (fecha == null || fecha.trim().isEmpty()) {
            return "";
        }

        try {
            DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            LocalDate date = LocalDate.parse(fecha.trim(), inputFormatter);
            return date.format(outputFormatter);
        } catch (DateTimeParseException e) {
            System.err.println("Error al formatear fecha: " + fecha);
            return fecha;
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet para buscar imágenes en el sistema";
    }// </editor-fold>
}

