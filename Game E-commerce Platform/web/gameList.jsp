<%@page import="dto.GameDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Game List</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .game-image {
            width: 100px;
            height: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Game List</h1>
        <form action="GameController" method="post">
            <input type="hidden" name="action" value="searchGame" />
            <input type="text" name="searchTerm" placeholder="Search by game name" />
            <button type="submit">Search</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>Game Name</th>
                    <th>Price</th>
                    <th>Genres</th>
                    <th>Platform</th>
                    <th>Image</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<GameDTO> games = (List<GameDTO>) request.getAttribute("games");
                    if (games != null) {
                        for (GameDTO game : games) {
                %>
                <tr>
                    <td><%= game.getGameName() %></td>
                    <td><%= game.getPrice() %></td>
                    <td><%= game.getGenres() != null ? String.join(", ", game.getGenres()) : "N/A" %></td>
                    <td><%= game.getPlatform() %></td>
                    <td><img src="<%= game.getImageUrl() %>" alt="<%= game.getGameName() %>" class="game-image"></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5">No games found.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>