package model;

import java.time.LocalDate;

public class Transactions {
    private int id;
    private LocalDate date;
    private int buyer_cpf;
    private int products_id; // Updated attribute name
    private int products_user_id; // Updated attribute name
    private int amount_sold;
    private double price;

    public Transactions() {
        this.id = 0;
        this.date = LocalDate.now();
        this.buyer_cpf = 0;
        this.amount_sold = 0;
        this.price = 0.0;
        this.products_id = 0;
        this.products_user_id = 0;
    }

    public Transactions(int id, LocalDate date, int buyerCpf, int productsId, int productsUserId, int amountSold, double price) {
        setId(id);
        setDate(date);
        setBuyerCpf(buyerCpf);
        setProductsId(productsId);
        setProductsUserId(productsUserId);
        setAmount_sold(amountSold);
        setPrice(price);
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setBuyerCpf(int buyerCpf) {
        this.buyer_cpf = buyerCpf;
    }

    public int getBuyerCpf() {
        return buyer_cpf;
    }

    public void setProductsId(int productsId) {
        this.products_id = productsId;
    }

    public int getProductsId() {
        return products_id;
    }

    public void setProductsUserId(int productsUserId) {
        this.products_user_id = productsUserId;
    }

    public int getProductsUserId() {
        return products_user_id;
    }
    
	public int getAmount_sold() {
		return amount_sold;
	}

	public void setAmount_sold(int amount_sold) {
		this.amount_sold = amount_sold;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
}
