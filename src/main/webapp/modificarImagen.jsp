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
            
            <input type="hidden" name="id" value="${param.id}">
            
            <label for="title">Título:</label><br>
            <input type="text" id="title" name="title" ><br><br>

            <label for="description">Descripción:</label><br>
            <textarea id="description" name="description" ></textarea><br><br>

            <label for="keywords">Palabras clave:</label><br>
            <input type="text" id="keywords" name="keywords" ><br><br>

            <label for="author">Autor:</label><br>
            <input type="text" id="author" name="author" ><br><br>
            
            <label for="capture_date">Fecha de captura (AAAA-MM-DD):</label><br>
            <input type="date" id="capture_date" name="capture_date"><br><br>            
            
            <input type="submit" value="Actualizar">
            
        </form>
    </body>
</html>
