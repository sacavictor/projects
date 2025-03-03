package org.presentation;

import org.dao.ClientDAO;
import org.dao.OrderDAO;
import org.dao.ProductDAO;
import org.model.Client;
import org.model.Orders;
import org.model.Product;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Date;
import java.util.List;
import java.util.Random;

/*
 * The graphical user interface that handles all orders operations. It opens when the "order operations" button is pressed from the main interface
 */
public class OrderOperations extends JFrame {
    private ClientDAO clientDAO;
    private ProductDAO productDAO;
    private OrderDAO orderDAO;
    private JComboBox<Client> clientComboBox;
    private JComboBox<Product> productComboBox;
    private JTextField quantityField;
    private JTextField orderDateField;

    public OrderOperations() {
        clientDAO = new ClientDAO();
        productDAO = new ProductDAO();
        orderDAO = new OrderDAO();

        setTitle("Order Operations");
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLayout(new GridLayout(6, 2));

        JLabel clientLabel = new JLabel("Client:");
        clientComboBox = new JComboBox<>();
        List<Client> clients = clientDAO.findAll();
        for (Client client : clients) {
            clientComboBox.addItem(client);
        }

        JLabel productLabel = new JLabel("Product:");
        productComboBox = new JComboBox<>();
        List<Product> products = productDAO.findAll();
        for (Product product : products) {
            productComboBox.addItem(product);
        }

        JLabel quantityLabel = new JLabel("Quantity:");
        quantityField = new JTextField();

        JLabel orderDateLabel = new JLabel("Order Date (yyyy-mm-dd):");
        orderDateField = new JTextField();

        JButton createOrderButton = new JButton("Create Order");
        createOrderButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Client selectedClient = (Client) clientComboBox.getSelectedItem();
                Product selectedProduct = (Product) productComboBox.getSelectedItem();
                int quantity = Integer.parseInt(quantityField.getText());
                Date orderDate = java.sql.Date.valueOf(orderDateField.getText());

                if (selectedProduct.getStock() < quantity) {
                    JOptionPane.showMessageDialog(OrderOperations.this, "Under-stock: Not enough products in stock");
                } else {

                    Orders order = new Orders((new Random()).ints(1, 100).findFirst().getAsInt(), selectedClient.getClient_id(), selectedProduct.getProduct_id(), quantity, orderDate);
                    orderDAO.insert(order);
                    selectedProduct.setStock(selectedProduct.getStock() - quantity);
                    productDAO.update(selectedProduct);
                    JOptionPane.showMessageDialog(OrderOperations.this, "Order created successfully");
                }
            }
        });

        add(clientLabel);
        add(clientComboBox);
        add(productLabel);
        add(productComboBox);
        add(quantityLabel);
        add(quantityField);
        add(orderDateLabel);
        add(orderDateField);
        add(createOrderButton);

        setVisible(true);
    }

    public static void main(String[] args) {

        new OrderOperations();
    }
}