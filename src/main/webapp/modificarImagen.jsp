<%-- 
    Document   : modificarImagen
    Created on : 13 oct 2025, 12:11:11
    Author     : alumne
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.Image"%>
<%@page import="db.Database"%>
<%
    // Verificar si hay sesión activa
    String usuario = (String) session.getAttribute("usuario");
    if(usuario == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    int id = Integer.parseInt(request.getParameter("id"));
    Database db = new Database();
    Image imagen = db.retornaImagen(id);
    
    if(imagen == null || !imagen.getCreator().equals(usuario)) {
        db.Shutdown();
        response.sendRedirect("error.jsp");
        return;
    }
    
    db.Shutdown();
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>FIBterest - Modificar Imagen</title>
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
            max-width: 700px;
            margin: 50px auto;
            padding: 0 20px;
        }
        
        .form-section {
            background: #fff9f0;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(139, 90, 43, 0.3);
            border: 2px solid #d4a574;
        }
        
        .form-section h1 {
            color: #8b5a2b;
            font-size: 2.2em;
            margin-bottom: 10px;
            text-align: center;
        }
        
        .form-section .subtitle {
            color: #a0826d;
            font-size: 1em;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            color: #8b5a2b;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 1em;
        }
        
        .form-group input[type="text"],
        .form-group input[type="date"],
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #d4a574;
            border-radius: 10px;
            font-size: 1em;
            font-family: inherit;
            background: white;
            color: #5a4a3a;
            transition: all 0.3s ease;
        }
        
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #8b5a2b;
            box-shadow: 0 0 0 3px rgba(139, 90, 43, 0.1);
        }
        
        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .submit-btn {
            flex: 1;
            background: linear-gradient(135deg, #8b5a2b 0%, #a0826d 100%);
            color: #fff9f0;
            border: none;
            padding: 14px 30px;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(139, 90, 43, 0.3);
        }
        
        .submit-btn:hover {
            background: linear-gradient(135deg, #6d4522 0%, #8b5a2b 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(139, 90, 43, 0.4);
        }
        
        .back-btn {
            flex: 1;
            background: #e0cdb3;
            color: #8b5a2b;
            border: 2px solid #d4a574;
            padding: 14px 30px;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            display: inline-block;
        }
        
        .back-btn:hover {
            background: #d4a574;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(139, 90, 43, 0.2);
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
        <div class="form-section">
            <h1>Modificar Imagen</h1>
            <p class="subtitle">Actualiza los datos de tu imagen</p>
            
            <form action="modificarImagen" method="POST">
                <input type="hidden" name="id" value="${param.id}">
                
                <div class="form-group">
                    <label for="title">Título:</label>
                    <input type="text" id="title" name="title" 
                           placeholder="<%= imagen.getTitle() %>">
                </div>
                
                <div class="form-group">
                    <label for="description">Descripción:</label>
                    <textarea id="description" name="description" placeholder="<%= imagen.getDescription() %>"></textarea>
                </div>
                
                <div class="form-group">
                    <label for="keywords">Palabras clave:</label>
                    <input type="text" id="keywords" name="keywords" 
                           placeholder="<%= imagen.getKeywords() %>">
                </div>
                
                <div class="form-group">
                    <label for="author">Autor:</label>
                    <input type="text" id="author" name="author"
                           placeholder="<%= imagen.getAuthor() %>">
                </div>
                
                <div class="form-group">
                    <label for="capture_date">Fecha de captura:</label>
                    <input type="date" id="capture_date" name="capture_date"
                           value="<%= imagen.getCaptureDate().replace("/", "-") %>">
                </div>
                
                <div class="button-group">
                    <a href="menu.jsp" class="back-btn">Volver al menú</a>
                    <button type="submit" class="submit-btn">Actualizar Imagen</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>