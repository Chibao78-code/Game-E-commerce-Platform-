<%-- 
    Document   : index
    Created on : Feb 28, 2025, 9:31:57 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="assets/image/jpg" href="assets/image/z6344218901443_e4fd8ed41ec42487b1140ea5a3e4832d.jpg">
        <title>The Best Game Online</title>
        <!-- Look of this document is driven by a CSS referenced by an href attribute. See http://www.w3.org/TR/xml-stylesheet/ -->
        <style>
/*            body {
                margin: 0;
                font-family: Arial, sans-serif;
            }*/
            
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background: linear-gradient(45deg, #ff4b2b, #ff416c, #007bff, #00c6ff);
                background-size: 400% 400%;
                animation: gradientAnimation 10s ease infinite;
            }

            @keyframes gradientAnimation {
                0% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }
            
            .falling-stars {
                position: fixed;
                top: -10px;
                left: 50%;
                width: 20px;
                height: 20px;
                background: url('assets/image/pngwing.com (2).png') no-repeat center/contain;
                opacity: 0.8;
                pointer-events: none;
                z-index: 9999;
                animation: fall linear infinite;
            }

            @keyframes fall {
                0% { transform: translateY(0) rotate(0deg); opacity: 1; }
                100% { transform: translateY(100vh) rotate(360deg); opacity: 0; }
            }
            
            #toggleStarBtn {
                position: fixed;
                bottom: 20px;
                right: 20px;
                background: linear-gradient(45deg, #ff9a9e, #fad0c4);
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                border-radius: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                color: white;
                font-weight: bold;
            }

            #toggleStarBtn:hover {
                background: linear-gradient(45deg, #ff758c, #ff7eb3);
            }

            .slideshow-container {  
                position: relative;
                width: 100%;
                height: 100vh;
                overflow: hidden;
            }

            .slideshow img {
                position: absolute;
                width: 100%;
                height: 100%;
                object-fit: cover;
                opacity: 0;
                animation: fade 12s infinite;
            }
            
            .slideshow img:nth-child(1) { animation-delay: 0s; }
            .slideshow img:nth-child(2) { animation-delay: 4s; }
            .slideshow img:nth-child(3) { animation-delay: 8s; }
            .slideshow img:nth-child(4) { animation-delay: 12s; }
            .slideshow img:nth-child(5) { animation-delay: 16s; }
            .slideshow img:nth-child(6) { animation-delay: 20s; }

            @keyframes fade {
                0% { opacity: 0; }
                10% { opacity: 1; }
                30% { opacity: 1; }
                40% { opacity: 0; }
                100% { opacity: 0; }
            }
            
            .welcome-user {
                position: absolute;
                width: 100%;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                text-align: center;
                background: rgba(0, 0, 0, 0.1);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(255, 255, 255, 0.3);
            }
            
            .welcome-container {
                position: absolute;
                width: 100%;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                text-align: center;
                background: rgba(0, 0, 0, 0.1);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(255, 255, 255, 0.3);
            }

            .welcome-title{
                margin-bottom: 250px;
            }
            .welcome-title h1 {
                font-size: 3rem;
                margin-bottom: 10px;
            }

            .welcome-title h4 {
                font-size: 1.2rem;
                margin-top: 0;
            }

            .welcome-title a {
                color: lightblue;
                text-decoration: none;
            }

            .welcome-title a:hover {
                color: red;
                text-decoration: underline;
            }

            .divider {
                border: none;
                height: 10px;
                background: linear-gradient(to right, #ff5722, #007bff);
                margin: 0 auto;
                width: 100%; /* Hoặc % tùy theo ý */
                opacity: 0.7;
            }
        </style>
    </head>
    <body>
        <%@include file='partials/header.jsp' %>
        <hr class="divider">
            <button id="toggleStarBtn" onclick="toggleStarEffect()">Tắt hiệu ứng sao</button>
            <div class="slideshow-container">
                <div class="slideshow">
                    <img src="assets/image/20240818214820_1.jpg" alt="Slideshow Image 1">
                    <img src="assets/image/background_index.jpg" alt="Slideshow Image 2">
                    <img src="assets/image/1551360_2.jpg" alt="Slideshow Image 3">
                    <img src="assets/image/1551360_383.jpg" alt="Slideshow Image 4">
                    <img src="assets/image/Ekran Görüntüsü (324).png" alt="Slideshow Image 5">
                    <img src="assets/image/Ekran Görüntüsü (415).png" alt="Slideshow Image 6">
                </div>
            </div>
            <%
                if (AuthUtils.isLoggedIn(session)) {
                    UserDTO user = AuthUtils.getUser(session);
            %>
            <div class="welcome-user">
                <div class="welcome-title">
                    <h1 style="color: white">Welcome back, <span style="color: yellow"><%= user.getFullname() %></span>!</h1>
                    <h4>
                        <a href="menu.jsp">Explore Games</a> or <a href="MainController?action=logout">Logout</a>
                    </h4>
                </div>
            </div>
            <%
                } else {
            %>
            <div class="welcome-container">
                <div class="welcome-title">
                    <h1 style="color: white">Welcome to <span style="color: yellow">The Best </span> <span style="color: pink">Game Online</span></h1>
                    <h4>
                        <a href="login.jsp">Login</a> to continue / Use as <a href="menu.jsp">Guest</a>
                    </h4>
                </div>
            </div>
            <%}%>
        <hr class="divider">
        <script>
            let isStarEffectOn = true;
            let starInterval;
            
            function createStar() {
                if(!isStarEffectOn ){return;}
                
                const star = document.createElement("div");
                star.classList.add("falling-stars");

                // Vị trí ngẫu nhiên từ 0 đến 100% màn hình
                star.style.left = Math.random() * 100 + "vw";

                // Thời gian rơi ngẫu nhiên từ 5s - 10s
                star.style.animationDuration = Math.random() * 5 + 5 + "s";

                document.body.appendChild(star);

                // Xóa cánh hoa sau khi rơi xong
                setTimeout(() => {
                    star.remove();
                }, 10000);
            }
            
            function toggleStarEffect() {
                isStarEffectOn = !isStarEffectOn;
                const btn = document.getElementById("toggleStarBtn");

                if (isStarEffectOn) {
                    btn.textContent = "Tắt hiệu ứng sao";
                    starInterval = setInterval(createStar, 500);
                } else {
                    btn.textContent = "Bật hiệu ứng sao";
                    clearInterval(starInterval);
                    document.querySelectorAll(".falling-stars").forEach(f => f.remove());
                }
            }
            // Tạo cánh hoa mới mỗi 500ms
            setInterval(createStar, 500);
        </script>
        <%@include file='partials/footer.jsp' %>
    </body>
</html>
