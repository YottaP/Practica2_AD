<%-- 
    Document   : menu
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
    <title>FIBterest - Menú Principal</title>
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
            max-width: 900px;
            margin: 50px auto;
            padding: 0 20px;
        }
        
        .welcome-section {
            background: #fff9f0;
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 40px;
            box-shadow: 0 10px 40px rgba(139, 90, 43, 0.3);
            border: 2px solid #d4a574;
            text-align: center;
        }
        
        .welcome-section h1 {
            color: #8b5a2b;
            font-size: 2.5em;
            margin-bottom: 15px;
        }
        
        .welcome-section p {
            color: #a0826d;
            font-size: 1.1em;
        }
        
        /* Grid de opciones */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .menu-item {
            background: #fff9f0;
            border-radius: 15px;
            padding: 35px 25px;
            text-align: center;
            text-decoration: none;
            color: #8b5a2b;
            transition: all 0.3s ease;
            box-shadow: 0 5px 20px rgba(139, 90, 43, 0.2);
            border: 2px solid #d4a574;
        }
        
        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(139, 90, 43, 0.35);
            border-color: #8b5a2b;
        }
        
        .menu-icon {
            font-size: 3em;
            margin-bottom: 15px;
            display: block;
        }
        
        .menu-item h3 {
            font-size: 1.3em;
            margin-bottom: 10px;
            color: #8b5a2b;
        }
        
        .menu-item p {
            color: #a0826d;
            font-size: 0.95em;
            line-height: 1.5;
        }
        
        .logout-section {
            text-align: center;
            margin-top: 40px;
        }
        
        .logout-btn {
            background: linear-gradient(135deg, #c85a54 0%, #a04842 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(200, 90, 84, 0.3);
        }
        
        .logout-btn:hover {
            background: linear-gradient(135deg, #a04842 0%, #8b3c37 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(200, 90, 84, 0.4);
        }
        
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .user-section {
                width: 100%;
            }
            
            .menu-grid {
                grid-template-columns: 1fr;
            }
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
        <div class="welcome-section">
            <h1>Menú Principal</h1>
            <p>Gestiona tu colección de imágenes de forma sencilla</p>
        </div>
        
        <div class="menu-grid">
            <a href="registrarImagen.jsp" class="menu-item">
                <span class="menu-icon">➕</span>
                <h3>Registrar Imagen</h3>
                <p>Añade nuevas imágenes a tu colección</p>
            </a>
            
            <a href="buscarImagen.jsp" class="menu-item">
                <span class="menu-icon">🔍</span>
                <h3>Buscar Imágenes</h3>
                <p>Encuentra imágenes por diferentes criterios</p>
            </a>
            
            <form action="BuscarImagen" method="POST" style="display: contents;">
                <button type="submit" class="menu-item menu-item-button">
                    <span class="menu-icon">📋</span>
                    <h3>Listar Imágenes</h3>
                    <p>Visualiza todas las imágenes disponibles</p>
                </button>
            </form>
        </div>
        
        <div class="logout-section">
            <form action="Logout" method="POST">
                <button type="submit" class="logout-btn">🚪 Cerrar Sesión</button>
            </form>
        </div>
    </div>
</body>
</html>