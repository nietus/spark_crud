package dao;

import model.Provider;
import model.Transactions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TransactionsDAO extends DAO {
    public TransactionsDAO() {
        super();
        conectar();
    }

    public void finalize() {
        close();
    }

    // Create a new transaction
    public void insert(Transactions transaction) throws SQLException {
        String query = "INSERT INTO estoquemaster.transaction (date, buyer_cpf, products_id, products_user_id, amount_sold, price) " +
                       "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = conexao.prepareStatement(query)) {
            preparedStatement.setDate(1, java.sql.Date.valueOf(transaction.getDate()));
            preparedStatement.setInt(2, transaction.getBuyerCpf());
            preparedStatement.setInt(3, transaction.getProductsId());
            preparedStatement.setInt(4, transaction.getProductsUserId());
            preparedStatement.setInt(5, transaction.getAmount_sold());
            preparedStatement.setDouble(6, transaction.getPrice());
            preparedStatement.executeUpdate();
        }
    }

    // Retrieve a transaction by ID
    public Transactions get(int id) throws SQLException {
        String query = "SELECT * FROM estoquemaster.transaction WHERE id = ?";
        try (PreparedStatement preparedStatement = conexao.prepareStatement(query)) {
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                Transactions transaction = new Transactions();
                transaction.setId(resultSet.getInt("id"));
                transaction.setDate(resultSet.getDate("date").toLocalDate());
                transaction.setBuyerCpf(resultSet.getInt("buyer_cpf"));
                transaction.setProductsId(resultSet.getInt("product_id"));
                transaction.setProductsUserId(resultSet.getInt("products_user_id"));
                transaction.setAmount_sold(resultSet.getInt("amount_sold"));
                transaction.setPrice(resultSet.getDouble("price"));
                return transaction;
            } else {
                return null; // Transaction not found
            }
        }
    }

    // Update an existing transaction
    public void update(Transactions transaction) throws SQLException {
        String query = "UPDATE estoquemaster.transaction SET date = ?, buyer_cpf = ?, products_id = ?, products_user_id = ?, " +
                       "amount_sold = ?, price = ? WHERE id = ?";
        try (PreparedStatement preparedStatement = conexao.prepareStatement(query)) {
            preparedStatement.setDate(1, java.sql.Date.valueOf(transaction.getDate()));
            preparedStatement.setInt(2, transaction.getBuyerCpf());
            preparedStatement.setInt(3, transaction.getProductsId());
            preparedStatement.setInt(4, transaction.getProductsUserId());
            preparedStatement.setDouble(5, transaction.getAmount_sold());
            preparedStatement.setDouble(6, transaction.getPrice());
            preparedStatement.setInt(7, transaction.getId());
            preparedStatement.executeUpdate();
        }
    }

    // Delete a transaction by ID
    public void delete(int id) throws SQLException {
        String query = "DELETE FROM estoquemaster.transaction WHERE id = ?";
        try (PreparedStatement preparedStatement = conexao.prepareStatement(query)) {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        }
    }
    
    public List<Transactions> getAll(int id) {
        List<Transactions> trans = new ArrayList<>();

        try {
            String sql = "SELECT * FROM estoquemaster.transaction WHERE products_user_id = ?";
            
            PreparedStatement preparedStatement = conexao.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Transactions t = new Transactions(
                    rs.getInt("id"),
                    rs.getDate("date").toLocalDate(),
                    rs.getInt("buyer_cpf"),
                    rs.getInt("products_id"), // Assuming this is the correct column name
                    rs.getInt("products_user_id"),
                    rs.getInt("amount_sold"),
                    rs.getDouble("price")
                );
                trans.add(t);
            }

            // Close resources
            rs.close();
            preparedStatement.close();
        } catch (SQLException e) {
            System.err.println("Error executing the query: " + e.getMessage());
        }

        return trans;
    }

    public List<Transactions> getProducts(int productId, int user_id) {
        List<Transactions> trans = new ArrayList<>();

        try {
            String sql = "SELECT * FROM estoquemaster.transaction WHERE products_user_id = ? AND products_id = ?";
            
            PreparedStatement preparedStatement = conexao.prepareStatement(sql);
            preparedStatement.setInt(1, user_id);
            preparedStatement.setInt(2, productId);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Transactions t = new Transactions(
                    rs.getInt("id"),
                    rs.getDate("date").toLocalDate(),
                    rs.getInt("buyer_cpf"),
                    rs.getInt("products_id"),
                    rs.getInt("products_user_id"),
                    rs.getInt("amount_sold"),
                    rs.getDouble("price")
                );
                trans.add(t);
            }

            // Close resources
            rs.close();
            preparedStatement.close();
        } catch (SQLException e) {
            System.err.println("Error executing the query: " + e.getMessage());
        }

        return trans;
    }


}
