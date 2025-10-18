<%-- 
    Document   : modificarImagen
    Created on : 13 oct 2025, 12:11:11
    Author     : alumne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <h1>Modifique su imagen</h1>
        
        <% 
        String usuario = (String) session.getAttribute("usuario");
        if(usuario == null)
            response.sendRedirect("Login.jsp");
        %>
        
        <form  action = "modificarImagen" method = "POST">
            
            <input type="hidden" name="id" value="${imagen.ID}">
            
            <label for="title">Título:</label><br>
            <input type="text" id="title" name="title" value="${imagen.title}" ><br><br>

            <label for="description">Descripción:</label><br>
            <textarea id="description" name="description"value="${imagen.description}" ></textarea><br><br>

            <label for="keywords">Palabras clave:</label><br>
            <input type="text" id="keywords" name="keywords" value="${imagen.keywords}" ><br><br>

            <label for="author">Autor:</label><br>
            <input type="text" id="author" name="author" value="${imagen.author}"><br><br>
            
            <label for="capture_date">Fecha de captura (AAAA-MM-DD):</label><br>
            <input type="date" id="capture_date" name="capture_date" value="${imagen.captureDate}"><br><br>

            <input type="hidden" name="filename" value="${imagen.filename}">
            
            <input type="hidden" name="storageDate" value="${imagen.storageDate}">
            
            <input type="submit" value="Actualizar">
            
        </form>
    </body>
</html>
