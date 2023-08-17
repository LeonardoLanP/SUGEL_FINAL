package mx.edu.utez.exameneslinea.model;

public class User_sub extends Subject{
    private int id_user_sub;
    private int user_id;
    private int sub_id;

    public User_sub() {
    }

    public User_sub(int id_user_sub, int user_id, int sub_id) {
        this.id_user_sub = id_user_sub;
        this.user_id = user_id;
        this.sub_id = sub_id;
    }

    public User_sub(int id_sub, int grade, String grouSub, String subname, int statusub, int id_user_sub, int user_id, int sub_id) {
        super(id_sub, grade, grouSub, subname, statusub);
        this.id_user_sub = id_user_sub;
        this.user_id = user_id;
        this.sub_id = sub_id;
    }

    public int getId_user_sub() {
        return id_user_sub;
    }

    public void setId_user_sub(int id_user_sub) {
        this.id_user_sub = id_user_sub;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getSub_id() {
        return sub_id;
    }

    public void setSub_id(int sub_id) {
        this.sub_id = sub_id;
    }
}