<%-- 
    Document   : Login
    Created on : 17 sept 2025, 16:22:47
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
         <form action = "Login" method = "POST">
            <!-- Añadir los campos del formulario que creas conveniente -->
            <label for="user">Introduzca el usuario:</label><br>
            <input type="text" id="user" name="user" required><br>
            <label for="password">Introduzca la contraseña:</label><br>
            <input type="text" id="password" name="password" required><br>
            <input type="submit" value="Submit">
         </form>
    </body>
</html>
