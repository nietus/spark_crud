package service;

import dao.ProviderDAO;
import model.Provider;

import java.time.LocalDate;
import java.util.List;

public class ProviderService {
    private ProviderDAO providerDAO;

    public ProviderService() {
        this.providerDAO = new ProviderDAO();
    }

    public boolean insertProvider( int CNPJ, String nome, String contact_info) {
        Provider provider = new Provider(CNPJ, nome, contact_info);
        return providerDAO.insert(provider);
    }

    public Provider getProvider(int contact_info) {
        return providerDAO.get(contact_info);
    }

    public List<Provider> getAllProvider() {
        return providerDAO.getAll();
    }

    public boolean updateProvider(int CNPJ, String nome, String contact_info) {
        Provider provider = new Provider(CNPJ, nome, contact_info);
        return providerDAO.update(provider);
    }

    public boolean deleteProvider(int CNPJ) {
        return providerDAO.delete(CNPJ);
    }

}