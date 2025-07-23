<%-- 
    Document   : registers
    Created on : Mar 25, 2025, 4:51:48 PM
    Author     : LENOVO
--%>

<%-- 
    Document   : registers
    Created on : Mar 25, 2025, 4:51:48 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng ký</title>
        <style>
            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
                overflow: hidden;
            }
            .register-container {
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
            .register-form {
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
        <div class="register-container">
            <div class="register-form">
                <h2 class="form-title">Đăng ký</h2>
                <form action="UserController" method="post">
                    <input type="hidden" name="action" value="register" />

                    <div class="form-group">
                        <label for="username">Tên đăng nhập</label>
                        <input type="text" id="username" name="txtUsername" required />
                    </div>

                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" name="txtPassword" required />
                    </div>

                    <div class="form-group">
                        <label for="fullname">Họ và tên</label>
                        <input type="text" id="fullname" name="txtFullname" required />
                    </div>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="txtEmail" required />
                    </div>

                    <div class="form-group">
                        <label for="phone">Số điện thoại</label>
                        <input type="text" id="phone" name="txtPhone" required />
                    </div>

                    <div class="form-group">
                        <label for="address">Địa chỉ</label>
                        <input type="text" id="address" name="txtAddress" required />
                    </div>

                    <button type="submit" class="submit-btn">Đăng ký</button>
                    <h4>Đã có tài khoản? <a href="login.jsp">Đăng nhập</a></h4>
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
