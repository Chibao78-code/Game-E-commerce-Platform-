/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.GameDAO;
import dto.GameDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "GameController", urlPatterns = {"/GameController"})
public class GameController extends HttpServlet {
    private static final String LOGIN_PAGE = "login.jsp";
    private static final String ADMIN_PAGE = "admin.jsp";
    private static final String MENU_PAGE = "menu.jsp";
    private GameDAO gameDAO;

    public GameController() {
        try {
            gameDAO = new GameDAO();
        } catch (Exception e) {
            log("Error initializing GameDAO: " + e.toString());
        }
    }

    private String processSearchGames(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            url = LOGIN_PAGE;
            request.setAttribute("message", "Vui lòng đăng nhập để tìm kiếm game!");
        } else {
            String searchTerm = request.getParameter("searchTerm");
            if (searchTerm == null) {
                searchTerm = "";
            }
            List<GameDTO> games = gameDAO.getGameByName(searchTerm);
            System.out.println("processSearchGames: Found " + (games != null ? games.size() : "null") + " games");
            request.setAttribute("games", games);
            request.setAttribute("searchTerm", searchTerm);
            if (AuthUtils.isAdmin(session)) {
                url = "admin.jsp?page=searchGame";
            } else {
                url = MENU_PAGE;
            }
        }
        return url;
    }

    private String processSearchByGenre(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            url = LOGIN_PAGE;
            request.setAttribute("message", "Vui lòng đăng nhập để tìm kiếm game theo thể loại!");
        } else {
            String genre = request.getParameter("genre");
            if (genre == null) {
                genre = "";
            }
            List<GameDTO> games = gameDAO.getGamesByGenre(genre);
            System.out.println("processSearchByGenre: Found " + (games != null ? games.size() : "null") + " games for genre: " + genre);
            request.setAttribute("games", games);
            request.setAttribute("searchTerm", genre);
            if (AuthUtils.isAdmin(session)) {
                url = "admin.jsp?page=searchGame";
            } else {
                url = MENU_PAGE;
            }
        }
        return url;
    }

    private String processGetAllGames(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            url = LOGIN_PAGE;
            request.setAttribute("message", "Vui lòng đăng nhập để xem danh sách game!");
        } else {
            List<GameDTO> games = gameDAO.getAllGames();
            System.out.println("processGetAllGames: Found " + (games != null ? games.size() : "null") + " games");
            request.setAttribute("games", games);
            request.setAttribute("searchTerm", "");
            if (AuthUtils.isAdmin(session)) {
                url = "admin.jsp?page=searchGame";
            } else {
                url = MENU_PAGE;
            }
        }
        return url;
    }

    private String processListGenres(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            url = LOGIN_PAGE;
            request.setAttribute("message", "Vui lòng đăng nhập để xem danh sách thể loại!");
        } else {
            if (gameDAO == null) {
                throw new ServletException("GameDAO is not initialized");
            }
            List<String> genres = gameDAO.getAllGenres();
            System.out.println("processListGenres: Found " + (genres != null ? genres.size() : "null") + " genres");
            request.setAttribute("genres", genres);
            url = "genreList.jsp";
        }
        return url;
    }
        
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ADMIN_PAGE;
        try {
            String action = request.getParameter("action");
            String page = request.getParameter("page");
            String genre = request.getParameter("genre");
            System.out.println("Action: " + action + ", Page: " + page + ", Genre: " + genre);

            if (action == null && page == null) {
                url = processGetAllGames(request, response);
            } else if ("searchGame".equals(action) && genre != null && !genre.isEmpty()) {
                url = processSearchByGenre(request, response);
            } else if ("searchGame".equals(action)) {
                url = processSearchGames(request, response);
            } else if ("searchGame".equals(page)) {
                url = processGetAllGames(request, response);
            } else if ("listGenres".equals(action)) {
                url = processListGenres(request, response);
            } else {
                url = MENU_PAGE;
            }

        } catch (Exception e) {
            log("Error at GameController: " + e.toString());
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
