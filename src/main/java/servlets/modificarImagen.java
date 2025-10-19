/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import clases.Image;
import db.Database;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author alumne
 */
@WebServlet(name = "modificarImagen", urlPatterns = {"/modificarImagen"})
public class modificarImagen extends HttpServlet {

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
        
        // Implem HttpSession
        String creator = (String) request.getSession().getAttribute("usuario");
        if(creator == null)
            response.sendRedirect("Login.jsp");
        
        Database db = new Database();
        int id = Integer.parseInt(request.getParameter("id"));
        Image i = db.retornaImagen(id);
     
        String title = request.getParameter("title");
        if(title == null || title.trim().isEmpty() ) title = i.getTitle();
        String description = request.getParameter("description");
        if(description == null || description.trim().isEmpty()) description = i.getDescription();
        String keywords = request.getParameter("keywords");
        if(keywords == null || keywords.trim().isEmpty()) keywords = i.getKeywords();
        String author = request.getParameter("author");
        if(author == null || author.trim().isEmpty()) author = i.getAuthor();
        String captureDate = request.getParameter("capture_date");
        if(captureDate == null || captureDate.trim().isEmpty()) captureDate = i.getCaptureDate();
        String filename= i.getFilename();
        String storageDate = i.getStorageDate();
       
        Image imagen = new Image(title, description, keywords, author, creator, captureDate, storageDate, filename);
        imagen.setID(id);
        
        boolean modifica = db.modificaImagen(imagen);
        db.Shutdown();
        
        if(!modifica) response.sendRedirect("error.jsp");
        else
        {
            request.setAttribute("mensaje", "La imagen ha sido modificada correctamente");
            RequestDispatcher rd = request.getRequestDispatcher("/modificar_borrar.jsp");
            rd.forward(request,response);       
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
        return "Short description";
    }// </editor-fold>

}
