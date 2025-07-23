<%-- 
    Document   : admin
    Created on : Mar 9, 2025, 10:51:28 PM
    Author     : LENOVO
--%>

<%@page import="utils.AuthUtils"%>
<%@page import="dto.UserDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin DashBoard</title>
        <link rel="icon" type="assets/image/jpg" href="<%= request.getContextPath() %>/assets/image/z6344218901443_e4fd8ed41ec42487b1140ea5a3e4832d.jpg">
        <style>
            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
                width: 100%;
                font-family: 'Arial', sans-serif;
            }

            body {
                background-image: url('<%= request.getContextPath() %>/assets/image/1551360_2.jpg') !important;
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
/*                background: rgba(0, 0, 0, 0.1);*/
            }

            .admin-container {
                display: flex;
                min-height: 100vh;
                border-radius: 10px;
                margin: 20px;
            }
            
            .main-content-admin {
                flex: 1;
                padding: 20px;
                display: flex;
                flex-direction: column; /* Chuyển sang column để xếp dọc */
                background: transparent; /* Đảm bảo trong suốt để thấy hình nền */
            }
            
            h2.welcome-header-admin {
                color: #2c3e50;
                border-bottom: 2px solid #3498db;
                padding-bottom: 10px;
                margin: 0 0 20px 100px; /* Thêm margin-left: 100px */
                text-align: center;
                background: rgba(255, 255, 255, 0.9);
                padding: 10px;
                border-radius: 5px;
                max-width: calc(100% - 120px); /* Giới hạn chiều rộng để không tràn ra ngoài */
            }

            .content-wrapper {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center; /* Căn giữa nội dung chính */
            }

            .sidebar {
                width: 240px;
                height: 100vh;
                background-image: url('<%= request.getContextPath() %>/assets/image/Forza-Horizon-5-Xbox-Game-Studios-2252690.jpg');
                background-size: cover;
                background-position: center;
                padding: 20px;
                position: fixed;
                top: 0;
                left: 0;
                z-index: 1000;
            }

            .sidebar h2 {
                font-size: 24px;
                margin-bottom: 20px;
                color: white;
            }

            .sidebar ul {
                list-style: none;
                padding: 0;
            }

            .sidebar ul li {
                margin: 15px 0;
            }

            .sidebar ul li a {
                color: white;
                text-decoration: none;
                font-size: 18px;
            }

            .sidebar ul li a:hover {
                color: #ffcc00;
            }


            .error-permission {
                background: #ffebee;
                padding: 20px;
                border-radius: 5px;
                color: #c0392b;
                text-align: center;
            }

            .error-permission a {
                color: #2980b9;
                text-decoration: none;
                font-weight: bold;
            }

            .error-permission a:hover {
                text-decoration: underline;
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(-20px); }
                to { opacity: 1; transform: translateY(0); }
            }
        </style>
    </head>
    <body> 


        <div class="admin-container">
            <%-- Include Sidebar --%>
            <%@ include file="slidebar.jsp" %>

            <%-- Nội dung chính --%>
            <div class="main-content-admin">
                <% 
                    UserDTO user = (UserDTO) session.getAttribute("user");
                    if (user != null && AuthUtils.isAdmin(session)) { 
                        String fullname = user.getFullname() != null ? user.getFullname() : "Admin";
                %>
                    <h2 class="welcome-header-admin">Welcome, <%= fullname %></h2>
                <% } else { %>
                    <div class="error-permission">
                        <p>You do not have permission to access this content.</p>
                        <a href="login.jsp">Please Login As Admin To Continue</a>
                    </div>
                <% 
                    } 
                %>
                <div class="content-wrapper">
                    <%
                        String pageParam = request.getParameter("page");
                        if (pageParam == null) pageParam = "home";
                        switch (pageParam) {
                            case "home":
                    %>
                                <jsp:include page="adminHome.jsp"/>
                    <%          break;
                            case "searchUser":
                    %>
                                <jsp:include page="searchUser.jsp"/>
                    <%          break;
                            case "searchGame":
                    %>
                                <jsp:include page="searchGame.jsp"/>
                    <%          break;
                            case "manageCart":
                    %>
                                <jsp:include page="manageCart.jsp"/>
                    <%          break;
                            case "settings":
                    %>
                                <jsp:include page="setting.jsp"/>
                    <%          break;
                            default:
                    %>
                                <h2>...</h2>
                    <%      }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>

