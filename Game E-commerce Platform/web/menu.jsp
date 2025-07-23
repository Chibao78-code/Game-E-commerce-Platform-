<%@page import="dto.GameDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.GameDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
        <style>
        /* Tổng thể */
        body {
            font-family: Arial, sans-serif;
            background: url('assets/image/1551360_383.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.3);
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
            color: white;
        }

        h2 {
            text-align: center;
            color: #00bfff;
        }

        /* Thanh tìm kiếm */
        .search-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .search-container input[type="text"] {
            padding: 10px;
            width: 300px;
            border: 2px solid #00bfff;
            border-radius: 5px;
            background: #222;
            color: white;
        }

        .search-btn {
            padding: 10px 20px;
            background-color: #ff00ff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .search-btn:hover {
            background-color: #d600d6;
        }

        /* Bảng */
        .table-wrapper {
            overflow-x: auto;
            border-radius: 8px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
        }

        th {
            background: linear-gradient(90deg, #00ccff, #007bff);
            color: white;
            text-transform: uppercase;
        }

        td {
            background-color: rgba(255, 255, 255, 0.1);
        }

        table tr:hover {
            background-color: rgba(0, 188, 212, 0.2);
        }

        /* Hình ảnh */
        .game-image {
            width: 80px;
            height: auto;
            border-radius: 5px;
        }

        /* Nút hành động */
        .add-to-cart-btn, .edit-btn, .delete-btn {
            display: inline-block;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }

        .add-to-cart-btn {
            background-color: #28a745;
            color: white;
        }

        .add-to-cart-btn:hover {
            background-color: #218838;
        }

        .edit-btn {
            background-color: #ffc107;
            color: black;
        }

        .edit-btn:hover {
            background-color: #e0a800;
        }

        .delete-btn {
            background-color: #dc3545;
            color: white;
        }

        .delete-btn:hover {
            background-color: #c82333;
        }

        /* Responsive */
        @media screen and (max-width: 768px) {
            .search-container input[type="text"] {
                width: 80%;
            }

            table {
                font-size: 14px;
            }
        }

        </style>
    </head>
    <body>
        <%@include file='partials/header.jsp' %>


        <div class="container">
            <h2>Danh sách Game</h2>
            <% String searchTerm = (request.getAttribute("searchTerm") != null) ? (String) request.getAttribute("searchTerm") : ""; %>
            <!-- Form tìm kiếm -->
            <div class="search-container">
                <form action="GameController" method="GET">
                    <input type="hidden" name="action" value="searchGame"/>
                    <label for="tableSearch">Tìm kiếm Game: </label>
                    <input type="text" id="tableSearch" name="searchTerm" value=""<%=searchTerm%>" placeholder="Nhập game_id, gameName, hoặc genre ...">
                    <input type="submit" value="Tìm kiếm" class="search-btn"/>
                    <h3>Kết quả tìm kiếm cho <span style="color: red"><%=searchTerm%></span></h3>
                </form>

            </div>

            <!-- Hiển thị danh sách game -->
            <% 
                List<GameDTO> games = (List<GameDTO>) request.getAttribute("games");
                if (games == null) {
                    GameDAO gameDAO = new GameDAO();
                    if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                        games = gameDAO.getGameByName(searchTerm);
                    } else {
                        games = gameDAO.getAllGames();
                    }
                }
                
                if (games != null && !games.isEmpty()) { 
            %>
            <div class="table-wrapper">
                <table border="1" cellspacing="0" cellpadding="5">
                    <thead>
                        <tr>
                            <th>Game ID</th>
                            <th>Game Name</th>
                            <th>Price</th>
                            <th>Image</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (GameDTO g : games) { %>
                        <tr>
                            <td><%= g.getGameId() %></td>
                            <td><%= g.getGameName() %></td>
                            <td><%= g.getPrice() %></td>
                            <td><img src="<%= g.getImageUrl() %>" alt="<%= g.getGameName() %>" class="game-image"></td>
                            <td>
                                <% if (session.getAttribute("user") != null) { %>
                                    <a href="<%= request.getContextPath() %>/CartController?action=addToCart&gameId=<%= g.getGameId() %>" class="add-to-cart-btn">Thêm vào giỏ hàng</a>
                                <% } else { %>
                                    <a href="login.jsp" class="add-to-cart-btn">Đăng nhập để thêm</a>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <p class="no-results">Không tìm thấy game nào. Vui lòng kiểm tra cơ sở dữ liệu!</p>
            <% } %>
        </div>
        <%@include file='partials/footer.jsp' %>
    </body>
</html>