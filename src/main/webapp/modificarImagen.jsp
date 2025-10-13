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
            
            
            
        </form>
    </body>
</html>
