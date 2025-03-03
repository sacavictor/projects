package org.dao;

import org.model.Client;
import org.bll.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Level;

/*
* The class that implements insert, update delete operations from abstract class "AbstractDAO" for the clients in the database*/

public class ClientDAO extends AbstractDAO<Client> {

    /*Inserts the client from argument
    * @return the new client*/

    @Override
    public Client insert(Client client) {
        Connection connection = null;
        PreparedStatement statement = null;
        String query = "INSERT INTO Client (client_id, name, email) VALUES (?, ?, ?)";
        try {
            connection = ConnectionFactory.getConnection();
            statement = connection.prepareStatement(query);
            client.setClient_id((new Random()).nextInt(300) + 3);
            statement.setInt(1, client.getClient_id());
            statement.setString(2, client.getName());
            statement.setString(3, client.getEmail());
            statement.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "ClientDAO:insert " + e.getMessage());
        } finally {
            ConnectionFactory.close(statement);
            ConnectionFactory.close(connection);
        }
        return client;
    }

    /*updates the client from the argument (found by ID)
    * @return the new client*/
    @Override
    public Client update(Client client) {
        Connection connection = null;
        PreparedStatement statement = null;
        String query = "UPDATE Client SET name = ?, email = ? WHERE client_id = ?";
        try {
            connection = ConnectionFactory.getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, client.getName());
            statement.setString(2, client.getEmail());
            statement.setInt(3, client.getClient_id());
            statement.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "ClientDAO:update " + e.getMessage());
        } finally {
            ConnectionFactory.close(statement);
            ConnectionFactory.close(connection);
        }
        return client;
    }

    /*
    * deletes the client from argument (found by id)
    * @return void*/
    @Override
    public void delete(Client client) {
        Connection connection = null;
        PreparedStatement statement = null;
        String query = "DELETE FROM Client WHERE client_id = ?";
        try {
            connection = ConnectionFactory.getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, client.getClient_id());
            statement.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "ClientDAO:delete " + e.getMessage());
        } finally {
            ConnectionFactory.close(statement);
            ConnectionFactory.close(connection);
        }

    }

}