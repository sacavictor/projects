package org.presentation;

import org.dao.ClientDAO;
import org.model.Client;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/*
 * The graphical user interface that handles all client operations. It opens when the "client operations" button is pressed from the main interface
 */
public class ClientOperations extends JFrame {
    private ClientDAO clientDAO;
    private JTextField nameField;
    private JTextField emailField;
    private JTextField deleteIdField;
    private JTextField updateIdField;
    private JTextField updateNameField;
    private JTextField updateEmailField;

    public ClientOperations() {
        clientDAO = new ClientDAO();

        setTitle("Client Operations");
        setSize(400, 500); // Increased size to accommodate new update fields and button
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLayout(new GridLayout(6, 2)); // Updated layout to 6 rows

        JLabel nameLabel = new JLabel("Name:");
        nameField = new JTextField();
        JLabel emailLabel = new JLabel("Email:");
        emailField = new JTextField();

        JButton addButton = new JButton("Add Client");
        addButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String name = nameField.getText();
                String email = emailField.getText();
                Client client = new Client(0, name, email);
                clientDAO.insert(client);
                JOptionPane.showMessageDialog(ClientOperations.this, "Client added successfully");
            }
        });

        JLabel deleteIdLabel = new JLabel("Client ID to delete:");
        deleteIdField = new JTextField();

        JButton deleteButton = new JButton("Delete Client");
        deleteButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    int clientId = Integer.parseInt(deleteIdField.getText());
                    Client client = new Client();
                    client.setClient_id(clientId);
                    clientDAO.delete(client);
                    JOptionPane.showMessageDialog(ClientOperations.this, "Client deleted successfully");
                } catch (NumberFormatException ex) {
                    JOptionPane.showMessageDialog(ClientOperations.this, "Invalid Client ID");
                }
            }
        });

        JLabel updateIdLabel = new JLabel("Client ID to update:");
        updateIdField = new JTextField();
        JLabel updateNameLabel = new JLabel("New Name:");
        updateNameField = new JTextField();
        JLabel updateEmailLabel = new JLabel("New Email:");
        updateEmailField = new JTextField();

        JButton updateButton = new JButton("Update Client");
        updateButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    int clientId = Integer.parseInt(updateIdField.getText());
                    String newName = updateNameField.getText();
                    String newEmail = updateEmailField.getText();
                    Client client = new Client(clientId, newName, newEmail);
                    clientDAO.update(client);
                    JOptionPane.showMessageDialog(ClientOperations.this, "Client updated successfully");
                } catch (NumberFormatException ex) {
                    JOptionPane.showMessageDialog(ClientOperations.this, "Invalid Client ID");
                }
            }
        });

        add(nameLabel);
        add(nameField);
        add(emailLabel);
        add(emailField);
        add(addButton);
        add(deleteIdLabel);
        add(deleteIdField);
        add(deleteButton);
        add(updateIdLabel);
        add(updateIdField);
        add(updateNameLabel);
        add(updateNameField);
        add(updateEmailLabel);
        add(updateEmailField);
        add(updateButton);

        setVisible(true);
    }

    public static void main(String[] args) {

        new ClientOperations();
    }
}