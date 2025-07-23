<%-- 
    Document   : footer
    Created on : Feb 18, 2025, 11:24:49 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .footer {
        background-image: url('assets/image/z6356433591562_7559b4a02068fdc71cf79b652c3e79ba-processed(lightpdf.com).jpg');
        color: #fff;
        padding: 3rem 0;
        margin-top: 0;
    }

    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 1rem;
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 2rem;
    }

    .footer-section h3 {
        font-size: 1.2rem;
        margin-bottom: 1rem;
        color: white;
    }

    .footer-section p {
        font-size: 16px;
        color: #ffffff;
        background: rgba(0, 0, 0, 0.1); /* Nền mờ */
        padding: 10px;
        border-radius: 10px; /* Bo góc */
        box-shadow: 0 2px 4px rgba(255, 255, 255, 0.1); /* Đổ bóng nhẹ */
    }

    .footer-links {
        list-style: none;
    }

    .footer-links li {
        margin-bottom: 0.5rem;
    }

    .footer-links a {
        color: #fff;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .footer-links a:hover {
        color: #3498db;
    }

    .social-links {
        display: flex;
        gap: 1rem;
        margin-top: 1rem;
    }

    .social-links a {
        color: #fff;
        text-decoration: none;
        font-size: 1.5rem;
    }

    .copyright {
        text-align: center;
        padding-top: 2rem;
        margin-top: 2rem;
        border-top: 1px solid #34495e;
        font-size: 0.9rem;
    }
</style>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-section">
            <h3>Về chúng tôi</h3>
            <p><span style="color: yellowgreen">TheBestGameOnline</span> là điểm đến lý tưởng dành cho game thủ, chuyên cung cấp game bản quyền với giá cạnh tranh. Chúng tôi cam kết mang đến trải nghiệm mua sắm an toàn, nhanh chóng và tiện lợi.</p>
        </div>
        
        <div class="footer-section">
            <h3>Liên kết nhanh</h3>
            <ul class="footer-links">
                <li><a href="#">Trang chủ</a></li>
                <li><a href="#">Sản phẩm</a></li>
                <li><a href="#">Giỏ hàng</a></li>
                <li><a href="#">Chính sách</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h3>Liên hệ</h3>
            <p>Địa chỉ: 123 Đường ABC, Quận XYZ</p>
            <p>Email: contact@shoponline.com</p>
            <p>Điện thoại: (84) 123-456-789</p>
        </div>
        
        <div class="footer-section">
            <h3>Theo dõi chúng tôi</h3>
            <p>Cập nhật tin tức mới nhất và khuyến mãi từ chúng tôi</p>
            <div class="social-links">
                <a href="#">📱</a>
                <a href="#">💬</a>
                <a href="#">📷</a>
            </div>
        </div>
    </div>
    
    <div class="copyright">
        <p>&copy; 2025 Shop Game Online. Tất cả quyền được bảo lưu.</p>
    </div>
</footer>
