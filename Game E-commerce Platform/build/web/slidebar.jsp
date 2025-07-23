<%-- 
    Document   : slidebar
    Created on : Mar 24, 2025, 9:21:58 PM
    Author     : LENOVO
--%>

<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Slide Bar</title>
        <style>
            .sidebar {
                width: 250px;
                height: 100vh;
                background-image: url('assets/image/Forza-Horizon-5-Xbox-Game-Studios-2252690.jpg');
                background-size: cover;
                background-position: center;
                padding: 20px;
                position: fixed;
                top: 0;
                left: 0;
                z-index: 1500;
                box-shadow: 5px 0 15px rgba(0, 0, 0, 0.5); /* Bóng mờ ở cạnh phải */
            }
            
            .sidebar h2 {
                font-size: 24px;
                margin-bottom: 20px;
                background: rgba(0, 0, 0, 0.5);
                color: gold;
                padding: 10px;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.6);
                border-radius: 5px;
            }

            .sidebar ul {
                list-style: none;
                padding: 10px;
                gap: 10px;
            }

            .sidebar ul li {
                margin: 15px 0;
                background: rgba(0, 0, 0, 0.5); /* Nền tối nhẹ để làm rõ chữ */
                padding: 10px;
                border-radius: 5px; /* Bo góc nhẹ */
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.6); /* Bóng mờ */
                transition: all 0.3s ease-in-out;
            }

            .sidebar ul li a {
                color: white;
                text-decoration: none;
                font-weight: bold;
                font-size: 18px;
            }

            .sidebar ul li a:hover {
                color: #ffcc00;
                font-weight: bold;
                transform: scale(1.05);
            }
            
        </style>
    </head>
    <body>
        <div class="sidebar">
                <h2>Admin DashBoard</h2>
            <ul>
                <li><a href="admin.jsp">Trang Chủ</a></li>
                <li><a href="index.jsp">Trang Chính</a></li>
                <li><a href="MainController?page=searchUser">🔍 Tìm kiếm User</a></li>
                <li><a href="GameController?page=searchGame">🎮 Tìm kiếm Game</a></li>
                <li><a href="admin.jsp?page=manageCart">📝 Quản lý Mua Hàng</a></li>
                <li><a href="admin.jsp?page=settings">Cài đặt</a></li>
                <li><a href="MainController?action=logout">Đăng xuất</a></li>


            </ul>
        </div>
    </body>
</html>
