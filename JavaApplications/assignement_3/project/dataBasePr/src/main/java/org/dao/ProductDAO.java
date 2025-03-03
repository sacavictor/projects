package org.dao;

import org.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import org.bll.ConnectionFactory;

/*
 * The class that implements insert, update delete operations from abstract class "AbstractDAO" for the products in the database*/
public class ProductDAO extends AbstractDAO<Product> {

    @Override
    public Product insert(Product product) {
        Connection connection = null;
        PreparedStatement statement = null;
        String query = "INSERT INTO Product (product_id, name, price, stock) VALUES (?, ?, ?, ?)";
        try {
            connection = ConnectionFactory.getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, product.getProduct_id());
            statement.setString(2, product.getName());
            statement.setBigDecimal(3, product.getPrice());
            statement.setInt(4, product.getStock());
            statement.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "ProductDAO:insert " + e.getMessage());
        } finally {
            ConnectionFactory.close(statement);
            ConnectionFactory.close(connection);
        }
        return product;
    }

    @Override
    public Product update(Product product) {
        Connection connection = null;
        PreparedStatement statement = null;
        String query = "UPDATE Product SET name = ?, price = ?, stock = ? WHERE product_id = ?";
        try {
            connection = ConnectionFactory.getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, product.getName());
            statement.setBigDecimal(2, product.getPrice());
            statement.setInt(3, product.getStock());
            statement.setInt(4, product.getProduct_id());
            statement.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "ProductDAO:update " + e.getMessage());
        } finally {
            ConnectionFactory.close(statement);
            ConnectionFactory.close(connection);
        }
        return product;
    }
    @Override
    public void delete(Product product) {
        Connection connection = null;
        PreparedStatement statement = null;
        String query = "DELETE FROM Product WHERE product_id = ?";
        try {
            connection = ConnectionFactory.getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, product.getProduct_id());
            statement.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "ProductDAO:delete " + e.getMessage());
        } finally {
            ConnectionFactory.close(statement);
            ConnectionFactory.close(connection);
        }
    }
}
