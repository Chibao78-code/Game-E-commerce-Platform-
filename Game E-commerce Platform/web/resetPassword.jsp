<%-- 
    Document   : resetPassword
    Created on : Mar 27, 2025, 9:15:00 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đặt lại mật khẩu</title>
        <style>
            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
                overflow: hidden;
            }
            .reset-container {
                background-image: url('assets/image/4cfe81c9de0c66031c6d861092f00966.jpg');
                background-size: cover;
                background-position: center;
                width: 100%;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }
            .reset-form {
                background-image: url('assets/image/modern-dark-gaming-background-with-orange-neon-light-panel-free-vector.jpg');
                background-size: cover;
                background-position: center;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #fff;
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
                color: red;
            }
            h4 {
                text-align: center;
                color: white;
            }
            h4 a {
                text-decoration: none;
                color: red;
            }
            h4 a:hover {
                color: yellow;
                transition-duration: 0.5s;
            }
        </style>
    </head>
    <body>
        <div class="reset-container">
            <div class="reset-form">
                <h2 class="form-title">Đặt lại mật khẩu</h2>
                <form action="UserController" method="post">
                    <input type="hidden" name="action" value="resetPassword" />
                    <input type="hidden" name="token" value="<%=request.getParameter("token")%>" />

                    <div class="form-group">
                        <label for="password">Mật khẩu mới</label>
                        <input type="password" id="password" name="txtPassword" required />
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu</label>
                        <input type="password" id="confirmPassword" name="txtConfirmPassword" required />
                    </div>

                    <button type="submit" class="submit-btn">Cập nhật mật khẩu</button>
                    <h4>Quay lại <a href="login.jsp">Đăng nhập</a></h4>
                    <%
                        String message = (String) request.getAttribute("message");
                        if (message != null) {
                    %>
                    <p style="color: red; text-align: center;"><%=message%></p>
                    <%
                        }
                    %>
                </form>
            </div>
        </div>
    </body>
</html> 