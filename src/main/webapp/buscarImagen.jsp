<%-- 
    Document   : buscarImagen
    Created on : 14 oct 2025, 21:53:42
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
    <title>FIBterest - Buscar Imagen</title>
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
            max-width: 900px;
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
        
        .search-section {
            margin-bottom: 30px;
        }
        
        .section-title {
            color: #8b5a2b;
            font-size: 1.3em;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #d4a574;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 0;
        }
        
        label {
            display: block;
            color: #8b5a2b;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.95em;
        }
        
        input[type="text"],
        input[type="date"] {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #d4a574;
            border-radius: 10px;
            font-size: 0.95em;
            background: #ffffff;
            color: #5d4037;
            transition: all 0.3s ease;
            font-family: inherit;
        }
        
        input[type="text"]:focus,
        input[type="date"]:focus {
            outline: none;
            border-color: #8b5a2b;
            box-shadow: 0 0 0 3px rgba(139, 90, 43, 0.1);
            background: #fffbf5;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 35px;
        }
        
        input[type="submit"],
        input[type="button"] {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
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
        
        input[type="button"] {
            background: #e0d4c8;
            color: #8b5a2b;
            box-shadow: 0 4px 15px rgba(139, 90, 43, 0.2);
        }
        
        input[type="button"]:hover {
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
            <h1>🔍 Buscar Imágenes</h1>
            <p class="subtitle">Ingresa los criterios de búsqueda (deja en blanco para ver todas las imágenes)</p>
            
            <form action="BuscarImagen" method="POST">
                <div class="search-section">
                    <h3 class="section-title">Información General</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="id">ID Imagen:</label>
                            <input type="text" id="id" name="id" placeholder="ID de la imagen">
                        </div>
                        
                        <div class="form-group">
                            <label for="title">Título:</label>
                            <input type="text" id="title" name="title" placeholder="Título de la imagen">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="description">Descripción:</label>
                            <input type="text" id="description" name="description" placeholder="Descripción">
                        </div>
                        
                        <div class="form-group">
                            <label for="keywords">Palabras clave:</label>
                            <input type="text" id="keywords" name="keywords" placeholder="Palabras clave">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="author">Autor:</label>
                            <input type="text" id="author" name="author" placeholder="Nombre del autor">
                        </div>
                        
                        <div class="form-group">
                            <label for="creator">Creador:</label>
                            <input type="text" id="creator" name="creator" placeholder="Usuario creador">
                        </div>
                    </div>
                </div>
                
                <div class="search-section">
                    <h3 class="section-title">Búsqueda por Fechas</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="captureDateFrom">Fecha de captura desde:</label>
                            <input type="date" id="captureDateFrom" name="captureDateFrom">
                        </div>
                        
                        <div class="form-group">
                            <label for="captureDateTo">Fecha de captura hasta:</label>
                            <input type="date" id="captureDateTo" name="captureDateTo">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="storageDateFrom">Fecha de almacenamiento desde:</label>
                            <input type="date" id="storageDateFrom" name="storageDateFrom">
                        </div>
                        
                        <div class="form-group">
                            <label for="storageDateTo">Fecha de almacenamiento hasta:</label>
                            <input type="date" id="storageDateTo" name="storageDateTo">
                        </div>
                    </div>
                </div>
                
                <div class="button-group">
                    <input type="submit" value="Buscar">
                    <input type="button" value="Volver al menú" onclick="location.href='menu.jsp'">
                </div>
            </form>
        </div>
    </div>
</body>
</html>