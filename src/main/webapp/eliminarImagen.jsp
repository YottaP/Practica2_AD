<%-- 
    Document   : eliminarImagen
    Created on : 17 oct 2025, 23:06:57
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
    <title>FIBterest - Eliminar Imagen</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5e6d3 0%, #d4a574 100%);
            min-height: 100vh;
            padding: 0;
        }
        
        /* Header con usuario */
        .header {
            background: linear-gradient(135deg, #8b5a2b 0%, #a0826d 100%);
            padding: 15px 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            color: #fff9f0;
            font-size: 1.8em;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .red-i {
            color: #ff6b6b;
        }
        
        .user-section {
            background: rgba(255, 249, 240, 0.15);
            padding: 15px 20px;
            border-radius: 12px;
            text-align: right;
            border: 1px solid rgba(255, 249, 240, 0.3);
        }
        
        .user-info {
            color: #fff9f0;
            font-size: 0.95em;
            margin-bottom: 10px;
            font-weight: 500;
        }
        
        .user-name {
            font-weight: 700;
            font-size: 1.1em;
        }
        
        .my-images-btn {
            background: #fff9f0;
            color: #8b5a2b;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.95em;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        
        .my-images-btn:hover {
            background: #f5e6d3;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }
        
        /* Contenedor principal */
        .main-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 0 20px;
        }
        
        .confirmation-box {
            background: #fff9f0;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(139, 90, 43, 0.3);
            border: 2px solid #d4a574;
            text-align: center;
        }
        
        .warning-icon {
            font-size: 4em;
            margin-bottom: 20px;
            display: block;
        }
        
        .confirmation-box h2 {
            color: #8b5a2b;
            font-size: 1.8em;
            margin-bottom: 20px;
        }
        
        .image-id {
            background: rgba(139, 90, 43, 0.1);
            padding: 15px;
            border-radius: 10px;
            margin: 25px 0;
            border: 1px solid #d4a574;
        }
        
        .image-id strong {
            color: #8b5a2b;
            font-size: 1.1em;
        }
        
        .image-id span {
            color: #a0826d;
            font-size: 1.2em;
            font-weight: 600;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }
        
        .btn {
            padding: 12px 30px;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-delete {
            background: linear-gradient(135deg, #c85a54 0%, #a04842 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(200, 90, 84, 0.3);
        }
        
        .btn-delete:hover {
            background: linear-gradient(135deg, #a04842 0%, #8b3c37 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(200, 90, 84, 0.4);
        }
        
        .btn-cancel {
            background: linear-gradient(135deg, #a0826d 0%, #8b5a2b 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(139, 90, 43, 0.3);
        }
        
        .btn-cancel:hover {
            background: linear-gradient(135deg, #8b5a2b 0%, #6d4422 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(139, 90, 43, 0.4);
        }
        

    </style>
</head>
<body>
    <div class="header">
        <div class="logo">
            <span>📸</span>
            <span>F<span class="red-i">I</span>Bterest</span>
        </div>
        <div class="user-section">
            <div class="user-info">
                Usuario actual: <span class="user-name"><%= usuario %></span>
            </div>
            <form action="BuscarImagen" method="POST" style="display: inline;">
                <input type="hidden" name="creator" value="<%= usuario %>">
                <button type="submit" class="my-images-btn">📁 Mis Imágenes</button>
            </form>
        </div>
    </div>
    
    <div class="main-container">
        <div class="confirmation-box">
            <span class="warning-icon">⚠️</span>
            <h2>¿Seguro que quieres borrar esta imagen?</h2>
            
            <div class="image-id">
                <strong>ID de la imagen:</strong> <span>${param.id}</span>
            </div>
            
            <div class="button-group">
                <form action="eliminarImagen" method="POST" style="display: inline;">
                    <input type="hidden" name="id" value="${param.id}">
                    <button type="submit" class="btn btn-delete">🗑️ Sí, borrar</button>
                </form>
                
                <a href="menu.jsp" class="btn btn-cancel">❌ Cancelar</a>
            </div>
        </div>
    </div>
</body>
</html>