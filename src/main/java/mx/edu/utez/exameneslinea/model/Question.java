package mx.edu.utez.exameneslinea.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Question extends Exam_Question_Answer{
    private int id_ques;
    private String question;
    private String type_question;

    private List<Answer> answers;

    private String nombreMateria;

    private String nombreExamen;

    private String nombreAlumno;


    public Question() {
    }

    public Question(int id_ques, String question, String type_question, List<Answer> answers) {
        this.id_ques = id_ques;
        this.question = question;
        this.type_question = type_question;
        this.answers = answers;
    }

    public int getId_ques() {
        return id_ques;
    }

    public Question(int id_exam_question, int exam_id, int ques_id, int answer_id, String open_Answer, int id_ques, String question, String type_question, List<Answer> answers) {
        super(id_exam_question, exam_id, ques_id, answer_id, open_Answer);
        this.id_ques = id_ques;
        this.question = question;
        this.type_question = type_question;
        this.answers = answers;
    }


    public Question(int id_answer, String answer, int id_exam_question, int exam_id, int ques_id, int answer_id, String open_Answer, int id_ques, String question, String type_question, List<Answer> answers) {
        super(id_answer, answer, id_exam_question, exam_id, ques_id, answer_id, open_Answer);
        this.id_ques = id_ques;
        this.question = question;
        this.type_question = type_question;
        this.answers = answers;
    }



    public void setId_ques(int id_ques) {
        this.id_ques = id_ques;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getType_question() {
        return type_question;
    }

    public void setType_question(String type_question) {
        this.type_question = type_question;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public String getNombreMateria() {
        return nombreMateria;
    }

    public void setNombreMateria(String nombreMateria) {
        this.nombreMateria = nombreMateria;
    }

    public String getNombreExamen() {
        return nombreExamen;
    }

    public void setNombreExamen(String nombreExamen) {
        this.nombreExamen = nombreExamen;
    }

    public String getNombreAlumno() {
        return nombreAlumno;
    }

    public void setNombreAlumno(String nombreAlumno) {
        this.nombreAlumno = nombreAlumno;
    }
}
