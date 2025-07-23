<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Liên hệ</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: url('assets/image/1551360_383.jpg') no-repeat center center fixed;
                background-size: cover;
                margin: 0;
                padding: 0;
                color: white;
            }
            .container {
                max-width: 1200px;
                min-height: 800px;
                margin: 20px auto;
                padding: 20px;
                background-color: rgba(0, 0, 0, 0.3);
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
            }
            h2 {
                margin-top: 300px;
                text-align: center;
                color: #00bfff;
            }
            .contact-info {
                text-align: center;
                font-size: 18px;
                line-height: 1.8;
            }
            .contact-info p {
                margin: 10px 0;
                color: white;
            }
            .contact-info a {
                color: #ff00ff;
                text-decoration: none;
                font-weight: bold;
            }
            .contact-info a:hover {
                color: #d600d6;
                text-decoration: underline;
            }
            .info-box {
                background: rgba(255, 255, 255, 0.1);
                padding: 15px;
                border-radius: 8px;
                margin: 10px auto;
                max-width: 600px;
            }
        </style>
    </head>
    <body>
        <%@include file='partials/header.jsp' %>

        <div class="container">
            <h2>Liên hệ với chúng tôi</h2>
            <div class="contact-info">
                <p>Chúng tôi luôn sẵn sàng hỗ trợ bạn! Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi qua các kênh sau:</p>
                <p><strong>Email:</strong> <a href="mailto:support@gamestore.com">support@gamestore.com</a></p>
                <p><strong>Điện thoại:</strong> 0123 456 789</p>
                <p><strong>Địa chỉ:</strong> 123 Đường Game, Quận 1, TP. Hồ Chí Minh</p>
                <p><strong>Giờ làm việc:</strong> 9:00 - 18:00, Thứ Hai - Thứ Bảy</p>
            </div>
        </div>
        <%@include file='partials/footer.jsp' %>
    </body>
</html>