/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import clases.Image;
import db.Database;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;

/**
 *
 * @author alumne
 */
@WebServlet(name = "registrarImagen", urlPatterns = {"/registrarImagen"})
@MultipartConfig
public class registrarImagen extends HttpServlet {
    
    private static final String IMAGE_DIR = "/var/webapp/uploads";

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
        
        // Recoger los parámetros 
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String keywords = request.getParameter("keywords");
        String author = request.getParameter("author");
        String creator = request.getParameter("creator");
        String captureDate = request.getParameter("capture_date");
        String storageDate = LocalDate.now().toString(); // fecha de regitro al sistema
        
        Part part=request.getPart("imagen");
        String fileName= IMAGE_DIR + File.separator + extractFileName(part);
        Image i = new Image(title, description, keywords, author,
                creator, captureDate, fileName, storageDate);
        
        File uploadImage = new File(IMAGE_DIR); 
        if(!uploadImage.exists()) // Crear directorio por si no existe
        {
            uploadImage.mkdirs();
        }

        try(InputStream input = part.getInputStream())
        {
            Files.copy(input, new File(fileName).toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        catch(Exception e)
        {
            // Redirigir a error porque no podemos guardar la imagen
            response.sendRedirect("http://localhost:8080/Practica2AD/error.jsp");
        }
        
        Database db = new Database();
        boolean done = db.insertaImagen(i);
        if(!done) response.sendRedirect("http://localhost:8080/Practica2AD/error.jsp");

        // Hacemos la query ya que hemos podido enviar la foto
        
        response.getWriter().println("<h1>Que quieres hacer?</h1><br>");
        
        response.getWriter().println("<p><a href = \"http://localhost:8080/Practica2AD/menu.jsp\">Volver al Menú</a></p>\n" +"");
      
        response.getWriter().println("<p><a href = \"http://localhost:8080/Practica2AD/registrarImagen.jsp\">Volver a Registrar Imagen</a></p>\n" +"");
    }
    
    // file name of the upload file is included in content-disposition header like this:
    //form-data; name="dataFile"; filename="PHOTO.JPG"
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length()-1);
            }
        }
    return "";
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
