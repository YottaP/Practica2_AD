<%-- 
    Document   : eliminarImagen
    Created on : 17 oct 2025, 23:06:57
    Author     : alumne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Imagen</title>
    </head>
    <body>
        
        <h2>Quieres borrar esta imagen?</h2>
        
        <p>
        
        <% 
        String usuario = (String) session.getAttribute("usuario");
        if(usuario == null)
            response.sendRedirect("Login.jsp");
        %>
        
            <h2>¿Seguro que quieres borrar esta imagen?</h2>

    <p><b>ID:</b> ${imagen.id}</p>
    <p><b>Título:</b> ${imagen.titulo}</p>
    <p><b>Descripción:</b> ${imagen.descripcion}</p>

    <!-- Formulario que enviará al servlet BorrarImagen -->
    <form action="elimiarImagen" method="post">
        <input type="hidden" name="id" value="${imagen.id}">
        <input type="hidden" name="filename" value="${imagen.filename}">
        <input type="submit" value="Sí, borrar">
    </form>

    </body>
</html>
