package dao;

import model.AppUsers;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class AppUserDAO extends DAO {
    public AppUserDAO() {
        super();
        conectar();
    }

    public void finalize() {
        close();
    }

    public boolean insert(AppUsers user) {
        boolean status = false;
        try {
            String sql = "INSERT INTO estoquemaster.appuser (email, password, ispremium) VALUES (?, ?, ?)";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setString(1, user.getEmail());
            st.setString(2, user.getPassword());
            st.setInt(3, user.getIsPremium());
            st.executeUpdate();
            st.close();
            status = true;
        } catch (SQLException u) {
            throw new RuntimeException(u);
        }
        return status;
    }

    public AppUsers get(String email) {
        AppUsers user = null;

        try {
            String sql = "SELECT id, email, password, ispremium FROM estoquemaster.appuser WHERE email=?";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                user = new AppUsers(rs.getInt("id"), rs.getString("email"), rs.getString("password"), rs.getInt("ispremium"));
            }
            st.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return user;
    }

    public List<AppUsers> getAll() {
        List<AppUsers> userList = new ArrayList<>();

        try {
            String sql = "SELECT id, email, password, ispremium FROM estoquemaster.appuser";
            PreparedStatement preparedStatement = conexao.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                AppUsers user = new AppUsers(rs.getInt("id"), rs.getString("email"), rs.getString("password"), rs.getInt("ispremium"));
                userList.add(user);
            }

            rs.close();
            preparedStatement.close();
        } catch (SQLException e) {
            System.err.println("Error executing the query: " + e.getMessage());
        }

        return userList;
    }

    public boolean update(AppUsers user) {
        boolean status = false;
        try {
            String sql = "UPDATE estoquemaster.appuser SET password=? WHERE email=?";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setString(1, user.getPassword());
            st.setString(2, user.getEmail());
            st.executeUpdate();
            st.close();
            status = true;
        } catch (SQLException u) {
            throw new RuntimeException(u);
        }
        return status;
    }
    
    public AppUsers getUserByEmail(String email) {
        AppUsers user = null;
        try {
            String sql = "SELECT id, email, password, ispremium FROM estoquemaster.appuser WHERE email=?";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                user = new AppUsers(rs.getInt("id"), rs.getString("email"), rs.getString("password"), rs.getInt("ispremium"));
            }
            st.close();
        } catch (SQLException e) {
            System.err.println("Error retrieving user by email: " + e.getMessage());
        }
        return user;
    }

    public boolean delete(int id) {
        boolean status = false;
        try {
            String sql = "DELETE FROM estoquemaster.appuser WHERE id=?";
            PreparedStatement st = conexao.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
            st.close();
            status = true;
        } catch (SQLException u) {
            throw new RuntimeException(u);
        }
        return status;
    }
}
