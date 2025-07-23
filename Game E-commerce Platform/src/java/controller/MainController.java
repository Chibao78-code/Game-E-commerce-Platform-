/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AuthUtils;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {
    
    private static final String LOGIN_PAGE = "login.jsp";
    private static final String MENU_PAGE = "menu.jsp";
    private static final String ADMIN_PAGE = "admin.jsp";
    private static final String MAIN_PAGE = "index.jsp";
    private UserDAO userDAO = new UserDAO(); 
    
    private String processLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        String strUserID = request.getParameter("txtUserID");
        String strPassword = request.getParameter("txtPassword");

        if (AuthUtils.isValidLogin(strUserID, strPassword)) {
            // Lấy thông tin user 1 lần duy nhất
            UserDTO user = AuthUtils.getUser(strUserID);
            session.setAttribute("user", user); // Lưu vào session

            // Kiểm tra role để điều hướng
            if (AuthUtils.isAdmin(session)) {
                url = ADMIN_PAGE;
            } else if(AuthUtils.isUser(session)) {
                url = MAIN_PAGE;
            } 


        } else {
            request.setAttribute("message", "Incorrect UserID or Password");
            url = "login.jsp";
        }
        return url;
    }

    
    private String processLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        if(AuthUtils.isLoggedIn(session)){
            request.getSession().invalidate();
            url = "login.jsp";
        }
        return url;
    }
    
    public String processSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        if(AuthUtils.isAdmin(session)){
            String searchTerm = request.getParameter("searchTerm");
            if(searchTerm == null){
                searchTerm = "";
            } else {
                searchTerm = searchTerm.trim();
            }
            url = "admin.jsp?page=searchUser";
            List<UserDTO> users = userDAO.getUserByName(searchTerm);
            request.setAttribute("users", users);
            request.setAttribute("searchTerm", searchTerm);
        } else {
            response.sendRedirect(LOGIN_PAGE); // Chuyển hướng thay vì chỉ đặt URL
            return null; // Ngăn code tiếp tục chạy
        }
        return url;
    }
    
    private String processGetAllUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        if (AuthUtils.isAdmin(session)) {
            url = "admin.jsp?page=searchUser";
            List<UserDTO> users = userDAO.getAllUsers();
            System.out.println("processGetAllUsers: Found " + (users != null ? users.size() : "null") + " users");
            request.setAttribute("users", users);
            request.setAttribute("searchTerm", ""); // Giữ searchTerm rỗng
        } else {
            response.sendRedirect(LOGIN_PAGE);
            return null;
        }
        return url;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        try {
            String action = request.getParameter("action");
            String page = request.getParameter("page"); // Lấy tham số page từ URL
            System.out.println("Action: " + action + ", Page: " + page);
            if (action == null && page == null) {
                url = LOGIN_PAGE;
            } else {
                if ("login".equals(action)) {
                    url = processLogin(request, response);
                } else if ("logout".equals(action)) {
                    url = processLogout(request, response);
                } else if ("searchUser".equals(action)) {
                    url = processSearch(request, response);
                } else if ("searchUser".equals(page)) { // Xử lý khi vào từ slide bar
                    url = processGetAllUsers(request, response);
                } else {
                    url = ADMIN_PAGE; // Mặc định về admin.jsp nếu không khớp
                }
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
        } finally {
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
