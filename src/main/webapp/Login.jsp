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
    <title>FIBterest - Login</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .login-container {
            background: #fff9f0;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(139, 90, 43, 0.3);
            padding: 50px 40px;
            width: 100%;
            max-width: 450px;
            border: 2px solid #d4a574;
        }
        
        .logo-section {
            text-align: center;
            margin-bottom: 40px;
        }
        
        h1 {
            color: #8b5a2b;
            font-size: 2.5em;
            margin-bottom: 10px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(139, 90, 43, 0.1);
        }
        
        .red-i {
            color: #c85a54;
        }
        
        .subtitle {
            color: #a0826d;
            font-size: 1em;
            margin-top: 5px;
        }
        
        .login-form {
            margin-top: 30px;
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
        input[type="password"] {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #d4a574;
            border-radius: 10px;
            font-size: 1em;
            background: #ffffff;
            color: #5d4037;
            transition: all 0.3s ease;
        }
        
        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #8b5a2b;
            box-shadow: 0 0 0 3px rgba(139, 90, 43, 0.1);
            background: #fffbf5;
        }
        
        input[type="submit"] {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #8b5a2b 0%, #a0826d 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            box-shadow: 0 4px 15px rgba(139, 90, 43, 0.3);
        }
        
        input[type="submit"]:hover {
            background: linear-gradient(135deg, #6d4423 0%, #8b5a2b 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(139, 90, 43, 0.4);
        }
        
        input[type="submit"]:active {
            transform: translateY(0);
        }
        
        .decorative-icon {
            font-size: 3em;
            margin-bottom: 15px;
        }
        
        @media (max-width: 480px) {
            .login-container {
                padding: 40px 30px;
            }
            
            h1 {
                font-size: 2em;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo-section">
            <div class="decorative-icon">📸</div>
            <h1>Welcome to F<span class="red-i">I</span>Bterest!</h1>
            <p class="subtitle">Your photo database platform</p>
        </div>
        
        <form action="Login" method="POST" class="login-form">
            <div class="form-group">
                <label for="user">Usuario:</label>
                <input type="text" id="user" name="user" required placeholder="Introduce tu usuario">
            </div>
            
            <div class="form-group">
                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" required placeholder="Introduce tu contraseña">
            </div>
            
            <input type="submit" value="Iniciar Sesión">
        </form>
    </div>
</body>
</html>