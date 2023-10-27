package service;

import dao.BuyerDAO;
import model.Buyers;

import java.util.List;

public class BuyersService {
    private BuyerDAO buyerDAO;

    public BuyersService() {
        this.buyerDAO = new BuyerDAO();
    }

    public boolean insertBuyer(int cpf, String nome, String address, String contactInfo, int user_id) {
        Buyers buyer = new Buyers(cpf, nome, address, contactInfo, user_id);
        return buyerDAO.insert(buyer);
    }

    public Buyers getBuyer(int cpf) {
        return buyerDAO.get(cpf);
    }

    public List<Buyers> getAllBuyers() {
        return buyerDAO.getAll();
    }

    public boolean updateBuyer(int cpf, String nome, String address, String contactInfo, int user_id) {
        Buyers buyer = new Buyers(cpf, nome, address, contactInfo, user_id);
        return buyerDAO.update(buyer);
    }

    public boolean deleteBuyer(int cpf) {
        return buyerDAO.delete(cpf);
    }
}
