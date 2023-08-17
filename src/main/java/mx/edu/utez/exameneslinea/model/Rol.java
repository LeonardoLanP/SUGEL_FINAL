package mx.edu.utez.exameneslinea.model;

public class Rol {
    private int id_rol;
    private String type_user;

    public Rol() {
    }

    public Rol(int id_rol, String type_user) {
        this.id_rol = id_rol;
        this.type_user = type_user;
    }

    public int getId_rol() {
        return id_rol;
    }

    public void setId_rol(int id_rol) {
        this.id_rol = id_rol;
    }

    public String getType_user() {
        return type_user;
    }

    public void setType_user(String type_user) {
        this.type_user = type_user;
    }
}
