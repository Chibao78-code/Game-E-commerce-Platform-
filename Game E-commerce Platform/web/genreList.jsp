<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách Thể loại</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: url('assets/image/1551360_383.jpg') no-repeat center center fixed;
                background-size: cover;
                margin: 0;
                padding: 0;
            }
            /* Danh sách thể loại */
            .genre-container{
                max-width: 1200px;
                min-height: 800px;
                margin: 20px auto;
                padding: 20px;
                background-color: rgba(0, 0, 0, 0.3);
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
                color: white;
            }
            
            .genre-container h2{
                text-align: center;
                color: #00bfff;
            }
            
            .genre-list {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                justify-content: center;
                background: rgba(0, 0, 0, 0.65);
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 221, 235, 0.5);
                border: 2px solid #00ddeb;
                margin-top: 300px;
            }

            .genre-item {
                padding: 10px 20px;
                background-color: rgba(0, 255, 255, 0.2);
                border-radius: 5px;
                transition: all 0.3s ease-in-out;
            }

            .genre-item a {
                color: #00bfff;
                text-decoration: none;
                font-weight: bold;
                text-transform: uppercase;
            }

            .genre-item:hover {
                background-color: rgba(0, 255, 255, 0.5);
                transform: scale(1.1);
            }

            /* Khi không có thể loại nào */
            .no-results {
                text-align: center;
                color: #ff5555;
                font-weight: bold;
                font-size: 16px;
                margin-top: 15px;
            }



        </style>
    </head>
    <body>
        <%@include file='partials/header.jsp' %>

        <div class="genre-container">
            <h2>Danh sách Thể loại</h2>
            <% 
                List<String> genres = (List<String>) request.getAttribute("genres");
                if (genres != null && !genres.isEmpty()) { 
            %>
            <div class="genre-list">
                <% for (String genre : genres) { %>
                <div class="genre-item">
                    <a href="<%= request.getContextPath() %>/GameController?action=searchGame&genre=<%= genre %>"><%= genre %></a>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <p class="no-results">Không tìm thấy thể loại nào.</p>
            <% } %>
        </div>
        
        <%@include file='partials/footer.jsp' %>
    </body>
</html>