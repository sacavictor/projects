package org.model;

import java.math.BigDecimal;

/*
 * The corresponding products table from database*/

public class Product {
    private int product_id;
    private String name;
    private BigDecimal price;
    private int stock;

    public Product(int product_id, String name, BigDecimal price, int stock) {
        this.product_id = product_id;
        this.name = name;
        this.price = price;
        this.stock = stock;
    }

    public Product() {
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int productId) {
        this.product_id = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    @Override
    public String toString() {
        return
                "product_id=" + product_id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", stock=" + stock;
    }
}