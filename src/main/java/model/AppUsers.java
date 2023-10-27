package model;

public class AppUsers {
    private int id;
    private String email;
    private String password;
    private int isPremium;

    public AppUsers() {
        this.id = 0;
        this.email = "";
        this.password = "";
        this.isPremium = 0;
    }

    public AppUsers(int id, String email, String password, int isPremium) {
        setId(id);
        setEmail(email);
        setPassword(password);
        setIsPremium(isPremium);
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public void setIsPremium(int isPremium) {
        this.isPremium = isPremium;
    }

    public int getIsPremium() {
        return isPremium;
    }

    @Override
    public String toString() {
        return "User ID: " + id + ", Email: " + email + ", Premium: " + isPremium;
    }
}
