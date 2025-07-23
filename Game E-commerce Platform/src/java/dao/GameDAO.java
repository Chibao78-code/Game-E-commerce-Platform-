/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.GameDTO;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

/**
 *
 * @author LENOVO
 */
public class GameDAO implements IDAO<GameDTO, String>{

    @Override
    public boolean create(GameDTO entity) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<GameDTO> readAll() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public GameDTO readByID(String id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean update(GameDTO entity) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean delete(String id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<GameDTO> search(String searchTerm) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    public List<GameDTO> getAllGames() {
        String sql = "SELECT g.game_id, g.game_name, g.price, g.release_date, g.platform, g.description, g.stock, g.image_url, g.created_at, g.updated_at, " +
                     "STRING_AGG(gr.genre_name, ', ') AS genres " +
                     "FROM tblGames g " +
                     "LEFT JOIN tblGameGenres gg ON g.game_id = gg.game_id " +
                     "LEFT JOIN tblGenres gr ON gg.genre_id = gr.genre_id " +
                     "GROUP BY g.game_id, g.game_name, g.price, g.release_date, g.platform, g.description, g.stock, g.image_url, g.created_at, g.updated_at";
        List<GameDTO> list = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                List<String> genres = new ArrayList<>();
                String genresStr = rs.getString("genres");
                if (genresStr != null) {
                    genres = new ArrayList<>(Arrays.asList(genresStr.split(", ")));
                }
                GameDTO game = new GameDTO(
                        rs.getInt("game_id"),
                        rs.getString("game_name"),
                        rs.getBigDecimal("price"),
                        rs.getDate("release_date"),
                        genres,
                        rs.getString("platform"),
                        rs.getString("description"),
                        rs.getInt("stock"),
                        rs.getString("image_url"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                list.add(game);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<GameDTO> getGameByName(String searchTerm) {
        String sql = "SELECT g.game_id, g.game_name, g.price, g.release_date, g.platform, g.description, g.stock, g.image_url, g.created_at, g.updated_at, " +
                     "STRING_AGG(gr.genre_name, ', ') AS genres " +
                     "FROM tblGames g " +
                     "LEFT JOIN tblGameGenres gg ON g.game_id = gg.game_id " +
                     "LEFT JOIN tblGenres gr ON gg.genre_id = gr.genre_id " +
                     "WHERE g.game_name LIKE ? " +
                     "GROUP BY g.game_id, g.game_name, g.price, g.release_date, g.platform, g.description, g.stock, g.image_url, g.created_at, g.updated_at";
        List<GameDTO> list = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + searchTerm + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                List<String> genres = new ArrayList<>();
                String genresStr = rs.getString("genres");
                if (genresStr != null) {
                    genres = new ArrayList<>(Arrays.asList(genresStr.split(", ")));
                }
                GameDTO game = new GameDTO(
                        rs.getInt("game_id"),
                        rs.getString("game_name"),
                        rs.getBigDecimal("price"),
                        rs.getDate("release_date"),
                        genres,
                        rs.getString("platform"),
                        rs.getString("description"),
                        rs.getInt("stock"),
                        rs.getString("image_url"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                list.add(game);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<GameDTO> getGamesByGenre(String genre) {
        String sql = "SELECT g.game_id, g.game_name, g.price, g.release_date, g.platform, g.description, g.stock, g.image_url, g.created_at, g.updated_at, " +
                     "STRING_AGG(gr.genre_name, ', ') AS genres " +
                     "FROM tblGames g " +
                     "LEFT JOIN tblGameGenres gg ON g.game_id = gg.game_id " +
                     "LEFT JOIN tblGenres gr ON gg.genre_id = gr.genre_id " +
                     "WHERE gr.genre_name = ? " +
                     "GROUP BY g.game_id, g.game_name, g.price, g.release_date, g.platform, g.description, g.stock, g.image_url, g.created_at, g.updated_at";
        List<GameDTO> list = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, genre);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                List<String> genres = new ArrayList<>();
                String genresStr = rs.getString("genres");
                if (genresStr != null) {
                    genres = new ArrayList<>(Arrays.asList(genresStr.split(", ")));
                }
                GameDTO game = new GameDTO(
                        rs.getInt("game_id"),
                        rs.getString("game_name"),
                        rs.getBigDecimal("price"),
                        rs.getDate("release_date"),
                        genres,
                        rs.getString("platform"),
                        rs.getString("description"),
                        rs.getInt("stock"),
                        rs.getString("image_url"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                list.add(game);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> getAllGenres() {
        String sql = "SELECT DISTINCT genre_name FROM tblGenres";
        List<String> genres = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String genre = rs.getString("genre_name");
                if (genre != null && !genre.trim().isEmpty()) {
                    genres.add(genre);
                }
            }
            System.out.println("getAllGenres: Found " + genres.size() + " genres: " + genres);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return genres;
    }

    public GameDTO getGameById(int gameId) {
        String sql = "SELECT g.game_id, g.game_name, g.price, g.release_date, g.platform, g.description, g.stock, g.image_url, g.created_at, g.updated_at, " +
                     "STRING_AGG(gr.genre_name, ', ') AS genres " +
                     "FROM tblGames g " +
                     "LEFT JOIN tblGameGenres gg ON g.game_id = gg.game_id " +
                     "LEFT JOIN tblGenres gr ON gg.genre_id = gr.genre_id " +
                     "WHERE g.game_id = ? " +
                     "GROUP BY g.game_id, g.game_name, g.price, g.release_date, g.platform, g.description, g.stock, g.image_url, g.created_at, g.updated_at";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, gameId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                List<String> genres = new ArrayList<>();
                String genresStr = rs.getString("genres");
                if (genresStr != null) {
                    genres = new ArrayList<>(Arrays.asList(genresStr.split(", ")));
                }
                return new GameDTO(
                        rs.getInt("game_id"),
                        rs.getString("game_name"),
                        rs.getBigDecimal("price"),
                        rs.getDate("release_date"),
                        genres,
                        rs.getString("platform"),
                        rs.getString("description"),
                        rs.getInt("stock"),
                        rs.getString("image_url"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int createOrder(int userId, BigDecimal totalAmount) {
        String sql = "INSERT INTO tblOrders (user_id, total_amount) VALUES (?, ?); SELECT SCOPE_IDENTITY() AS order_id;";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setBigDecimal(2, totalAmount);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("order_id");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void createOrderDetail(int orderId, int gameId, int quantity, BigDecimal price) {
        String sql = "INSERT INTO tblOrderDetails (order_id, game_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, gameId);
            ps.setInt(3, quantity);
            ps.setBigDecimal(4, price);
            ps.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void updateStock(int gameId, int quantity) {
        String sql = "UPDATE tblGames SET stock = stock - ? WHERE game_id = ? AND stock >= ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, gameId);
            ps.setInt(3, quantity);
            ps.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
