<%-- 
    Document   : login
    Created on : Feb 13, 2025, 11:03:43 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng nhập</title>
        <style>
            html, body {
                margin: 0;
                padding: 0;
                height: 100%; /* để 100% chiều cao trình duyệt */
                overflow: hidden; /* ngăn cuộn toàn bộ */
            }
            .login-container {
                background-image: url('assets/image/4cfe81c9de0c66031c6d861092f00966.jpg');
                background-size: cover;
                background-position: center;
                width: 100%; /* full width */
                height: 100vh; /* full height of viewport */
                display: flex;
                position: relative;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }
            
            .banner-container {
                flex: 1;
                margin-left: 250px;
                position: absolute;
                margin-right: 900px;
                
            }
            
            .banner {
                max-width: 300px;
                height: auto;
                object-fit: contain;
                flex: 1;
            }
            
            .login-form {
                background-image: url('assets/image/modern-dark-gaming-background-with-orange-neon-light-panel-free-vector.jpg');
                background-size: cover;
                background-position: center;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                position: absolute;
                margin-right: 200px;
                right: 0;
                top: 50%; /* Optional: Center vertically */
                transform: translateY(-50%); /* Optional: Adjust vertical alignment */
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #333;
            }

            .form-group input {
                width: 95%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
                transition: border-color 0.3s;
            }

            .form-group input:focus {
                border-color: #4CAF50;
                outline: none;
            }

            .submit-btn {
                background-color: #4CAF50;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
                transition: background-color 0.3s;
            }

            .submit-btn:hover {
                background-color: #45a049;
            }

            .form-title {
                text-align: center; 
                margin-bottom: 30px;
                color: #333;
            }
            
            h4 {
                justify-content: center;
                align-items: center;    

            }
            
            h4 a{
                text-decoration: none;
                color: red;
            }
            
            h4 a:hover{
                color: yellow;
                transition-duration:  0.5s;
            }
            
            h3 {
                justify-content: center;
                align-items: center;    

            }
            
            h3 a{
                text-decoration: none;
                color: red;
            }
            
            h3 a:hover{
                color: blue;
                transition-duration:  0.5s;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="banner-container">
                <img class="banner" src="assets/image/e1d978bb4df4cf44a79a227f4180c6b5.png" alt="Banner">
            </div>
            <div class="login-form">
                <h2 class="form-title" style="color: red">Đăng nhập</h2>
                <form action="MainController" method="post">
                    <input type="hidden" name="action" value="login" />

                    <div class="form-group">
                        <label for="userId">Tên đăng nhập</label>
                        <input type="text" id="userId" name="txtUserID" required />
                    </div>

                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" name="txtPassword" required />
                    </div>

                    <button type="submit" class="submit-btn">Đăng nhập</button>
                    <h3 style="color: white">
                        <a href="registers.jsp">Register</a> / <a href="forgotPassword.jsp">Forgot Password?</a>
                    </h3>
                    <h4 style="color: white">
                        Back to <a href="index.jsp">Menu</a>  / Use as <a href="menu.jsp">Guest</a>
                    </h4>
                    <%
                        String message = request.getAttribute("message")+"";
                    %>
                    <p style="color: red"><%=message.equals("null")?"":message%></p>
                </form>
            </div>
        </div>
    </body>
</html>