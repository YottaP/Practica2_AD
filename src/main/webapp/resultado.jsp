<%-- 
    Document   : resultado
    Created on : 17 oct 2025, 23:17:40
    Author     : alumne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resultado</title>
    </head>
    <body>
        
        <% 
        String usuario = (String) session.getAttribute("usuario");
        if(usuario == null)
            response.sendRedirect("Login.jsp");
        %>
        <h2>${mensaje}</h2>
        <p>Que quieres hacer ahora?</p>
        <p><a href = http://localhost:8080/Practica2AD/menu.jsp>Volver al Menú</a></p>
        <p><a href = http://localhost:8080/Practica2AD/registrarImagen.jsp>Volver a Registrar Imagen</a></p>
        
    </body>
</html>
