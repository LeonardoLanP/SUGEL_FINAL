package mx.edu.utez.exameneslinea.model;

public class Exam  extends User_sub{
    private int id_exam;
    private String code;
    private String gradeex;
    private String statusex;
    private String dateex;
    private int user_sub_id;

    private String namex;
    private String namexSub;
    private String type_exam;
    private int studenAnswer;
    public Exam() {
    }

    public Exam(int id_exam, String code, String grade1, String statusex, String dateex, int user_sub_id, String namex, String type_exam) {
        this.id_exam = id_exam;
        this.code = code;
        this.gradeex = grade1;
        this.statusex = statusex;
        this.dateex = dateex;
        this.user_sub_id = user_sub_id;
        this.namex = namex;
        this.type_exam = type_exam;
    }

    public Exam(int id_sub, int grade, String grouSub, String subname, int statusub, int id_user_sub, int user_id, int sub_id, int id_exam, String code, String grade1, String statusex, String dateex, int user_sub_id, String namex) {
        super(id_sub, grade, grouSub, subname, statusub, id_user_sub, user_id, sub_id);
        this.id_exam = id_exam;
        this.code = code;
        this.gradeex = grade1;
        this.statusex = statusex;
        this.dateex = dateex;
        this.user_sub_id = user_sub_id;
        this.namex = namex;
    }

    public int getId_exam() {
        return id_exam;
    }

    public void setId_exam(int id_exam) {
        this.id_exam = id_exam;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public void setGrade(String grade1) {
        this.gradeex = grade1;
    }

    public String getStatusex() {
        return statusex;
    }

    public void setStatusex(String statusex) {
        this.statusex = statusex;
    }

    public String getDateex() {
        return dateex;
    }

    public void setDateex(String dateex) {
        this.dateex = dateex;
    }

    public int getUser_sub_id() {
        return user_sub_id;
    }

    public void setUser_sub_id(int user_sub_id) {
        this.user_sub_id = user_sub_id;
    }

    public String getNamex() {
        return namex;
    }

    public void setNamex(String namex) {
        this.namex = namex;
    }

    public String getType_exam() {
        return type_exam;
    }

    public void setType_exam(String type_exam) {
        this.type_exam = type_exam;
    }

    public String getNamexSub() {
        return namexSub;
    }

    public void setNamexSub(String namexSub) {
        this.namexSub = namexSub;
    }

    public int getStudenAnswer() {
        return studenAnswer;
    }

    public void setStudenAnswer(int studenAnswer) {
        this.studenAnswer = studenAnswer;
    }

    public String getGradeex() {
        return gradeex;
    }

    public void setGradeex(String gradeex) {
        this.gradeex = gradeex;
    }
}