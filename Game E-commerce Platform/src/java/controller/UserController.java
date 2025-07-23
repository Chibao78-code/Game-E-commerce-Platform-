/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AuthUtils;
import utils.PasswordUtils;

/**
 *
 * @author LENOVO
 */

@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String MENU_PAGE = "menu.jsp";
    private static final String ADMIN_PAGE = "admin.jsp";
    private static final String REGISTER_PAGE = "registers.jsp";
    private static final String FORGOT_PAGE = "forgotPassword.jsp";
    private static final String RESET_PAGE = "resetPassword.jsp";
    private UserDAO userDAO = new UserDAO();

    private String processRegister(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
        String url = REGISTER_PAGE;
        String username = request.getParameter("txtUsername");
        String password = request.getParameter("txtPassword");
        String fullname = request.getParameter("txtFullname");
        String email = request.getParameter("txtEmail");
        String phone = request.getParameter("txtPhone");
        String address = request.getParameter("txtAddress");

        // Kiểm tra dữ liệu đầu vào
        if (username == null || password == null || fullname == null || email == null || phone == null || address == null ||
            username.trim().isEmpty() || password.trim().isEmpty() || fullname.trim().isEmpty() || email.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng điền đầy đủ thông tin!");
            return url;
        }

        // Kiểm tra độ dài tối đa
        if (username.length() > 50 || fullname.length() > 100 || email.length() > 100 || phone.length() > 15 || address.length() > 200) {
            request.setAttribute("message", "Thông tin nhập vào vượt quá độ dài cho phép!");
            return url;
        }

        // Kiểm tra định dạng email
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("message", "Email không hợp lệ!");
            return url;
        }

        // Kiểm tra định dạng số điện thoại
        if (!phone.matches("\\d{10}")) {
            request.setAttribute("message", "Số điện thoại phải là 10 chữ số!");
            return url;
        }

        UserDTO existingUser = userDAO.readByID(username);
        if (existingUser != null) {
            request.setAttribute("message", "Tên đăng nhập đã tồn tại! Vui lòng chọn tên khác.");
            return url;
        }

        String hashedPassword = PasswordUtils.hashPassword(password);
        if (hashedPassword == null) {
            request.setAttribute("message", "Có lỗi khi mã hóa mật khẩu! Vui lòng thử lại.");
            return url;
        }

        log("Registering user: username=" + username + ", email=" + email + ", phone=" + phone + ", hashedPassword=" + hashedPassword);

        UserDTO newUser = new UserDTO(0, username, fullname, hashedPassword, email, phone, address, "Customer", new Timestamp(System.currentTimeMillis()));
        boolean success = userDAO.create(newUser);
        if (success) {
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            url = LOGIN_PAGE;
        } else {
            request.setAttribute("message", "Đăng ký thất bại! Kiểm tra log để biết chi tiết.");
            log("Register failed for user: " + username + " - Check UserDAO.create for errors.");
        }

        return url;
    }
    
    private String processForgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = FORGOT_PAGE;
        String email = request.getParameter("txtEmail");

        if (email == null || email.trim().isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("message", "Vui lòng nhập email hợp lệ!");
            return url;
        }

        // Tìm user theo email
        List<UserDTO> users = userDAO.search(email);
        UserDTO user = null;
        for (UserDTO u : users) {
            if (u.getEmail().equals(email)) {
                user = u;
                break;
            }
        }

        if (user == null) {
            request.setAttribute("message", "Email không tồn tại trong hệ thống!");
            return url;
        }

        // Tạo token đặt lại mật khẩu (UUID ngẫu nhiên)
        String resetToken = UUID.randomUUID().toString();
        HttpSession session = request.getSession();
        session.setAttribute("resetToken", resetToken);
        session.setAttribute("resetUser", user);
        session.setAttribute("tokenTime", System.currentTimeMillis());

        // Giả lập gửi email (thay bằng gửi email thật nếu có SMTP)
        String resetLink = request.getContextPath() + "/resetPassword.jsp?token=" + resetToken;
        log("Reset link (giả lập email): " + resetLink);
        request.setAttribute("message", "Liên kết đặt lại mật khẩu đã được gửi đến email của bạn!");

        return url;
    }
    
    private String processResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = RESET_PAGE;
        String token = request.getParameter("token");
        String password = request.getParameter("txtPassword");
        String confirmPassword = request.getParameter("txtConfirmPassword");

        HttpSession session = request.getSession();
        String storedToken = (String) session.getAttribute("resetToken");
        UserDTO user = (UserDTO) session.getAttribute("resetUser");
        Long tokenTime = (Long) session.getAttribute("tokenTime");

        // Kiểm tra token
        if (token == null || storedToken == null || !token.equals(storedToken) || user == null) {
            request.setAttribute("message", "Liên kết đặt lại mật khẩu không hợp lệ!");
            return url;
        }

        // Kiểm tra thời gian token (hết hạn sau 10 phút)
        long currentTime = System.currentTimeMillis();
        if (tokenTime == null || (currentTime - tokenTime) > 10 * 60 * 1000) {
            session.removeAttribute("resetToken");
            session.removeAttribute("resetUser");
            session.removeAttribute("tokenTime");
            request.setAttribute("message", "Liên kết đặt lại mật khẩu đã hết hạn!");
            return url;
        }

        // Kiểm tra mật khẩu
        if (password == null || confirmPassword == null || password.trim().isEmpty() || !password.equals(confirmPassword)) {
            request.setAttribute("message", "Mật khẩu không khớp hoặc không hợp lệ!");
            return url;
        }

        // Mã hóa mật khẩu mới
        String hashedPassword = PasswordUtils.hashPassword(password);
        if (hashedPassword == null) {
            request.setAttribute("message", "Có lỗi khi mã hóa mật khẩu! Vui lòng thử lại.");
            return url;
        }

        // Cập nhật mật khẩu
        user.setPassword(hashedPassword);
        boolean success = userDAO.update(user);
        if (success) {
            session.removeAttribute("resetToken");
            session.removeAttribute("resetUser");
            session.removeAttribute("tokenTime");
            request.setAttribute("message", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
            url = LOGIN_PAGE;
        } else {
            request.setAttribute("message", "Đặt lại mật khẩu thất bại! Vui lòng thử lại.");
            log("Reset password failed for user: " + user.getUsername());
        }

        return url;
    }
    
    // Phương thức chính xử lý mọi request
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        try {
            String action = request.getParameter("action");
            String page = request.getParameter("page");
            System.out.println("Action: " + action + ", Page: " + page);

            if (action == null && page == null) {
                url = LOGIN_PAGE;
            } else if(action.equals("register")){
                url = processRegister(request, response);
            } else if(action.equals("forgotPassword")){
                url = processForgotPassword(request, response);
            } else if(action.equals("resetPassword")){
                url = processResetPassword(request, response);
            }

        } catch (Exception e) {
            log("Error at UserController: " + e.toString());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Something went wrong!");
        }  finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
