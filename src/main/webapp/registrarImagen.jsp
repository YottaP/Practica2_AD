<%-- 
    Document   : registrarImagen
    Created on : 8 oct 2025, 15:10:38
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
    <title>FIBterest - Registrar Imagen</title>
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
            text-decoration: none;
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
            max-width: 800px;
            margin: 50px auto;
            padding: 0 20px;
        }
        
        .form-container {
            background: #fff9f0;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(139, 90, 43, 0.3);
            border: 2px solid #d4a574;
        }
        
        h1 {
            color: #8b5a2b;
            font-size: 2.2em;
            margin-bottom: 10px;
            text-align: center;
        }
        
        .subtitle {
            color: #a0826d;
            text-align: center;
            margin-bottom: 35px;
            font-size: 1.05em;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            color: #8b5a2b;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.95em;
        }
        
        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #d4a574;
            border-radius: 10px;
            font-size: 1em;
            background: #ffffff;
            color: #5d4037;
            transition: all 0.3s ease;
            font-family: inherit;
        }
        
        textarea {
            min-height: 100px;
            resize: vertical;
        }
        
        input[type="text"]:focus,
        input[type="date"]:focus,
        textarea:focus {
            outline: none;
            border-color: #8b5a2b;
            box-shadow: 0 0 0 3px rgba(139, 90, 43, 0.1);
            background: #fffbf5;
        }
        
        input[type="file"] {
            width: 100%;
            padding: 12px;
            border: 2px dashed #d4a574;
            border-radius: 10px;
            background: #ffffff;
            color: #5d4037;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        input[type="file"]:hover {
            border-color: #8b5a2b;
            background: #fffbf5;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 35px;
        }
        
        input[type="submit"],
        .back-btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        input[type="submit"] {
            background: linear-gradient(135deg, #8b5a2b 0%, #a0826d 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(139, 90, 43, 0.3);
        }
        
        input[type="submit"]:hover {
            background: linear-gradient(135deg, #6d4423 0%, #8b5a2b 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(139, 90, 43, 0.4);
        }
        
        .back-btn {
            background: #e0d4c8;
            color: #8b5a2b;
            box-shadow: 0 4px 15px rgba(139, 90, 43, 0.2);
        }
        
        .back-btn:hover {
            background: #d4c4b3;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(139, 90, 43, 0.3);
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="menu.jsp" class="logo">
            <span>📸</span>
            <span>F<span class="red-i">I</span>Bterest</span>
        </a>
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
        <div class="form-container">
            <h1>➕ Registrar Nueva Imagen</h1>
            <p class="subtitle">Completa los datos de la imagen que deseas añadir</p>
            
            <form action="registrarImagen" method="POST" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="title">Título:</label>
                    <input type="text" id="title" name="title" required placeholder="Ingresa el título de la imagen">
                </div>
                
                <div class="form-group">
                    <label for="description">Descripción:</label>
                    <textarea id="description" name="description" required placeholder="Describe la imagen"></textarea>
                </div>
                
                <div class="form-group">
                    <label for="keywords">Palabras clave:</label>
                    <input type="text" id="keywords" name="keywords" required placeholder="Ej: naturaleza, paisaje, montaña">
                </div>
                
                <div class="form-group">
                    <label for="author">Autor:</label>
                    <input type="text" id="author" name="author" required placeholder="Nombre del autor de la imagen">
                </div>
                
                <div class="form-group">
                    <label for="capture_date">Fecha de captura:</label>
                    <input type="date" id="capture_date" name="capture_date" required>
                </div>
                
                <div class="form-group">
                    <label for="imagen">Seleccionar archivo de imagen:</label>
                    <input type="file" id="imagen" name="imagen" required accept="image/*">
                </div>
                
                <div class="button-group">
                    <input type="submit" value="Registrar Imagen">
                    <a href="menu.jsp" class="back-btn">Volver al menú</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>