/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;
import utils.PasswordUtils;

/**
 *
 * @author LENOVO
 */
public class UserDAO implements IDAO<UserDTO, String>{

    @Override
    public boolean create(UserDTO entity) {
        String sql = "INSERT INTO tblUsers (username, password, email, phone, address, role, fullname) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Băm mật khẩu trước khi lưu
            String hashedPassword = PasswordUtils.hashPassword(entity.getPassword());
            if (hashedPassword == null) {
                throw new SQLException("Failed to hash password");
            }

            ps.setString(1, entity.getUsername());
            ps.setString(2, hashedPassword); // Lưu mật khẩu đã băm
            ps.setString(3, entity.getEmail());
            ps.setString(4, entity.getPhone());
            ps.setString(5, entity.getAddress());
            ps.setString(6, entity.getRole());
            ps.setString(7, entity.getFullname());

            int n = ps.executeUpdate();
            return n > 0;

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Error creating user: " + entity.getUsername(), ex);
            return false;
        }
    }

    @Override
    public List<UserDTO> readAll() {
        List<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM tblUsers";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                UserDTO user = new UserDTO(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("fullname"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("role"),
                        rs.getTimestamp("created_at")
                );
                list.add(user);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }



    @Override
    public boolean update(UserDTO entity) {
        String sql = "UPDATE tblUsers SET username=?, fullname=?, password=?, email=?, phone=?, address=?, role=? WHERE user_id=?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String hashedPassword = PasswordUtils.hashPassword(entity.getPassword());
            if (hashedPassword == null) {
                throw new SQLException("Failed to hash password");
            }
            ps.setString(1, entity.getUsername());
            ps.setString(2, entity.getFullname());
            ps.setString(3, entity.getPassword());
            ps.setString(4, entity.getEmail());
            ps.setString(5, entity.getPhone());
            ps.setString(6, entity.getAddress());
            ps.setString(7, entity.getRole());
            ps.setInt(8, entity.getUserId());

            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }


    @Override
    public boolean delete(String userName) {
        String sql = "DELETE FROM tblUsers WHERE userName = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userName);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }


    @Override
    public List<UserDTO> search(String searchTerm) {
        List<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM tblUsers WHERE username LIKE ? OR fullname LIKE ? OR role LIKE ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserDTO user = new UserDTO(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("fullname"),
                            rs.getString("password"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getString("role"),
                            rs.getTimestamp("created_at")
                    );
                    list.add(user);
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }


    @Override
    public UserDTO readByID(String userName) {
        String sql = "SELECT * FROM tblUsers WHERE username = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new UserDTO(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("fullname"),
                            rs.getString("password"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getString("role"),
                            rs.getTimestamp("created_at")
                    );
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public List<UserDTO> getUserByName(String searchTerm) {
        String sql = "SELECT * FROM tblUsers WHERE fullname LIKE ?";
        List<UserDTO> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + searchTerm + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO user = new UserDTO(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("fullname"),
                    rs.getString("password"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getString("role"),
                    rs.getTimestamp("created_at"));
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi SQL đầy đủ ra console
        }
        return list;
    }
    
    public List<UserDTO> getAllUsers() {
        String sql = "SELECT user_id, username, fullname, email, phone, address, role, created_at " +
                     "FROM tblUsers";
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn == null) {
                System.out.println("Failed to get database connection");
                return list;
            }
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO user = new UserDTO(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("fullname"),
                    null,
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getString("role"),
                    rs.getTimestamp("created_at")
                );
                list.add(user);
            }
            System.out.println("getAllUsers: Found " + list.size() + " users");
        } catch (SQLException e) {
            System.err.println("SQL Error in getAllUsers: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        return list;
    }
}
