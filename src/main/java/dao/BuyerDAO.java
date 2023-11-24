package dao;

import model.Buyers;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BuyerDAO extends DAO {
    public BuyerDAO() {
        super();
        conectar();
    }

    public void finalize() {
        close();
    }

    public boolean insert(Buyers buyer) {
        boolean status = false;
        try {
            String sql = "INSERT INTO estoquemaster.buyer (cpf, name, address, contact_info, user_id) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setInt(1, buyer.getCPF());
            st.setString(2, buyer.getNome());
            st.setString(3, buyer.getAddress());
            st.setString(4, buyer.getContactInfo());
            st.setInt(5, buyer.getUserId());
            st.executeUpdate();
            st.close();
            status = true;
        } catch (SQLException u) {
            throw new RuntimeException(u);
        }
        return status;
    }

    public Buyers get(int cpf) {
        Buyers buyer = null;

        try {
            String sql = "SELECT cpf, nome, address, contact_info, user_id FROM estoquemaster.buyer WHERE cpf=?";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setInt(1, cpf);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                buyer = new Buyers(rs.getInt("cpf"), rs.getString("nome"), rs.getString("address"), rs.getString("contact_info"), rs.getInt("user_id"));
            }
            st.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return buyer;
    }

    public List<Buyers> getAll() {
        List<Buyers> buyerList = new ArrayList<>();

        try {
            String sql = "SELECT cpf, nome, address, contact_info, user_id FROM estoquemaster.buyer";
            PreparedStatement preparedStatement = conexao.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Buyers buyer = new Buyers(rs.getInt("cpf"), rs.getString("nome"), rs.getString("address"), rs.getString("contact_info"), rs.getInt("user_id"));
                buyerList.add(buyer);
            }

            rs.close();
            preparedStatement.close();
        } catch (SQLException e) {
            System.err.println("Error executing the query: " + e.getMessage());
        }

        return buyerList;
    }

    public boolean update(Buyers buyer) {
        boolean status = false;
        try {
            String sql = "UPDATE estoquemaster.buyer SET nome=?, address=?, contact_info=?, user_id=? WHERE cpf=?";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setString(1, buyer.getNome());
            st.setString(2, buyer.getAddress());
            st.setString(3, buyer.getContactInfo());
            st.setInt(4, buyer.getUserId());
            st.setInt(5, buyer.getCPF());
            st.executeUpdate();
            st.close();
            status = true;
        } catch (SQLException u) {
            throw new RuntimeException(u);
        }
        return status;
    }

    public boolean delete(int cpf) {
        boolean status = false;
        try {
            String sql = "DELETE FROM estoquemaster.buyer WHERE cpf=?";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setInt(1, cpf);
            st.executeUpdate();
            st.close();
            status = true;
        } catch (SQLException u) {
            throw new RuntimeException(u);
        }
        return status;
    }
}
