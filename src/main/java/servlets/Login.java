package servlets;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import db.Database; // Clase con las operaciones de las bases de datos

/**
 *
 * @author alumne
 */
@WebServlet(urlPatterns = {"/Login"})
public class Login extends HttpServlet {

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
                      
        Database db = new Database();
        
        response.setContentType("text/html;charset=UTF-8");
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            
            String user = request.getParameter("user"); 
            String password = request.getParameter("password");

            boolean valido = db.consultaUsuario(user, password);
            
            if(valido)
            {
                // Invalidar sesión anterior si existe antes de crear una nueva
                HttpSession oldSession = request.getSession(false);
                if(oldSession != null) {
                    oldSession.invalidate();
                }
                
                // Crear nueva sesión solo si el login es exitoso
                HttpSession newSession = request.getSession(true);
                newSession.setAttribute("usuario", user);
                newSession.setMaxInactiveInterval(300);
                
                response.sendRedirect("http://localhost:8080/Practica2AD/menu.jsp");
            }
            else {
                // Login fallido - invalidar cualquier sesión existente
                HttpSession oldSession = request.getSession(false);
                if(oldSession != null) {
                    oldSession.invalidate();
                }
                
                response.sendRedirect("http://localhost:8080/Practica2AD/error.jsp");
            }
        }
        catch (IOException | ClassNotFoundException e) {
            //System.err.println(e.getMessage());
            response.sendRedirect("http://localhost:8080/Practica2AD/error.jsp");
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
        return "Short description";
    }// </editor-fold>

}