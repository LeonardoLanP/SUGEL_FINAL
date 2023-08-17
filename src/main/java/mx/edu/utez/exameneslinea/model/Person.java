package mx.edu.utez.exameneslinea.model;

public class Person extends User {
    private int id_person;
    private String name;
    private String lastname1;
    private String lastname2;
    private String curp;
    private int User_id;
    private String subname;
    private String namex;
    private String grade;
    private String datex;

    public Person() {
    }

    public Person(int ID_user, String user, String email, String pass, int user_status, int rol_id, int id_person, String name, String lastname1, String lastname2, String curp, int user_id) {
        super(ID_user, user, email, pass, user_status, rol_id);
        this.id_person = id_person;
        this.name = name;
        this.lastname1 = lastname1;
        this.lastname2 = lastname2;
        this.curp = curp;
        User_id = user_id;
    }

    public Person(int id_person, String name, String lastname1, String lastname2, String curp, int user_id) {
        this.id_person = id_person;
        this.name = name;
        this.lastname1 = lastname1;
        this.lastname2 = lastname2;
        this.curp = curp;
        User_id = user_id;
    }

    public int getId_person() {
        return id_person;
    }

    public void setId_person(int id_person) {
        this.id_person = id_person;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLastname1() {
        return lastname1;
    }

    public void setLastname1(String lastname1) {
        this.lastname1 = lastname1;
    }

    public String getLastname2() {
        return lastname2;
    }

    public void setLastname2(String lastname2) {
        this.lastname2 = lastname2;
    }

    public String getCurp() {
        return curp;
    }

    public void setCurp(String curp) {
        this.curp = curp;
    }

    public int getUser_id() {
        return User_id;
    }

    public void setUser_id(int user_id) {
        User_id = user_id;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getDatex() {
        return datex;
    }

    public void setDatex(String datex) {
        this.datex = datex;
    }

    public String getSubname() {
        return subname;
    }

    public void setSubname(String subname) {
        this.subname = subname;
    }

    public String getNamex() {
        return namex;
    }

    public void setNamex(String namex) {
        this.namex = namex;
    }
}