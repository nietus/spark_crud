package dao;

import model.Products;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ProductsDAO extends DAO {
    public ProductsDAO() {
        super();
        conectar();
    }

    public void finalize() {
        close();
    }
    
    public boolean insert(Products product) {
        boolean status = false;
        try {
            String sql = "INSERT INTO estoquemaster.products (nome, amount, min_amount, description, buying_price, selling_price, vality, user_id, provider_CNPJ, img_url) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setString(1, product.getNome());
            st.setInt(2, product.getAmount());
            st.setInt(3, product.getMin_amount());
            st.setString(4, product.getDescription());
            st.setDouble(5, product.getBuyingPrice());
            st.setDouble(6, product.getSellingPrice());
            LocalDate localDate = product.getLocalDate();
            st.setDate(7, Date.valueOf(localDate));
            st.setInt(8, product.getUserId());
            st.setInt(9, product.getProviderCNPJ());
            st.setString(10, product.getImg());
            st.executeUpdate();
            st.close();
            status = true;
        } catch (SQLException u) {
            throw new RuntimeException(u);
        }
        return status;
    }


    public Products get(int id) {
        Products product = null;

        try {
            String sql = "SELECT * FROM estoquemaster.products WHERE id = ?";
            PreparedStatement preparedStatement = conexao.prepareStatement(sql);
            preparedStatement.setInt(1, id); // Set the parameter value
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                product = new Products(
                    rs.getInt("id"),
                    rs.getString("nome"),
                    rs.getInt("amount"),
                    rs.getInt("min_amount"),
                    rs.getString("description"),
                    rs.getDouble("buying_price"),
                    rs.getDouble("selling_price"),
                    rs.getDate("vality").toLocalDate(),
                    rs.getInt("user_id"),
                    rs.getInt("provider_CNPJ"),
                    rs.getString("img_url")
                );
            }
            rs.close();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return product;
    }



    public List<Products> getAll(String email) {
        List<Products> productsList = new ArrayList<>();

        try {
            int userId = getUserIdByEmail(email);

            if (userId != -1) {
                String sql = "SELECT * FROM estoquemaster.products WHERE user_id = ?";
                PreparedStatement preparedStatement = conexao.prepareStatement(sql);
                preparedStatement.setInt(1, userId);
                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    Products product = new Products(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getInt("amount"),
                        rs.getInt("min_amount"),
                        rs.getString("description"),
                        rs.getDouble("buying_price"),
                        rs.getDouble("selling_price"),
                        rs.getDate("vality").toLocalDate(),
                        rs.getInt("user_id"),
                        rs.getInt("provider_CNPJ"),
                        rs.getString("img_url")
                    );
                    productsList.add(product);
                }
                
                rs.close();
                preparedStatement.close();
            }
        } catch (SQLException e) {
            System.err.println("Error executing the query: " + e.getMessage());
        }

        return productsList;
    }
    
    private int getUserIdByEmail(String email) {
        int userId = -1;

        try {
            String userSql = "SELECT id FROM estoquemaster.appuser WHERE email = ?";
            PreparedStatement userStatement = conexao.prepareStatement(userSql);
            userStatement.setString(1, email);
            ResultSet userResultSet = userStatement.executeQuery();

            if (userResultSet.next()) {
                userId = userResultSet.getInt("id");
            }

            // Close resources
            userResultSet.close();
            userStatement.close();
        } catch (SQLException e) {
            System.err.println("Error getting user ID: " + e.getMessage());
        }

        return userId;
    }


    public boolean update(Products product) {
        boolean status = false;
        try {
            // Set auto-commit to false
            conexao.setAutoCommit(false);

            String sql = "UPDATE estoquemaster.products SET nome = ?, amount = ?, min_amount = ?, description = ?, buying_price = ?, selling_price = ?, vality = ?, user_id = ?, provider_CNPJ = ?, img_url = ? "
                       + "WHERE id = ?";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setString(1, product.getNome());
            st.setInt(2, product.getAmount());
            st.setInt(3, product.getMin_amount());
            st.setString(4, product.getDescription());
            st.setDouble(5, product.getBuyingPrice());
            st.setDouble(6, product.getSellingPrice());
            LocalDate localDate = product.getLocalDate();
            st.setDate(7, Date.valueOf(localDate));
            st.setInt(8, product.getUserId());
            st.setInt(9, product.getProviderCNPJ());
            st.setString(10, product.getImg());
            st.setInt(11, product.getId());
            System.out.println(product.getId());
            st.executeUpdate();

            // Commit the transaction
            conexao.commit();

            st.close();
            status = true;
        } catch (SQLException u) {
            u.printStackTrace();

            try {
                conexao.rollback();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } finally {
            try {
                conexao.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return status;
    }


    public boolean delete(int id) {
        boolean status = false;
        try {
            Statement st = conexao.createStatement();
            st.executeUpdate("DELETE FROM estoquemaster.products WHERE id = " + id);
            st.close();
            status = true;
        } catch (SQLException u) {
            throw new RuntimeException(u);
        }
        return status;
    }
}
