package service;

import dao.TransactionsDAO;
import model.Transactions;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public class TransactionService {
    private TransactionsDAO transactionsDAO;

    public TransactionService() {
        this.transactionsDAO = new TransactionsDAO();
    }

    public boolean insertTransaction(LocalDate date, int buyerCpf, int productId, int productsUserId, int amountSold, double price) {
        Transactions transaction = new Transactions();
        transaction.setDate(date);
        transaction.setBuyerCpf(buyerCpf);
        transaction.setProductsId(productId);
        transaction.setProductsUserId(productsUserId);
        transaction.setAmount_sold(amountSold);
        transaction.setPrice(price);
        
        try {
            transactionsDAO.insert(transaction);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Transactions getTransaction(int id) {
        try {
            return transactionsDAO.get(id);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Transactions> getAllTransactions(int user_id) {
         return transactionsDAO.getAll(user_id);
    }

    public boolean updateTransaction(int id, LocalDate date, int buyerCpf, int productId, int productsUserId, int amountSold, double price) {
        Transactions transaction = new Transactions();
        transaction.setId(id);
        transaction.setDate(date);
        transaction.setBuyerCpf(buyerCpf);
        transaction.setProductsId(productId);
        transaction.setProductsUserId(productsUserId);
        transaction.setAmount_sold(amountSold);
        transaction.setPrice(price);
        
        try {
            transactionsDAO.update(transaction);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteTransaction(int id) {
        try {
            transactionsDAO.delete(id);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

	public List<Transactions> getTransactionsByProductId(int productId, int user_id) {
	        return transactionsDAO.getProducts(productId,user_id);
	}
}
