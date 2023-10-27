package model;

public class Provider {
    private int CNPJ;
    private String nome;
    private String contact_info;

    public Provider() {
    	CNPJ = -1;
        nome = "";
        contact_info = "";
    }

    public Provider(int CNPJ, String nome, String contact_info) {
        setCNPJ(CNPJ);
    	setNome(nome);
        setContactInfo(contact_info);
    }

    private void setCNPJ(int CNPJ) {
		this.CNPJ = CNPJ;
	}

	public int getCNPJ() {
        return CNPJ;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getContactInfo() {
        return contact_info;
    }

    public void setContactInfo(String contact_info) {
        this.contact_info = contact_info;
    }

    @Override
    public String toString() {
        return "CNPJ: " + CNPJ + ", Nome: " + nome + ", Contact Info: " + contact_info;
    }

}
