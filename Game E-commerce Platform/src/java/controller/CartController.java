package controller;

import dao.GameDAO;
import dto.CartItem;
import dto.GameDTO;
import dto.UserDTO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {
    private static final String CART_PAGE = "cart.jsp";
    private static final String LOGIN_PAGE = "login.jsp";
    private static final String MENU_PAGE = "menu.jsp";
    private static final String SUCCESS_PAGE = "success.jsp";
    private GameDAO gameDAO = new GameDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = CART_PAGE;
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        try {
            String action = request.getParameter("action");
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }

            if (user == null) {
                request.setAttribute("message", "Vui lòng đăng nhập để sử dụng giỏ hàng!");
                url = LOGIN_PAGE;
            } else {
                if ("addToCart".equals(action)) {
                    int gameId = Integer.parseInt(request.getParameter("gameId"));
                    GameDTO game = gameDAO.getGameById(gameId);
                    if (game != null && game.getStock() > 0) {
                        boolean found = false;
                        for (CartItem item : cart) {
                            if (item.getGameId() == gameId) {
                                if (item.getQuantity() < game.getStock()) {
                                    item.setQuantity(item.getQuantity() + 1);
                                    request.setAttribute("message", "Đã tăng số lượng " + game.getGameName() + " trong giỏ hàng!");
                                } else {
                                    request.setAttribute("message", "Không thể thêm " + game.getGameName() + " vì đã đạt số lượng tối đa trong kho!");
                                }
                                found = true;
                                break;
                            }
                        }
                        if (!found) {
                            cart.add(new CartItem(gameId, game.getGameName(), game.getPrice(), 1));
                            request.setAttribute("message", "Đã thêm " + game.getGameName() + " vào giỏ hàng!");
                        }
                        session.setAttribute("cart", cart);
                    } else {
                        request.setAttribute("message", "Game không tồn tại hoặc đã hết hàng!");
                    }
                    url = MENU_PAGE;
                } else if ("removeFromCart".equals(action)) {
                    int gameId = Integer.parseInt(request.getParameter("gameId"));
                    cart.removeIf(item -> item.getGameId() == gameId);
                    session.setAttribute("cart", cart);
                    request.setAttribute("message", "Đã xóa game khỏi giỏ hàng!");
                    url = CART_PAGE;
                } else if ("updateQuantity".equals(action)) {
                    int gameId = Integer.parseInt(request.getParameter("gameId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    GameDTO game = gameDAO.getGameById(gameId);
                    for (CartItem item : cart) {
                        if (item.getGameId() == gameId) {
                            if (quantity > 0 && quantity <= game.getStock()) {
                                item.setQuantity(quantity);
                                request.setAttribute("message", "Đã cập nhật số lượng cho " + game.getGameName() + "!");
                            } else if (quantity <= 0) {
                                cart.remove(item);
                                request.setAttribute("message", "Đã xóa " + game.getGameName() + " khỏi giỏ hàng!");
                            } else {
                                request.setAttribute("message", "Số lượng vượt quá tồn kho cho " + game.getGameName() + "!");
                            }
                            break;
                        }
                    }
                    session.setAttribute("cart", cart);
                    url = CART_PAGE;
                } else if ("checkout".equals(action)) {
                    url = processCheckout(request, response, cart, session, user);
                }
            }
        } catch (Exception e) {
            log("Error at CartController: " + e.toString());
            request.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    private String processCheckout(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart, HttpSession session, UserDTO user)
            throws ServletException, IOException {
        String url = CART_PAGE;
        if (cart.isEmpty()) {
            request.setAttribute("message", "Giỏ hàng trống! Vui lòng thêm game trước khi thanh toán.");
            return url;
        }

        try {
            // Calculate total amount
            BigDecimal totalAmount = BigDecimal.ZERO;
            for (CartItem item : cart) {
                totalAmount = totalAmount.add(item.getTotalPrice());
            }

            // Create order
            int orderId = gameDAO.createOrder(user.getUserId(), totalAmount);
            if (orderId == 0) {
                request.setAttribute("message", "Không thể tạo đơn hàng. Vui lòng thử lại!");
                return url;
            }

            // Create order details and update stock
            for (CartItem item : cart) {
                GameDTO game = gameDAO.getGameById(item.getGameId());
                if (game.getStock() >= item.getQuantity()) {
                    gameDAO.createOrderDetail(orderId, item.getGameId(), item.getQuantity(), item.getPrice());
                    gameDAO.updateStock(item.getGameId(), item.getQuantity());
                } else {
                    request.setAttribute("message", "Không đủ hàng trong kho cho " + item.getGameName() + ". Vui lòng kiểm tra lại!");
                    return url;
                }
            }

            // Clear cart after successful checkout
            cart.clear();
            session.setAttribute("cart", cart);
            request.setAttribute("message", "Mua hàng thành công! Cảm ơn bạn đã mua sắm.");
            url = SUCCESS_PAGE;
        } catch (Exception e) {
            log("Checkout error: " + e.toString());
            request.setAttribute("message", "Lỗi khi thanh toán: " + e.getMessage());
        }
        return url;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "CartController for managing shopping cart operations";
    }
}