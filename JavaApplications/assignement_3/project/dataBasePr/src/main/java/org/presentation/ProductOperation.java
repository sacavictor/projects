package org.presentation;

import org.dao.ProductDAO;
import org.model.Product;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.math.BigDecimal;
import java.util.Random;
/*
* The graphical user interface that handles all product operations. It opens when the "product operations" button is pressed from the main interface
*/

public class ProductOperation extends JFrame {
    private ProductDAO productDAO;
    private JTextField productIdField;
    private JTextField nameField;
    private JTextField priceField;
    private JTextField stockField;
    private JTextField deleteIdField;
    private JTextField updateIdField;
    private JTextField updateNameField;
    private JTextField updatePriceField;
    private JTextField updateStockField;

    public ProductOperation() {
        productDAO = new ProductDAO();

        setTitle("Product Operations");
        setSize(500, 600);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLayout(new GridLayout(10, 2));

        JLabel nameLabel = new JLabel("Name:");
        nameField = new JTextField();
        JLabel priceLabel = new JLabel("Price:");
        priceField = new JTextField();
        JLabel stockLabel = new JLabel("Stock:");
        stockField = new JTextField();

        JButton addButton = new JButton("Add Product");
        addButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String name = nameField.getText();
                Double price = Double.parseDouble(priceField.getText());
                BigDecimal d = new BigDecimal(price);
                int stock = Integer.parseInt(stockField.getText());
                Product product = new Product((new Random(100)).nextInt() + 3, name, d, stock);
                productDAO.insert(product);
                JOptionPane.showMessageDialog(ProductOperation.this, "Product added successfully");
            }
        });

        JLabel deleteIdLabel = new JLabel("Product ID to delete:");
        deleteIdField = new JTextField();

        JButton deleteButton = new JButton("Delete Product");
        deleteButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    int productId = Integer.parseInt(deleteIdField.getText());
                    Product product = new Product();
                    product.setProduct_id(productId);
                    productDAO.delete(product);
                    JOptionPane.showMessageDialog(ProductOperation.this, "Product deleted successfully");
                } catch (NumberFormatException ex) {
                    JOptionPane.showMessageDialog(ProductOperation.this, "Invalid Product ID");
                }
            }
        });

        JLabel updateIdLabel = new JLabel("Product ID to update:");
        updateIdField = new JTextField();
        JLabel updateNameLabel = new JLabel("New Name:");
        updateNameField = new JTextField();
        JLabel updatePriceLabel = new JLabel("New Price:");
        updatePriceField = new JTextField();
        JLabel updateStockLabel = new JLabel("New Stock:");
        updateStockField = new JTextField();

        JButton updateButton = new JButton("Update Product");
        updateButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    int productId = Integer.parseInt(updateIdField.getText());
                    String newName = updateNameField.getText();
                    double newPrice = Double.parseDouble(updatePriceField.getText());
                    BigDecimal pr = new BigDecimal(newPrice);
                    int newStock = Integer.parseInt(updateStockField.getText());
                    Product product = new Product(productId, newName, pr, newStock);
                    productDAO.update(product);
                    JOptionPane.showMessageDialog(ProductOperation.this, "Product updated successfully");
                } catch (NumberFormatException ex) {
                    JOptionPane.showMessageDialog(ProductOperation.this, "Invalid input");
                }
            }
        });

        add(nameLabel);
        add(nameField);
        add(priceLabel);
        add(priceField);
        add(stockLabel);
        add(stockField);
        add(addButton);
        add(deleteIdLabel);
        add(deleteIdField);
        add(deleteButton);
        add(updateIdLabel);
        add(updateIdField);
        add(updateNameLabel);
        add(updateNameField);
        add(updatePriceLabel);
        add(updatePriceField);
        add(updateStockLabel);
        add(updateStockField);
        add(updateButton);

        setVisible(true);
    }

    public static void main(String[] args) {

        new ProductOperation();
    }
}