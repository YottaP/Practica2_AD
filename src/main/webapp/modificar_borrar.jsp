<%-- 
    Document   : resultado_borrar
    Created on : 19 oct 2025, 22:09:30
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
        
        <% 
        String usuario = (String) session.getAttribute("usuario");
        if(usuario == null)
            response.sendRedirect("Login.jsp");
        %>
        <h2>${mensaje}</h2>
        <p><a href = http://localhost:8080/Practica2AD/menu.jsp>Volver al Menú</a></p>
    </body>
</html>
