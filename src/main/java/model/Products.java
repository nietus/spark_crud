package model;

import java.time.LocalDate;
import java.time.LocalDateTime;
// Aqui eu crio a classe Products com os getters e setters
public class Products {
    private int id;
    private String nome;
    private int amount;
    private int min_amount;
    private String description;
    private double buyingPrice;
    private double sellingPrice;
    private LocalDate vality;
    private int userId;
    private int providerCNPJ;
    private String img_url;

    public Products() {
    	id = -1;
        nome = "";
        amount = 0;
        min_amount = 0;
        description = "";
        buyingPrice = 0.00;
        sellingPrice = 0.00;
        userId = -1;
        providerCNPJ = -1;
        img_url = "https://keepmeme.com/files/en_posts/20200819/2e7175697eab40b392acf06d02002004cat-with-loading-sign-on-head.jpg";
    }

    public Products(int id, String nome, int amount, int min_amount, String description, double buyingPrice, double sellingPrice, LocalDate vality, int userId, int providerCNPJ, String img_url) {
        setId(id);
    	setNome(nome);
        setAmount(amount);
        setMin_amount(min_amount);
        setDescription(description);
        setBuyingPrice(buyingPrice);
        setSellingPrice(sellingPrice);
        setVality(vality);
        setUserId(userId);
        setProviderCNPJ(providerCNPJ);
        setImg(img_url);
    }

    private void setId(int id) {
		this.id = id;
		
	}

	public int getId() {
        return id;
    }
	
	private void setImg(String img_url) {
		this.img_url = img_url;
		
	}

	public String getImg() {
        return img_url;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getBuyingPrice() {
        return buyingPrice;
    }

    public void setBuyingPrice(double buyingPrice) {
        this.buyingPrice = buyingPrice;
    }

    public double getSellingPrice() {
        return sellingPrice;
    }

    public void setSellingPrice(double sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    public LocalDate getVality() {
        return vality;
    }

    public void setVality(LocalDate vality) {
        this.vality = vality;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProviderCNPJ() {
        return providerCNPJ;
    }

    public void setProviderCNPJ(int providerCNPJ) {
        this.providerCNPJ = providerCNPJ;
    }

    @Override
    public String toString() {
        return "Product: " + nome + ", Amount: " + amount + ", Description: " + description +
               ", Buying Price: " + buyingPrice + ", Selling Price: " + sellingPrice +
               ", Validity: " + vality + ", User ID: " + userId + ", Provider CNPJ: " + providerCNPJ;
    }

	public int getMin_amount() {
		return min_amount;
	}

	public void setMin_amount(int min_amount) {
		this.min_amount = min_amount;
	}

	public LocalDate getLocalDate() {
		LocalDateTime now = LocalDateTime.now();
        LocalDate date = now.toLocalDate();
        LocalDate vality = date;
        return vality;
	}

}
