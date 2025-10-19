<%-- 
    Document   : error
    Created on : 7 oct 2025, 15:30:03
    Author     : alumne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%--<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h1>Error!</h1>
        <%
        String Referer = request.getHeader("referer");
        %>
        <% if(Referer != null && Referer.equals("http://localhost:8080/Practica2AD/")) {%>
            <p><a href = "http://localhost:8080/Practica2AD/">Login</a></p>
        <% }else { %>
            <p><a href = "http://localhost:8080/Practica2AD/menu.jsp">Menu</a></p>
        <% } %>
    </body>
</html>--%>

<%-- 
    Document   : error
    Created on : 7 oct 2025, 15:30:03
    Author     : alumne
--%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
    </head>
    <body>
        <h1>Error!</h1>
        <p>Ha ocurrido un error al procesar su solicitud.</p>
        
        <% 
            // Verificar si hay sesión activa
            String usuario = (String) session.getAttribute("usuario");
            
            if(usuario == null) {
                // No hay sesión activa
        %>
                <p><a href="http://localhost:8080/Practica2AD/Login.jsp">Volver al Login</a></p>
        <% 
            } else {
                // Hay sesión activa
        %>
                <p><a href="http://localhost:8080/Practica2AD/menu.jsp">Volver al Menú</a></p>
        <% 
            }
        %>
    </body>
</html>
