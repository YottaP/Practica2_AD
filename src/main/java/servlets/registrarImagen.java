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
import java.time.format.DateTimeFormatter;
import java.util.UUID;

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
        
        // Implem HttpSession
        String creator = (String) request.getSession().getAttribute("usuario");
        if(creator == null)
            response.sendRedirect("Login.jsp");
        
        // Recoger los parámetros 
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String keywords = request.getParameter("keywords");
        String author = request.getParameter("author");
        String captureDate = request.getParameter("capture_date");
        
        // Convertir captureDate de yyyy-MM-dd a yyyy/MM/dd
        if(captureDate != null && !captureDate.isEmpty()) {
            captureDate = captureDate.replace("-", "/");
        }
        
        // Fecha de registro al sistema en formato yyyy/MM/dd
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        String storageDate = LocalDate.now().format(formatter);
        
        Part part=request.getPart("imagen");
        String Random = UUID.randomUUID().toString();
        String Archivo = extractFileName(part);
        String extension = Archivo.substring(Archivo.lastIndexOf("."));
        String NombreArchivo = Random + extension;
        
        // Nombre archivo
        String fileName= IMAGE_DIR + File.separator + NombreArchivo;
        
        Image i = new Image(title, description, keywords, author,
                creator, captureDate, storageDate, NombreArchivo);
        File uploadImage = new File(IMAGE_DIR); 
        if(!uploadImage.exists()) // Crear directorio por si no existe
        {
            uploadImage.mkdirs();
        }

        try(InputStream input = part.getInputStream()) // Copiar imagen en directorio
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
        db.Shutdown(); // Finalizar conexión
        if(!done) response.sendRedirect("http://localhost:8080/Practica2AD/error.jsp");
            
        // Se ha conseguido registrar la imagen, 
        request.setAttribute("mensaje", "La imagen ha sido registrada correctamente");
        RequestDispatcher rd = request.getRequestDispatcher("/resultado.jsp");
        rd.forward(request,response);
        
        
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