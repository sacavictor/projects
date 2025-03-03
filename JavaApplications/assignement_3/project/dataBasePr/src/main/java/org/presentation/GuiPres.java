package org.presentation;

import org.dao.ClientDAO;
import org.dao.ProductDAO;
import org.dao.OrderDAO;
import org.model.Client;
import org.model.Product;
import org.model.Orders;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.lang.reflect.Field;
import java.util.List;
/*
* Class that implements the main graphical user interface of the application*/

public class GuiPres extends JFrame {

    private JPanel mainPanel;
    private JButton clientsButton;
    private JButton clientOperationsButton;
    private JButton productsButton;
    private JButton ordersButton;
    private JButton addOrderButton;
    private JButton editProductButton;
    private JTable dataTable;
    private ClientDAO clientDAO;
    private ProductDAO productDAO;
    private OrderDAO orderDAO;

    public GuiPres() {
        clientDAO = new ClientDAO();
        productDAO = new ProductDAO();
        orderDAO = new OrderDAO();

        mainPanel = new JPanel(new BorderLayout());
        JPanel buttonPanel = new JPanel(new FlowLayout());
        clientsButton = new JButton("Show Clients");
        productsButton = new JButton("Show Products");
        ordersButton = new JButton("Show Orders");
        clientOperationsButton = new JButton("Client Operations");
        editProductButton = new JButton("Product Operations");
        addOrderButton = new JButton("Create Order");

        buttonPanel.add(clientsButton);
        buttonPanel.add(productsButton);
        buttonPanel.add(ordersButton);
        buttonPanel.add(clientOperationsButton);
        buttonPanel.add(editProductButton);
        buttonPanel.add(addOrderButton);

        dataTable = new JTable();
        JScrollPane scrollPane = new JScrollPane(dataTable);

        mainPanel.add(buttonPanel, BorderLayout.NORTH);
        mainPanel.add(scrollPane, BorderLayout.CENTER);

        setContentPane(mainPanel);
        setTitle("Data Display");
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setSize(800, 600);
        setVisible(true);

        clientsButton.addActionListener(e -> displayData(clientDAO.findAll(), Client.class));
        productsButton.addActionListener(e -> displayData(productDAO.findAll(), Product.class));
        ordersButton.addActionListener(e -> displayData(orderDAO.findAll(), Orders.class));
        clientOperationsButton.addActionListener(e -> new ClientOperations());
        editProductButton.addActionListener(e -> new ProductOperation());
        addOrderButton.addActionListener(e -> new OrderOperations());
    }

    private <T> void displayData(List<T> dataList, Class<T> clazz) {
        DefaultTableModel model = new DefaultTableModel();
        for (Field field : clazz.getDeclaredFields()) {
            model.addColumn(field.getName());
        }
        for (T item : dataList) {
            Object[] rowData = new Object[clazz.getDeclaredFields().length];
            for (int i = 0; i < clazz.getDeclaredFields().length; i++) {
                try {
                    Field field = clazz.getDeclaredFields()[i];
                    field.setAccessible(true);
                    rowData[i] = field.get(item);
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            }
            model.addRow(rowData);
        }
        dataTable.setModel(model);
    }

    public static void main(String[] args) {
        new GuiPres();
    }
}