<%-- 
    Document   : header
    Created on : Feb 17, 2025, 10:55:12 AM
    Author     : LENOVO
--%>

<%@page import="utils.AuthUtils"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<style> 
    @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap");

    * {
        font-family: "Poppins", sans-serif;
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        text-decoration: none;
        list-style: none;
    }

    body, html {
        color: #020102;
        background-color: #f5f5f5;
    }

    /* HEADER */
    .header {
        background-image: url('assets/image/z6356433591562_7559b4a02068fdc71cf79b652c3e79ba-processed(lightpdf.com).jpg');
        background-size: cover;
        background-position: center;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 15px 20px;
        width: 100%;
        top: 0;
        left: 0;
        z-index: 1000;
    }

    /* CONTAINER */
    .header-container {
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
    }

    /* LOGO */
    .logo {
        display: flex;
        align-items: center;
    }

    .logo img {
        max-width: 70px;
        height: auto;
        border-radius: 50%;
    }

    .logo p {
        font-size: 20px;
        font-weight: bold;
        color: white;
        margin-left: 10px;
    }

    .logo span {
        color: yellow;
    }

    /* MENU */
    .menu {
        background-image: url('assets/image/z6356433591562_7559b4a02068fdc71cf79b652c3e79ba-processed(lightpdf.com).jpg');
        display: flex;
        align-items: center;
        gap: 30px;
        padding: 10px;
        
        border-radius: 10px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    .menu-item a {
        color: white;
        font-size: 1.2rem;
        font-weight: 500;
        transition: color 0.3s ease;
    }

    .menu-item a:hover {
        color: #a0d2eb;
        font-size: 24px;
    }

    /* RIGHT SECTION */
    .right-section {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    /* SEARCH */
    #search-icon {
        cursor: pointer;
        width: 30px;
        height: 30px;
    }

    .search-box {
        display: none; /* Ẩn mặc định */
        position: absolute;
        top: 70px; /* Đặt ngay dưới thanh menu */
        left: 50%; /* Căn giữa */
        transform: translateX(-50%); /* Giúp nó căn giữa hoàn toàn */
        width: 50%; /* Chiều dài nằm giữa */
        background: white;
        padding: 10px;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        z-index: 999;
    }
    
    .search-box input {
        width: 100%;
        padding: 10px;
        border: none;
        outline: none;
        font-size: 16px;
        border-radius: 5px;
    }
    /* LOGIN & CART */
    .login, .cart {
        display: flex;
        align-items: center;
        justify-content: center;
        background: white;
        cursor: pointer;
        border: 2px solid black;
        border-radius: 5px;
        padding: 8px 12px;
        transition: all 0.3s ease;
    }

    .login:hover, .cart:hover {
        background: #ddd;
    }

    .login img, .cart img {
        width: 30px;
        height: 30px;
    }

    .user-section {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .user-section strong {
        color: yellow;
    }

    .welcome-text {
        color: white;
        font-weight: bold;
    }
    
    .logout-btn {
        padding: 10px;
        border-radius: 5px;
        background-color: powderblue;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    }
    
    .logout-btn:hover{
        background-color: blue;
        transition-duration:  0.5s;
    }

    @media (max-width: 768px) {
        .header {
            flex-direction: column;
            padding: 10px;
        }

        .container {
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        .menu {
            flex-direction: column;
            gap: 10px;
            padding-top: 10px;
        }

        .right-section {
            flex-direction: column;
            gap: 10px;
        }

        .logo img {
            max-width: 60px;
        }
    }
</style>
<header class="header">

    <%
        int x = 100;
    %>
    <div class="header-container">
               <a href="<%= request.getContextPath() %>/index.jsp" class="logo">
                <img src="assets/image/z6344218901443_e4fd8ed41ec42487b1140ea5a3e4832d.jpg" alt="The Best Game Online">
                <p class="Banner">The Best <span> Game Online </span></p>
                </a>
            <ul class="menu">
                <li class="menu-item"><a href="<%= request.getContextPath() %>/index.jsp">Trang Chủ</a></li>
                <li class="menu-item"><a href="<%= request.getContextPath() %>/menu.jsp">Sản phẩm</a></li>
                <li class="menu-item"><a href="<%= request.getContextPath() %>/GameController?action=listGenres"">Thể loại</a></li>
                <li class="menu-item"><a href="<%= request.getContextPath() %>/contact.jsp">Liên hệ</a></li>
            </ul>
            <%  if (AuthUtils.isLoggedIn(session)) {
                UserDTO userHeader = AuthUtils.getUser(session);

            %>
            <%}%>
            <div class='right-section'>
                <i class="bx bx-search" id="search-icon">
                    <img src='assets/image/search-alt-2-regular-24.png' alt="search-icon"/>
                </i>
                <div class="search-box">
                    <form action="GameController?action=searchGame&gameName=?" method="GET">
                        <input type="text" name="keyword" placeholder="Tìm kiếm..." required />
                        <button type="submit" style="display: none;"></button>
                    </form>
                </div>
                <%
                    if (AuthUtils.isLoggedIn(session)) {
                        UserDTO userHeader = AuthUtils.getUser(session);
                %>
                    <!-- Hiển thị tên user và nút Đăng Xuất -->
                    <div class="user-section">
                        <span class="welcome-text">Xin chào, <strong><%= userHeader.getFullname()%></strong>!</span>
                        <form action="MainController" method="post" style="margin: 0;">
                            <input type="hidden" name="action" value="logout"/>
                            <button type="submit" class="logout-btn">Đăng Xuất</button>
                        </form>
                    </div>
                <%
                    } else {
                %>
                    <!-- Hiển thị nút Đăng Nhập nếu chưa login -->
                    <button class="login" onclick="window.location.href='login.jsp'">
                        <img src="assets/image/user-regular-36.png" alt="Login Image"/>
                        <p>Đăng Nhập</p>
                    </button>
                <%
                    }
                %>
                <button class="cart" onclick="window.location.href='cart.jsp'">
                    <img src="assets/image/cart-alt-regular-24.png" alt="Cart Game">
                </button>
            </div>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const searchIcon = document.getElementById("search-icon");
            const searchBox = document.querySelector(".search-box");

            searchIcon.addEventListener("click", function () {
                // Toggle search box
                if (searchBox.style.display === "none" || searchBox.style.display === "") {
                    searchBox.style.display = "block";
                } else {
                    searchBox.style.display = "none";
                }
            });

            // Ẩn search box khi click ra ngoài
            document.addEventListener("click", function (event) {
                if (!searchBox.contains(event.target) && !searchIcon.contains(event.target)) {
                    searchBox.style.display = "none";
                }
            });
        });

    </script>
</header>
