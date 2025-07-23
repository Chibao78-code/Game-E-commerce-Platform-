<%-- 
    Document   : searchUser
    Created on : Mar 24, 2025, 9:36:23 PM
    Author     : LENOVO
--%>

<%@page import="utils.AuthUtils"%>
<%@page import="java.util.List"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search User</title>
        <style>
            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
                width: 100%;
                font-family: 'Arial', sans-serif;
            }
            
            .main-content {
                margin-left: 220px; /* Đẩy nội dung sang phải, lớn hơn chiều rộng slide bar */
                padding: 20px; /* Thêm padding cho đẹp */
            }
            
            body {
                background: url('assets/image/1551360_383.jpg') no-repeat center center fixed;
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
/*                background: rgba(0, 0, 0, 0.1);*/
            }
            
            /* Style từ searchUser.jsp, lược bỏ .container và .main-content */
            .search-container {
                top: 0;
                left: 290px; /* Đẩy sang phải để tránh slide bar */
                width: calc(100% - 220px); /* Chiếm toàn bộ chiều rộng còn lại */
                background: white; /* Nền để dễ nhìn */
                padding: 10px;
                z-index: 1000; /* Đảm bảo nằm trên các phần tử khác */
                display: flex;
                margin-left: 12px;
                align-items: center;
                gap: 10px;
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            .search-container label {
                font-size: 16px;
                color: purple;
                font-weight: bold;
                text-transform: uppercase;
            }

            .search-container input[type="text"] {
                padding: 10px;
                width: 350px;
                border: 2px solid #00ccff;
                border-radius: 5px;
                background-color: white;
                color: #000;
                font-size: 14px;
            }

            .search-btn {
                padding: 10px 20px;
                background: linear-gradient(90deg, #00ccff, #ff00ff);
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .search-btn:hover {
                transform: scale(1.05);
                box-shadow: 0 0 15px rgba(255, 0, 255, 0.5);
            }
            
            h3 {
                font-size: 24px;
                margin-bottom: 20px;
                color:#ff00ff;
                padding: 5px 0;
            }
            
            h3 span{
                background: linear-gradient(90deg, #00ccff, #ff00ff);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                font-size: 24px;
                margin-bottom: 20px;
                padding: 5px 0;
            }
        
            .table-wrapper {
                overflow-x: auto;
                border-radius: 12px;
                padding: 15px;
                margin-left: 10px;
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 12px;
                overflow: hidden;
                backdrop-filter: blur(10px);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            }

            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid rgba(255, 255, 255, 0.3);
                color: white;
            }

            th {
                background: linear-gradient(90deg, #00ccff, #007bff);
                color: white;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            td {
                color: black;
            }
            
            td a{
                text-decoration: none;
                color: black;
                font-weight: bold;
            }
            
            td a:hover{
                color: pink;
                transition-duration: 0.3s;
            }
            
            td {
                background-color: rgba(255, 255, 255, 0.1);
                transition: background 0.3s ease-in-out;
            }

            table tr:hover {
                background-color: rgba(0, 188, 212, 0.3);
                transform: scale(1.02);
            }

            .no-results {
                color: red;
                font-style: italic;
                font-size: 16px;
                text-align: center;
                padding: 20px;
            }
            
            
        </style>
    </head>
    <body>
        <div class="search-user-content">
            <div class="container">
                <%@ include file="/slidebar.jsp" %>
                <!-- Main Content -->
                <div class="main-content">
                    <% if (session.getAttribute("user") != null && AuthUtils.isAdmin(session)) { %>
                    <% String searchTerm = (request.getAttribute("searchTerm") != null) ? (String) request.getAttribute("searchTerm") : ""; %>

                    <!-- Search Form -->
                    <div class="search-container">
                        <form action="MainController" method="GET">
                            <input type="hidden" name="action" value="searchUser"/>
                            <input type="hidden" name="page" value="searchUser"/> <!-- Giữ pageParam -->
                            <label for="tableSearch">Search Users:</label>
                            <input type="text" id="tableSearch" name="searchTerm" value="<%= searchTerm %>" placeholder="Nhập UserID, UserName, hoặc Role...">
                            <input type="submit" value="Search" class="search-btn"/>
                        </form>
                            <h3>Kết quả tìm kiếm cho <span style="color: red"><%=searchTerm%></span></h3>
                    </div>

                    <!-- User Table -->
                    <% if (request.getAttribute("users") != null) {
                        List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
                        if (!users.isEmpty()) { %>
                        <div class="table-wrapper">
                            <table border="1" cellspacing="0" cellpadding="5" id="userTable">
                                <thead>
                                    <tr>
                                        <th>UserID</th>
                                        <th>UserName</th>
                                        <th>FullName</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Role</th>
                                        <th>CreatedAt</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    for (UserDTO u : users) { %>
                                    <tr>
                                        <td><%= u.getUserId() %></td>
                                        <td><%= u.getUsername() %></td>
                                        <td><%= u.getFullname() %></td>
                                        <td><%= u.getEmail() %></td>
                                        <td><%= u.getPhone() %></td>
                                        <td><%= u.getAddress() %></td>
                                        <td><%= u.getRole() %></td>
                                        <td><%= u.getCreatedAt() %></td>
                                        <td>
                                            <a href="<%= request.getContextPath() %>/UserController?action=deleteUser&userID=<%= u.getUserId() %>" 
                                               onclick="return confirm('Bạn có chắc muốn xóa user này?')">Delete</a> |
                                            <a href="<%= request.getContextPath() %>/UserController?action=updateUserForm&userID=<%= u.getUserId() %>">Edit</a>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                        <% } else { %>
                            <p class="no-results">No users found.</p>
                        <% } %>
                    <% } %>

                    <% } %>
                </div>
            </div>
        </div>
    </body>
</html>
