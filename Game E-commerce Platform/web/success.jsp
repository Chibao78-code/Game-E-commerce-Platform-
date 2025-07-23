<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mua hàng thành công</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            .nav-bar {
                background-color: #333;
                padding: 10px 0;
            }
            .nav-bar ul {
                list-style-type: none;
                margin: 0;
                padding: 0;
                text-align: center;
            }
            .nav-bar ul li {
                display: inline;
                margin-right: 20px;
            }
            .nav-bar ul li a {
                color: white;
                text-decoration: none;
                font-size: 16px;
            }
            .nav-bar ul li a:hover {
                color: #ffcc00;
            }
            .container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            h2 {
                color: #333;
            }
            .message {
                font-size: 18px;
                color: #28a745;
            }
        </style>
    </head>
    <body>
        <div class="nav-bar">
            <ul>
                <li><a href="index.jsp">Trang Chủ</a></li>
                <li><a href="menu.jsp">Sản phẩm</a></li>
                <li><a href="<%= request.getContextPath() %>/GameController?action=listGenres">Thể loại</a></li>
                <li><a href="cart.jsp">Giỏ hàng</a></li>
                <li><a href="contact.jsp">Liên hệ</a></li>
                <li><a href="MainController?action=logout">Đăng xuất</a></li>
            </ul>
        </div>

        <div class="container">
            <h2>Mua hàng thành công</h2>
            <%
                String message = (String) request.getAttribute("message");
                if (message != null) {
            %>
            <p class="message"><%= message %></p>
            <% } else { %>
            <p class="message">Cảm ơn bạn đã mua sắm!</p>
            <% } %>
            <p><a href="menu.jsp">Tiếp tục mua sắm</a></p>
        </div>
    </body>
</html>