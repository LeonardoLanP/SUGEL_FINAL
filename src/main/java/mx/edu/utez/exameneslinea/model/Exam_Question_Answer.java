package mx.edu.utez.exameneslinea.model;

public class Exam_Question_Answer extends Answer{
    private int id_exam_question;
    private int exam_id;
    private int ques_id;

    private int answer_id;
    private String open_Answer;

    public Exam_Question_Answer() {
    }

    public Exam_Question_Answer(int id_exam_question, int exam_id, int ques_id, int answer_id, String open_Answer) {
        this.id_exam_question = id_exam_question;
        this.exam_id = exam_id;
        this.ques_id = ques_id;
        this.answer_id = answer_id;
        this.open_Answer = open_Answer;
    }

    public Exam_Question_Answer(int id_answer, String answer, int id_exam_question, int exam_id, int ques_id, int answer_id, String open_Answer) {
        super(id_answer, answer);
        this.id_exam_question = id_exam_question;
        this.exam_id = exam_id;
        this.ques_id = ques_id;
        this.answer_id = answer_id;
        this.open_Answer = open_Answer;
    }

    public int getId_exam_question() {
        return id_exam_question;
    }

    public void setId_exam_question(int id_exam_question) {
        this.id_exam_question = id_exam_question;
    }

    public int getExam_id() {
        return exam_id;
    }

    public void setExam_id(int exam_id) {
        this.exam_id = exam_id;
    }

    public int getQues_id() {
        return ques_id;
    }

    public void setQues_id(int ques_id) {
        this.ques_id = ques_id;
    }

    public int getAnswer_id() {
        return answer_id;
    }

    public void setAnswer_id(int answer_id) {
        this.answer_id = answer_id;
    }

    public String getOpen_Answer() {
        return open_Answer;
    }

    public void setOpen_Answer(String open_Answer) {
        this.open_Answer = open_Answer;
    }
}
