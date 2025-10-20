<%-- 
    Document   : registrarImagen
    Created on : 8 oct 2025, 15:10:38
    Author     : alumne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        
        <% 
        String usuario = (String) session.getAttribute("usuario");
        if(usuario == null)
            response.sendRedirect("Login.jsp");
        %>
        
        <form action = "registrarImagen" method = "POST" enctype = "multipart/form-data">
        <!-- Añadir los campos del formulario que creas conveniente -->
            
            <label for="title">Título:</label><br>
            <input type="text" id="title" name="title" required><br><br>

            <label for="description">Descripción:</label><br>
            <textarea id="description" name="description" required></textarea><br><br>

            <label for="keywords">Palabras clave:</label><br>
            <input type="text" id="keywords" name="keywords" required><br><br>

            <label for="author">Autor:</label><br>
            <input type="text" id="author" name="author" required><br><br>

            <label for="capture_date">Fecha de captura (AAAA-MM-DD):</label><br>
            <input type="date" id="capture_date" name="capture_date" required><br><br>
            
            <input type="file" id ="imagen" name="imagen" required><br>
            <input type="submit" value="Submit">
        </form>
    </body>
</html>
