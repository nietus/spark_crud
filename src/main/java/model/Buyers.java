package model;

// Aqui eu crio a classe Products com os getters e setters
public class Buyers {
    private int cpf;
    private String nome;
    private String address;
    private String contactInfo;
    private int user_id;

    public Buyers() {
        this.cpf = 0;
        this.nome = "";
        this.address = "";
        this.contactInfo = "";
        this.user_id = 0;
    }

    public Buyers(int cpf, String nome, String address, String contactInfo, int user_id) {
        setCpf(cpf);
        setNome(nome);
        setAddress(address);
        setContactInfo(contactInfo);
        setUserId(user_id);
    }

    public void setUserId(int user_id) {
		this.user_id = user_id;
	}
    
    public int getUserId() {
    	return user_id;
    }

	public void setCpf(int cpf) {
		this.cpf = cpf;
	}

	public int getCPF() {
        return cpf;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getNome() {
        return nome;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddress() {
        return address;
    }

    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }

    public String getContactInfo() {
        return contactInfo;
    }

    @Override
    public String toString() {
        return "Buyer: " + nome + ", Endereço: " + address + ", Contato: " + contactInfo;
    }

}

