package service;

import dao.ProductsDAO;
import model.Products;

import java.time.LocalDate;
import java.util.List;

// Esse productservice soh chama os metodos do productsDAO pra rodar os scripts no db

public class ProductsService {
    private ProductsDAO productsDAO;

    public ProductsService() {
        this.productsDAO = new ProductsDAO();
    }

    public boolean insertProduct(String nome, int amount, int min_amount, String description, double buyingPrice, double sellingPrice,
                                 LocalDate vality, int userId, int providerCNPJ, String img_url) {
        Products product = new Products(0, nome, amount, min_amount, description, buyingPrice, sellingPrice, vality, userId, providerCNPJ, img_url);
        return productsDAO.insert(product);
    }

    public Products getProduct(int id) {
        return productsDAO.get(id);
    }

    public List<Products> getAllProducts(String email) {
        return productsDAO.getAll(email);
    }

    public boolean updateProduct(int id, String nome, int amount, int min_amount, String description, double buyingPrice, double sellingPrice,
                                 LocalDate vality, int userId, int providerCNPJ, String img_url) {
        Products product = new Products(id, nome, amount, min_amount, description, buyingPrice, sellingPrice, vality, userId, providerCNPJ, img_url);
        return productsDAO.update(product);
    }

    public boolean deleteProduct(int id) {
        return productsDAO.delete(id);
    }

}