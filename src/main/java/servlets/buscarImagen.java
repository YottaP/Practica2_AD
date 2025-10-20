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
    
    // Verificar sesión
    HttpSession session = request.getSession(false);
    if(session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    String usuarioActual = (String) session.getAttribute("usuario");
    Database db = new Database();
    
    try {
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
        
        // GUARDAR RESULTADOS EN REQUEST ATTRIBUTE
        request.setAttribute("resultados", resultados);
        request.setAttribute("usuarioActual", usuarioActual);
        
        // FORWARD A JSP PARA MOSTRAR RESULTADOS
        request.getRequestDispatcher("resultadosBusqueda.jsp").forward(request, response);
        
    } catch (ClassNotFoundException e) {
        //System.err.println("Error al cargar el driver: " + e.getMessage());
        response.sendRedirect("error.jsp");
    } catch (ServletException | IOException e) {
        //System.err.println("Error en búsqueda: " + e.getMessage());
        response.sendRedirect("error.jsp");
    } finally {
        db.Shutdown();
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

