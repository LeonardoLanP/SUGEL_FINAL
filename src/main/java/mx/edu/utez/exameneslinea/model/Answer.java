package mx.edu.utez.exameneslinea.model;

public class Answer {
    private int id_answer;
    private String answer;

    public Answer() {
    }

    public Answer(int id_answer, String answer) {
        this.id_answer = id_answer;
        this.answer = answer;
    }
    @Override
    public String toString() {
        return "Answer [id_answer=" + id_answer + ", answer=" + answer + "]";
    }
    public int getId_answer() {
        return id_answer;
    }

    public void setId_answer(int id_answer) {
        this.id_answer = id_answer;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}
