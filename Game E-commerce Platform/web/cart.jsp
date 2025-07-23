<%@page import="dto.CartItem"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ hàng</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            .nav-bar {
                background-color: #333;
                padding: 10px 0;
            }
            .nav-bar ul {
                list-style-type: none;
                margin: 0;
                padding: 0;
                text-align: center;
            }
            .nav-bar ul li {
                display: inline;
                margin-right: 20px;
            }
            .nav-bar ul li a {
                color: white;
                text-decoration: none;
                font-size: 16px;
            }
            .nav-bar ul li a:hover {
                color: #ffcc00;
            }
            .container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                color: #333;
            }
            .table-wrapper {
                overflow-x: auto;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #f2f2f2;
                color: #333;
            }
            .quantity-input {
                width: 60px;
                padding: 5px;
            }
            .action-btn {
                padding: 5px 10px;
                text-decoration: none;
                border-radius: 4px;
                color: white;
            }
            .update-btn {
                background-color: #007bff;
            }
            .update-btn:hover {
                background-color: #0056b3;
            }
            .remove-btn {
                background-color: #dc3545;
            }
            .remove-btn:hover {
                background-color: #c82333;
            }
            .total {
                text-align: right;
                font-size: 18px;
                margin-top: 20px;
                font-weight: bold;
            }
            .checkout-btn {
                display: block;
                width: 200px;
                margin: 20px auto;
                padding: 10px;
                background-color: #28a745;
                color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 4px;
            }
            .checkout-btn:hover {
                background-color: #218838;
            }
            .message {
                text-align: center;
                font-size: 16px;
                margin-bottom: 20px;
            }
            .message.success {
                color: #28a745;
            }
            .message.error {
                color: #dc3545;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Giỏ hàng</h2>

            <!-- Display Feedback Message -->
            <%
                String message = (String) request.getAttribute("message");
                if (message != null) {
            %>
            <p class="message <%= message.contains("thành công") ? "success" : "error" %>"><%= message %></p>
            <% } %>

            <!-- Cart Items -->
            <% 
                /*HttpSession session = request.getSession();*/
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                if (cart != null && !cart.isEmpty()) { 
                    BigDecimal total = BigDecimal.ZERO;
            %>
            <div class="table-wrapper">
                <table border="1" cellspacing="0" cellpadding="5">
                    <thead>
                        <tr>
                            <th>Game Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (CartItem item : cart) { 
                            BigDecimal itemTotal = item.getTotalPrice();
                            total = total.add(itemTotal);
                        %>
                        <tr>
                            <td><%= item.getGameName() %></td>
                            <td><%= item.getPrice() %></td>
                            <td>
                                <form action="CartController" method="POST" style="display:inline;">
                                    <input type="hidden" name="action" value="updateQuantity"/>
                                    <input type="hidden" name="gameId" value="<%= item.getGameId() %>"/>
                                    <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="0" class="quantity-input"/>
                                    <button type="submit" class="action-btn update-btn">Cập nhật</button>
                                </form>
                            </td>
                            <td><%= itemTotal %></td>
                            <td>
                                <a href="<%= request.getContextPath() %>/CartController?action=removeFromCart&gameId=<%= item.getGameId() %>" class="action-btn remove-btn">Xóa</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <div class="total">
                Tổng cộng: <%= total %>
            </div>
            <a href="<%= request.getContextPath() %>/CartController?action=checkout" class="checkout-btn">Mua hàng</a>
            <% } else { %>
            <p class="message error">Giỏ hàng của bạn đang trống.</p>
            <% } %>
        </div>
    </body>
</html>