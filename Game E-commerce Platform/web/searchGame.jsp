<%-- 
    Document   : searchGame
    Created on : Mar 24, 2025, 10:24:49 PM
    Author     : LENOVO
--%>

<%@page import="dto.GameDTO"%>
<%@page import="java.util.List"%>
<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style> 
            body {
                font-family: Arial, sans-serif;
                background: url('assets/image/1551360_383.jpg') no-repeat center center fixed;
                background-size: cover;
                margin: 0;
                padding: 0;
            }

            .main-content {
                margin-left: 220px; /* Đẩy nội dung sang phải, lớn hơn chiều rộng slide bar */
                padding: 20px; /* Thêm padding cho đẹp */
            }

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
            
            .custom-link {
                color: #00ccff;
                font-weight: bold;
                text-decoration: none;
                padding: 5px 12px;
                border-radius: 8px;
                transition: 0.3s;
            }

            .custom-link:hover {
                color: #ff00ff;
                text-shadow: 0 0 12px rgba(255, 0, 255, 0.8);
            }

            /* Cải tiến nút Edit/Delete */
            .action-btn {
                display: inline-block;
                padding: 10px 15px;
                margin: 5px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: bold;
                text-align: center;
                background: linear-gradient(90deg, #00ccff, #ff00ff);
                color: white;
                transition: 0.3s;
                box-shadow: 0 4px 8px rgba(0, 204, 255, 0.5);
            }

            .action-btn:hover {
                transform: scale(1.1);
                box-shadow: 0 0 15px rgba(0, 204, 255, 0.8);
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
            
            th {
                background: linear-gradient(90deg, #00ccff, #007bff);
                color: white;
                text-transform: uppercase;
                letter-spacing: 1px;
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

            .game-image {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 5px;
            }

        </style>
    </head>
    <body>
        <div class="search-game-content">
            <div class="container">
                <%@ include file="/slidebar.jsp" %>
                <!-- Main Content -->
                <div class="main-content">
                    <% if (session.getAttribute("user") != null && AuthUtils.isAdmin(session)) { %>
                    <% String searchTerm = (request.getAttribute("searchTerm") != null) ? (String) request.getAttribute("searchTerm") : ""; %>

                    <!-- Search Form -->
                    <div class="search-container">
                        <form action="GameController" method="GET">
                            <input type="hidden" name="action" value="searchGame"/>
                            <input type="hidden" name="page" value="searchGame"/> <!-- Giữ pageParam -->
                            <label for="tableSearch">Search Games: </label>
                            <input type="text" id="tableSearch" name="searchTerm" value="<%= searchTerm %>" placeholder="Nhập gameid, gameName, hoặc genre ...">
                            <input type="submit" value="Search" class="search-btn"/>
                        </form>
                            <h3>Kết quả tìm kiếm cho <span style="color: red"><%=searchTerm%></span></h3>
                    </div>

                    <!-- Games Table -->
                    <% if (request.getAttribute("games") != null) {
                        List<GameDTO> games = (List<GameDTO>) request.getAttribute("games");
                        System.out.println("searchGame.jsp: games = " + games);
                        System.out.println("searchGame.jsp: games size = " + (games != null ? games.size() : "null"));
                        if (!games.isEmpty()) { %>
                        <div class="table-wrapper">
                            <table border="1" cellspacing="0" cellpadding="5" id="gameTable">
                                <thead>
                                    <tr>
                                        <th>Game ID</th>
                                        <th>Game Name</th>
                                        <th>Price</th>
                                        <th>Release Date</th>
                                        <th>Genre</th>
                                        <th>Platform</th>
                                        <th>Description</th>
                                        <th>Stock</th>
                                        <th>Image</th>
                                        <th>Created At</th>
                                        <th>Updated At</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (GameDTO g : games) { %>
                                    <tr>
                                        <td><%= g.getGameId() %></td>
                                        <td><%= g.getGameName() %></td>
                                        <td><%= g.getPrice() %></td>
                                        <td><%= g.getReleaseDate() %></td>
                                        <td>
                                            <% 
                                                List<String> genres = g.getGenres();
                                                if (genres != null && !genres.isEmpty()) {
                                                    for (int i = 0; i < genres.size(); i++) {
                                                        String genre = genres.get(i);
                                            %>
                                            <a href="<%= request.getContextPath() %>/GameController?action=searchGame&genre=<%= genre %>" class="genre-link">
                                                <%= genre %>
                                            </a>
                                            <% 
                                                if (i < genres.size() - 1) { 
                                                    out.print(", "); 
                                                } 
                                            %>
                                            <% 
                                                }
                                                } else { 
                                                    out.print("N/A"); 
                                                } 
                                            %>
                                        </td>
                                        <td><%= g.getPlatform() %></td>
                                        <td><%= g.getDescription() %></td>
                                        <td><%= g.getStock() %></td>
                                        <td><img src="<%= g.getImageUrl() %>" alt="<%= g.getGameName() %>" class="game-image"></td>
                                        <td><%= g.getCreatedAt() %></td>
                                        <td><%= g.getUpdatedAt() %></td>
                                        <td>
                                            <a href="<%= request.getContextPath() %>/GameController?action=deleteGame&gameId=<%= g.getGameName()%>" 
                                               onclick="return confirm('Bạn có chắc muốn xóa game này?')" class="action-btn">Delete</a> |
                                            <a href="<%= request.getContextPath() %>/GameController?action=updateGameForm&gameId=<%= g.getGameName()%>" class="action-btn">Edit</a>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                        <% } else { %>
                            <p class="no-results">No games found.</p>
                        <% } %>
                    <% } %>

                    <% } %>
                </div>
            </div>
        </div>
    </body>
</html>
