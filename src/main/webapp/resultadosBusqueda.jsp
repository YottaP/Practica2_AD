<%-- 
    Document   : resultadosBusqueda
    Created on : Oct 2025
    Author     : alumne
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="clases.Image"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%
    // Verificar si hay sesión activa
    String usuarioActual = (String) session.getAttribute("usuario");
    if(usuarioActual == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    // Obtener resultados del request
    List<Image> resultados = (List<Image>) request.getAttribute("resultados");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>FIBterest - Resultados de Búsqueda</title>
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
            max-width: 1400px;
            margin: 50px auto;
            padding: 0 20px;
        }
        
        .results-container {
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
        
        .results-info {
            text-align: center;
            color: #a0826d;
            margin-bottom: 30px;
            font-size: 1.1em;
        }
        
        .results-info strong {
            color: #8b5a2b;
        }
        
        .no-results {
            text-align: center;
            padding: 60px 20px;
        }
        
        .no-results-icon {
            font-size: 4em;
            margin-bottom: 20px;
        }
        
        .no-results p {
            color: #a0826d;
            font-size: 1.2em;
            margin-bottom: 30px;
        }
        
        /* Tabla de resultados */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        
        th {
            background: linear-gradient(135deg, #8b5a2b 0%, #a0826d 100%);
            color: #fff9f0;
            padding: 15px 10px;
            text-align: left;
            font-weight: 600;
            font-size: 0.95em;
        }
        
        th:first-child {
            border-radius: 10px 0 0 0;
        }
        
        th:last-child {
            border-radius: 0 10px 0 0;
        }
        
        td {
            padding: 12px 10px;
            border-bottom: 1px solid #e0d4c8;
            color: #5d4037;
        }
        
        tr:last-child td {
            border-bottom: none;
        }
        
        tr:hover {
            background: #fffbf5;
        }
        
        .actions-cell {
            text-align: center;
        }
        
        .actions-cell a {
            color: #8b5a2b;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        
        .actions-cell a:hover {
            color: #6d4423;
            text-decoration: underline;
        }
        
        .actions-cell a.delete {
            color: #c85a54;
        }
        
        .actions-cell a.delete:hover {
            color: #a04842;
        }
        
        /* Botones de navegación */
        .nav-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }
        
        .nav-btn {
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .nav-btn.primary {
            background: linear-gradient(135deg, #8b5a2b 0%, #a0826d 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(139, 90, 43, 0.3);
        }
        
        .nav-btn.primary:hover {
            background: linear-gradient(135deg, #6d4423 0%, #8b5a2b 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(139, 90, 43, 0.4);
        }
        
        .nav-btn.secondary {
            background: #e0d4c8;
            color: #8b5a2b;
            box-shadow: 0 4px 15px rgba(139, 90, 43, 0.2);
        }
        
        .nav-btn.secondary:hover {
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
                Usuario actual: <span class="user-name"><%= usuarioActual %></span>
            </div>
            <form action="BuscarImagen" method="POST" style="display: inline;">
                <input type="hidden" name="creator" value="<%= usuarioActual %>">
                <button type="submit" class="my-images-btn">📁 Mis Imágenes</button>
            </form>
        </div>
    </div>
    
    <div class="main-container">
        <div class="results-container">
            <h1>Resultados de Búsqueda</h1>
            
            <% if(resultados == null || resultados.isEmpty()) { %>
                <div class="no-results">
                    <div class="no-results-icon">🔍</div>
                    <p><strong>No se encontraron imágenes con los criterios especificados.</strong></p>
                </div>
            <% } else { %>
                <div class="results-info">
                    Se encontraron <strong><%= resultados.size() %></strong> imagen(es)
                </div>
                
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Título</th>
                            <th>Descripción</th>
                            <th>Palabras Clave</th>
                            <th>Autor</th>
                            <th>Creador</th>
                            <th>Fecha Captura</th>
                            <th>Fecha Almacenamiento</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                        
                        for(Image img : resultados) { 
                            String captureDate = "";
                            String storageDate = "";
                            
                            try {
                                if(img.getCaptureDate() != null && !img.getCaptureDate().trim().isEmpty()) {
                                    LocalDate date = LocalDate.parse(img.getCaptureDate().trim(), inputFormatter);
                                    captureDate = date.format(outputFormatter);
                                }
                            } catch(Exception e) {
                                captureDate = img.getCaptureDate();
                            }
                            
                            try {
                                if(img.getStorageDate() != null && !img.getStorageDate().trim().isEmpty()) {
                                    LocalDate date = LocalDate.parse(img.getStorageDate().trim(), inputFormatter);
                                    storageDate = date.format(outputFormatter);
                                }
                            } catch(Exception e) {
                                storageDate = img.getStorageDate();
                            }
                        %>
                        <tr>
                            <td><%= img.getID() %></td>
                            <td><%= img.getTitle() != null ? img.getTitle() : "" %></td>
                            <td><%= img.getDescription() != null ? img.getDescription() : "" %></td>
                            <td><%= img.getKeywords() != null ? img.getKeywords() : "" %></td>
                            <td><%= img.getAuthor() != null ? img.getAuthor() : "" %></td>
                            <td><%= img.getCreator() != null ? img.getCreator() : "" %></td>
                            <td><%= captureDate %></td>
                            <td><%= storageDate %></td>
                            <td class="actions-cell">
                                <% if(img.getCreator() != null && img.getCreator().equals(usuarioActual)) { %>
                                    <a href="modificarImagen.jsp?id=<%= img.getID() %>">Modificar</a> | 
                                    <a href="eliminarImagen.jsp?id=<%= img.getID() %>" class="delete"> Eliminar</a>
                                <% } else { %>
                                    -
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
            
            <div class="nav-buttons">
                <a href="buscarImagen.jsp" class="nav-btn primary">Nueva Búsqueda</a>
                <a href="menu.jsp" class="nav-btn secondary">Volver al menú</a>
            </div>
        </div>
    </div>
</body>
</html>