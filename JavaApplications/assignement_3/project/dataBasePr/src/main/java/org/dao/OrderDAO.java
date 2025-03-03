package org.dao;

import org.model.Orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import org.bll.ConnectionFactory;

/*
 * The class that implements insert, update delete operations from abstract class "AbstractDAO" for the orders in the database*/
public class OrderDAO extends AbstractDAO<Orders> {

    @Override
    public Orders insert(Orders orders) {
        Connection connection = null;
        PreparedStatement statement = null;
        String query = "INSERT INTO Orders (order_id, client_id, product_id, quantity, order_date) VALUES (?, ?, ?, ?, ?)";
        try {
            connection = ConnectionFactory.getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, orders.getOrder_id());
            statement.setInt(2, orders.getClient_id());
            statement.setInt(3, orders.getProduct_id());
            statement.setInt(4, orders.getQuantity());
            statement.setDate(5, new java.sql.Date(orders.getOrder_date().getTime()));
            statement.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "OrderDAO:insert " + e.getMessage());
        } finally {
            ConnectionFactory.close(statement);
            ConnectionFactory.close(connection);
        }
        return orders;
    }

    @Override
    public Orders update(Orders orders) {
        Connection connection = null;
        PreparedStatement statement = null;
        String query = "UPDATE Orders SET client_id = ?, product_id = ?, quantity = ?, order_date = ? WHERE order_id = ?";
        try {
            connection = ConnectionFactory.getConnection();
            statement = connection.prepareStatement(query);

            statement.setInt(1, orders.getClient_id());
            statement.setInt(2, orders.getProduct_id());
            statement.setInt(3, orders.getQuantity());
            statement.setDate(4, orders.getOrder_date());
            statement.setInt(5, orders.getOrder_id());
            statement.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "OrderDAO:update " + e.getMessage());
        } finally {
            ConnectionFactory.close(statement);
            ConnectionFactory.close(connection);
        }
        return orders;
    }
}
