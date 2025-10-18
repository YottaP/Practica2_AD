<%-- 
    Document   : buscarImagen
    Created on : 14 oct 2025, 21:53:42
    Author     : alumne
--%>

<%-- 
    Document   : buscarImagen
    Created on : Oct 2025
    Author     : alumne
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Verificar si hay sesión activa
    String usuario = (String) session.getAttribute("usuario");
    if(usuario == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buscar Imagen</title>
    </head>
    <body>
        <h1>Buscar Imágenes</h1>
        <p>Usuario actual: <%= usuario %></p>
        
        <form action="BuscarImagen" method="POST">
            <h3>Criterios de búsqueda (dejar en blanco para ver todas las imágenes)</h3>
            
            <label for="title">Título:</label><br>
            <input type="text" id="title" name="title"><br><br>
            
            <label for="description">Descripción:</label><br>
            <input type="text" id="description" name="description"><br><br>
            
            <label for="keywords">Palabras clave:</label><br>
            <input type="text" id="keywords" name="keywords"><br><br>
            
            <label for="author">Autor:</label><br>
            <input type="text" id="author" name="author"><br><br>
            
            <label for="creator">Creador:</label><br>
            <input type="text" id="creator" name="creator"><br><br>
            
            <h4>Búsqueda por fechas:</h4>
            
            <label for="captureDateFrom">Fecha de captura desde:</label><br>
            <input type="date" id="captureDateFrom" name="captureDateFrom"><br><br>
            
            <label for="captureDateTo">Fecha de captura hasta:</label><br>
            <input type="date" id="captureDateTo" name="captureDateTo"><br><br>
            
            <label for="storageDateFrom">Fecha de almacenamiento desde:</label><br>
            <input type="date" id="storageDateFrom" name="storageDateFrom"><br><br>
            
            <label for="storageDateTo">Fecha de almacenamiento hasta:</label><br>
            <input type="date" id="storageDateTo" name="storageDateTo"><br><br>
            
            <input type="submit" value="Buscar">
            <input type="button" value="Volver al Menú" onclick="location.href='menu.jsp'">
        </form>
    </body>
</html>