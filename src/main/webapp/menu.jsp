<%-- 
    Document   : menu
    Created on : 6 oct 2025, 22:52:49
    Author     : alumne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú</title>
    </head>
    <body>
        <% 
        String usuario = (String) session.getAttribute("usuario");
        if(usuario == null)
            response.sendRedirect("Login.jsp");
        %>
        <h1>Menú de Gestión de Imágenes</h1>
        
        <ul>
            <li><a href="buscarImagen.jsp">Buscar Imágenes</a></li>
            <li><a href="registrarImagen.jsp">Registrar Nueva Imagen</a></li>
        </ul>
        
        <hr>
        
        <p><a href="Login.jsp">Cerrar Sesión</a></p>
    </body>
</html>
