package mx.edu.utez.exameneslinea.model;

public class User {
    protected int ID_user;
    protected String user;
    protected String email;
    protected String pass;
    protected int user_status;
    protected int Rol_id;


    public User() {
    }

    public User(int ID_user, String user, String email, String pass, int user_status, int rol_id) {
        this.ID_user = ID_user;
        this.user = user;
        this.email = email;
        this.pass = pass;
        this.user_status = user_status;
        Rol_id = rol_id;
    }

    public int getID_user() {
        return ID_user;
    }

    public void setID_user(int ID_user) {
        this.ID_user = ID_user;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public int getUser_status() {
        return user_status;
    }

    public void setUser_status(int user_status) {
        this.user_status = user_status;
    }

    public int getRol_id() {
        return Rol_id;
    }

    public void setRol_id(int rol_id) {
        Rol_id = rol_id;
    }
}