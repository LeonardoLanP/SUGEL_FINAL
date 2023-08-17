package mx.edu.utez.exameneslinea.model;

public class Subject {
    private int id_sub;
    private int grade;
    private String grouSub;
    private String subname;
    private int statusub;

    public Subject() {
    }

    public Subject(int id_sub, int grade, String grouSub, String subname, int statusub) {
        this.id_sub = id_sub;
        this.grade = grade;
        this.grouSub = grouSub;
        this.subname = subname;
        this.statusub = statusub;
    }

    public int getId_sub() {
        return id_sub;
    }

    public void setId_sub(int id_sub) {
        this.id_sub = id_sub;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public String getGrouSub() {
        return grouSub;
    }

    public void setGrouSub(String grouSub) {
        this.grouSub = grouSub;
    }

    public String getSubname() {
        return subname;
    }

    public void setSubname(String subname) {
        this.subname = subname;
    }

    public int getStatusub() {
        return statusub;
    }

    public void setStatusub(int statusub) {
        this.statusub = statusub;
    }
}