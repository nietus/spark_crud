package service;

import dao.AppUserDAO;
import model.AppUsers;
import java.util.List;
import javax.servlet.http.HttpSession;

public class AppUserService {
    private AppUserDAO appUserDAO;

    public AppUserService() {
        this.appUserDAO = new AppUserDAO();
    }

    public boolean insertAppUser(String email, String password, int isPremium) {
        AppUsers appUser = new AppUsers(0, email, password, isPremium);
        return appUserDAO.insert(appUser);
    }

    public AppUsers getAppUser(String email) {
        return appUserDAO.get(email);
    }

    public List<AppUsers> getAllAppUsers() {
        return appUserDAO.getAll();
    }

    public boolean updateAppUser(String email, String newEmail, String newPassword, int newIsPremium) {
        AppUsers appUser = appUserDAO.get(email);
        if (appUser != null) {
            appUser.setEmail(newEmail);
            appUser.setPassword(newPassword);
            appUser.setIsPremium(newIsPremium);
            return appUserDAO.update(appUser);
        }
        return false;
    }

    public boolean deleteAppUser(int id) {
        return appUserDAO.delete(id);
    }
    
    public boolean authenticateUser(String email, String password, HttpSession session) {
        AppUsers user = appUserDAO.get(email);

        if (user != null && user.getPassword().equals(password)) {
            // User authenticated, store the user in the session
            session.setAttribute("user", user);
            return true;
        } else {
            return false;
        }
    }
    
    public AppUsers getUserByEmail(String email) {
        AppUsers user = appUserDAO.get(email);
        return user;
    }

    public void logoutUser(HttpSession session) {
        // Invalidate the session to log the user out
        session.invalidate();
    }

    public boolean isUserLoggedIn(HttpSession session) {
        // Check if a user is logged in by inspecting the session
        return session.getAttribute("user") != null;
    }
}
