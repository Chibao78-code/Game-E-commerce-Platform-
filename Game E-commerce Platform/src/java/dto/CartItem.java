package dto;

import java.math.BigDecimal;

public class CartItem {
    private int gameId;
    private String gameName;
    private BigDecimal price;
    private int quantity;

    public CartItem() {
    }

    public CartItem(int gameId, String gameName, BigDecimal price, int quantity) {
        this.gameId = gameId;
        this.gameName = gameName;
        this.price = price;
        this.quantity = quantity;
    }

    public int getGameId() {
        return gameId;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getTotalPrice() {
        return price.multiply(BigDecimal.valueOf(quantity));
    }
}