/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import dao.UserDAO;
import dto.UserDTO;
import java.security.MessageDigest;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class PasswordUtils {
    public static String hashPassword(String plainPassword) {
        try {
            // Tạo MessageDigest với thuật toán SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");

            // Mã hóa mật khẩu
            byte[] messageDigest = md.digest(plainPassword.getBytes());

            // Chuyển byte[] thành chuỗi hex
            StringBuilder hexString = new StringBuilder();
            for (byte b : messageDigest) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            return null;
        }
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        String newHashedPassword = hashPassword(plainPassword);
        return newHashedPassword != null && newHashedPassword.equals(hashedPassword);
    }

    public static void migratePasswords() {
        UserDAO dao = new UserDAO();
        List<UserDTO> users = dao.readAll();
        if (users == null || users.isEmpty()) {
            System.out.println("Không có người dùng nào để di chuyển.");
            return;
        }

        for (UserDTO user : users) {
            String plainPassword = user.getPassword();
            // Kiểm tra xem mật khẩu đã băm chưa (SHA-256 tạo chuỗi 64 ký tự hex)
            if (plainPassword == null || plainPassword.length() == 64) {
                System.out.println("Mật khẩu của " + user.getUsername() + " đã băm hoặc trống, bỏ qua.");
                continue;
            }

            String hashedPassword = PasswordUtils.hashPassword(plainPassword);
            if (hashedPassword != null) {
                user.setPassword(hashedPassword);
                boolean updated = dao.update(user);
                System.out.println("Cập nhật user " + user.getUsername() + ": " + (updated ? "Thành công" : "Thất bại"));
            } else {
                System.out.println("Lỗi mã hóa mật khẩu cho user: " + user.getUsername());
            }
        }
        System.out.println("Di chuyển mật khẩu sang SHA-256 hoàn tất");
    }
    
    public static void main(String[] args) {
        /*
        ALTER TABLE [dbo].[tblUsers]
        ALTER COLUMN [password] [varchar](250) NOT NULL;
        */
        migratePasswords();
    }
}
