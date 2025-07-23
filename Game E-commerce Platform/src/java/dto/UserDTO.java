package dto;

import java.sql.Date;
import java.sql.Timestamp;

public class UserDTO {
    private int userId;
    private String username;
    private String fullname;
    private String password;
    private String email;
    private String phone;
    private String address;
    private String role;
    private Timestamp createdAt;

    // Constructors
    public UserDTO() {}

    public UserDTO(int userId, String username, String fullname, String password, String email, String phone, String address, String role, Timestamp createdAt) {
        this.userId = userId;
        this.username = username;
        this.fullname = fullname;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.createdAt = createdAt;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "UserDTO{" + "userId=" + userId + ", username=" + username + ", fullname=" + fullname + ", password=" + password + ", email=" + email + ", phone=" + phone + ", address=" + address + ", role=" + role + ", createdAt=" + createdAt + '}';
    }

    
}
