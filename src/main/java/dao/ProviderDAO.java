package dao;

import model.Provider;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ProviderDAO extends DAO {
    public ProviderDAO() {
        super();
        conectar();
    }

    public void finalize() {
        close();
    }

    public boolean insert(Provider provider) {
        boolean status = false;
        try {
            String sql = "INSERT INTO estoquemaster.provider (CNPJ, nome, contact_info) "
                       + "VALUES (?, ?, ?,);";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setInt(1, provider.getCNPJ());
            st.setString(2, provider.getNome());
            st.setString(3, provider.getContactInfo());
            st.executeUpdate();
            st.close();
            status = true;
        } catch (SQLException u) {
            throw new RuntimeException(u);
        }
        return status;
    }


    public Provider get(int CNPJ) {
        Provider provider = null;

        try {
            Statement st = conexao.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            String sql = "SELECT * FROM estoquemaster.provider WHERE CNPJ=" + CNPJ;
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) {
                provider = new Provider(rs.getInt("CNPJ"),rs.getString("nome"), rs.getString("contact_info"));
            }
            st.close();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return provider;
    }

    public List<Provider> getAll() {
        List<Provider> providerList = new ArrayList<>();

        try {
            String sql = "SELECT * FROM estoquemaster.provider";
            PreparedStatement preparedStatement = conexao.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Provider provider = new Provider(rs.getInt("CNPJ"),rs.getString("nome"), rs.getString("contact_info"));
                providerList.add(provider);
            }

            // Close resources
            rs.close();
            preparedStatement.close();
        } catch (SQLException e) {
            System.err.println("Error executing the query: " + e.getMessage());
        }

        return providerList;
    }

    public boolean update(Provider provider) {
        boolean status = false;
        try {
            String sql = "UPDATE estoquemaster.provider SET CNPJ = ?, nome = ?, contact_info = ? "
                       + "WHERE CNPJ = ?";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setInt(1, provider.getCNPJ());
            st.setString(2, provider.getNome());
            st.setString(3, provider.getContactInfo());
            st.executeUpdate();
            st.close();
            status = true;
        } catch (SQLException u) {
            throw new RuntimeException(u);
        }
        return status;
    }

    public boolean delete(int CNPJ) {
        boolean status = false;
        try {
            Statement st = conexao.createStatement();
            st.executeUpdate("DELETE FROM estoquemaster.provider WHERE CNPJ = " + CNPJ);
            st.close();
            status = true;
        } catch (SQLException u) {
            throw new RuntimeException(u);
        }
        return status;
    }
}
