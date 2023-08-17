package mx.edu.utez.exameneslinea.model.Daos;

import mx.edu.utez.exameneslinea.model.*;
import mx.edu.utez.exameneslinea.utils.MysqlConector;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ExamenDao implements DaoRepository{

    @Override
    public List findAll() {
        return null;
    }

    public List findAllExam(int idsub, int userid) {
        List<Exam> lista = new ArrayList<>();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.exam inner join user_sub on user_sub_id = id_user_sub" +
                            " inner join subject on sub_id = id_sub where id_sub=? and user_id = ?");
            stmt.setInt(1,idsub);
            stmt.setInt(2,userid);
            ResultSet res = stmt.executeQuery();
            while(res.next()){
                Exam exam = new Exam();
                exam.setCode(res.getString("code"));
                exam.setGradeex(res.getString("grade"));
                exam.setStatusex(res.getString("statusex"));
                exam.setId_exam(res.getInt("id_exam"));
                exam.setDateex(res.getString("dateex"));
                exam.setUser_sub_id(res.getInt("user_sub_id"));
                exam.setNamex(res.getString("namex"));
                PreparedStatement stmtAns =
                        con.prepareStatement("select count(code) as Answer from sugel.exam where code = ? and statusex = 2");
                stmtAns.setString(1,exam.getCode());
                ResultSet resAnswers = stmtAns.executeQuery();
                if (resAnswers.next()) {
                    exam.setStudenAnswer(resAnswers.getInt("Answer"));
                }else{
                    exam.setStudenAnswer(0);
                }
                lista.add(exam);
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    public List<Question> findAllExamStudent(String codigo, int idDocente) {
        List<Question> lista = new ArrayList<>();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement("select * from sugel.exam " +
                            "inner join sugel.exam_question_answer on id_exam = exam_id " +
                            "inner join sugel.question on ques_id = id_ques " +
                            "where code = ? and user_sub_id = ?");
            stmt.setString(1,codigo);
            stmt.setInt(2,idDocente);
            ResultSet res = stmt.executeQuery();
            while(res.next()){
                Question quest = new Question();
                quest.setId_exam_question(res.getInt("id_exam_question"));
                quest.setExam_id(res.getInt("exam_id"));
                quest.setQues_id(res.getInt("ques_id"));
                quest.setAnswer_id(res.getInt("answer_id"));
                quest.setOpen_Answer(res.getString("open_Answer"));
                if(quest.getOpen_Answer().equals("Abierta")){
                    quest.setOpen_Answer(null);
                }
                quest.setQuestion(res.getString("question"));
                lista.add(quest);
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    public List<Question> findAllExamStudentAbierta(String codigo, int idDocente) {
        List<Question> lista = new ArrayList<>();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement("select * from sugel.exam " +
                    "inner join sugel.exam_question_answer on id_exam = exam_id " +
                    "inner join sugel.question on ques_id = id_ques " +
                    "where code = ? and user_sub_id = ?");
            stmt.setString(1,codigo);
            stmt.setInt(2,idDocente);
            ResultSet res = stmt.executeQuery();
            while(res.next()){
                Question quest = new Question();
                quest.setId_exam_question(res.getInt("id_exam_question"));
                quest.setExam_id(res.getInt("exam_id"));
                quest.setQues_id(res.getInt("ques_id"));
                quest.setAnswer_id(res.getInt("answer_id"));
                quest.setOpen_Answer(res.getString("open_Answer"));
                quest.setQuestion(res.getString("question"));
                quest.setType_question(res.getString("type_question"));
                lista.add(quest);
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }
    public List<Question> findQuestion(int EQA) {
        List<Question> lista = new ArrayList<>();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.exam_question_answer inner join sugel.question on ques_id = id_ques" +
                            " inner join sugel.answer on id_answer = answer_id" +
                            " where exam_id = ?");
            stmt.setInt(1,EQA);
            ResultSet res = stmt.executeQuery();
            while(res.next()) {
                Question quest = new Question();
                quest.setId_exam_question(res.getInt("id_exam_question"));
                quest.setExam_id(res.getInt("exam_id"));
                quest.setQues_id(res.getInt("ques_id"));
                quest.setAnswer_id(res.getInt("answer_id"));
                quest.setOpen_Answer(res.getString("open_Answer"));
                quest.setQuestion(res.getString("question"));
                quest.setId_answer(res.getInt("id_answer"));
                if (quest.getQues_id() != 1) {
                    lista.add(0, quest);
                } else {
                    lista.add(quest);
                }
                }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    public List<Question> finAllQuestionMultiple(int examId) {
        List<Question> lista = new ArrayList<>();
        Question question = new Question();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmtQuestion =
                    con.prepareStatement("SELECT * FROM sugel.exam_question_answer " +
                            "INNER JOIN sugel.question ON ques_id = id_ques " +
                            "WHERE exam_id = ? AND open_Answer = 'Multiple' AND ques_id >= 2");
            stmtQuestion.setInt(1, examId);
            ResultSet res = stmtQuestion.executeQuery();

            while (res.next()) {
                question = new Question();
                question.setQues_id(res.getInt("ques_id"));
                question.setQuestion(res.getString("question"));
                question.setOpen_Answer(res.getString("open_Answer"));
                question.setAnswer_id(res.getInt("answer_id"));
                if(question.getQues_id() == 2){
                    question.setAnswer(null);
                    lista.add(question);
                }else{
                    PreparedStatement stmtAnswers =
                            con.prepareStatement("SELECT * FROM sugel.exam_question_answer " +
                                    "INNER JOIN sugel.answer ON answer_id = id_answer " +
                                    "WHERE exam_id = ? AND ques_id = ? AND open_Answer = 'Respuesta'");
                    stmtAnswers.setInt(1, examId);
                    stmtAnswers.setInt(2, question.getQues_id());
                    ResultSet resAnswers = stmtAnswers.executeQuery();
                    List<Answer> answers = new ArrayList<>();
                    while (resAnswers.next()) {
                        Answer answer = new Answer();
                        answer.setId_answer(resAnswers.getInt("id_answer"));
                        answer.setAnswer(resAnswers.getString("answer"));
                        answers.add(answer);
                    }
                    question.setAnswers(answers);
                    lista.add(question);
                }

            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }


    public List<Question> finAllQuestionMultipleEstudiante(int examId) {
        List<Question> lista = new ArrayList<>();
        Question question = new Question();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmtQuestion =
                    con.prepareStatement("SELECT * FROM sugel.exam_question_answer " +
                            "INNER JOIN sugel.question ON ques_id = id_ques " +
                            "WHERE exam_id = ? AND open_Answer = 'Multiple' AND ques_id >= 2");
            stmtQuestion.setInt(1, examId);
            ResultSet res = stmtQuestion.executeQuery();

            while (res.next()) {
                question = new Question();
                question.setQues_id(res.getInt("ques_id"));
                question.setQuestion(res.getString("question"));
                question.setOpen_Answer(res.getString("open_Answer"));
                question.setAnswer_id(res.getInt("answer_id"));
                question.setId_exam_question(res.getInt("id_exam_question"));
                if(question.getQues_id() == 2){
                    lista.add(question);
                }else{
                    PreparedStatement stmtAnswers =
                            con.prepareStatement("SELECT * FROM sugel.exam_question_answer " +
                                    "INNER JOIN sugel.answer ON answer_id = id_answer " +
                                    "WHERE ques_id = ? AND open_Answer = 'Respuesta'");
                    stmtAnswers.setInt(1, question.getQues_id());
                    ResultSet resAnswers = stmtAnswers.executeQuery();
                    List<Answer> answers = new ArrayList<>();
                    while (resAnswers.next()) {
                        Answer answer = new Answer();
                        answer.setId_answer(resAnswers.getInt("id_answer"));
                        answer.setAnswer(resAnswers.getString("answer"));
                        answers.add(answer);
                    }
                    question.setAnswers(answers);
                    lista.add(question);
                }

            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    public List<Subject> findAllMa(int id_user) {
        List<Subject> lista = new ArrayList<>();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select * from subject inner join user_sub on id_sub = sub_id where user_id = ?");
            stmt.setInt(1,id_user);
            ResultSet res = stmt.executeQuery();
            while(res.next()){
                Subject m = new Subject();
                m.setId_sub(res.getInt("id_sub"));
                m.setGrade(res.getInt("grade"));
                m.setGrouSub(res.getString("groupSub"));
                m.setSubname(res.getString("subname"));
                m.setStatusub(res.getInt("statusub"));
                lista.add(m);
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    public List<Question> findAllAnswerStudents(int id_user, String code) {
        List<Question> lista = new ArrayList<>();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select open_Answer from exam_question_answer " +
                            "inner join sugel.exam on exam_id = id_exam " +
                            "where code = ?");
            stmt.setString(1,code);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                Question ques = new Question();
                ques.setOpen_Answer(res.getString("open_Answer"));
                if(ques.getOpen_Answer().equals("Abierta")){
                    PreparedStatement stmtOpen =
                            con.prepareStatement("select id_exam_question,exam_id,ques_id,question,open_Answer,name,lastname1,lastname2,person.User_id from sugel.exam_question_answer " +
                                    "inner join sugel.question on id_ques = ques_id " +
                                    "inner join sugel.exam on exam_id = id_exam " +
                                    "inner join sugel.user_sub on id_user_sub = user_sub_id " +
                                    "inner join sugel.user on user_sub.user_id = user.ID_user " +
                                    "inner join sugel.person on person.User_id = user.ID_user " +
                                    "where user.ID_user = ?  and exam.code = ?");
                    stmtOpen.setInt(1,id_user);
                    stmtOpen.setString(2,code);
                    ResultSet resopen = stmtOpen.executeQuery();
                    while (resopen.next()) {
                        Question question = new Question();
                        question.setNombreAlumno(resopen.getString("name")+ " " +resopen.getString("lastname1") + " " + (resopen.getString("lastname2") == null || resopen.getString("lastname2").isEmpty() ? "" : resopen.getString("lastname2")));
                        question.setId_exam_question(resopen.getInt("id_exam_question"));
                        question.setExam_id(resopen.getInt("exam_id"));
                        question.setQues_id(resopen.getInt("User_id"));
                        question.setQuestion(resopen.getString("question"));
                        question.setAnswer(resopen.getString("open_Answer"));
                        lista.add(question);
                    }
                }else if(ques.getOpen_Answer().equals("Multiple")){
                    PreparedStatement stmtClose =
                            con.prepareStatement("select id_exam_question,exam_id,ques_id,answer_id,question,answer,name,lastname1,lastname2,person.User_id from sugel.exam_question_answer " +
                                    "inner join sugel.question on id_ques = ques_id " +
                                    "inner join sugel.answer on answer_id = id_answer " +
                                    "inner join sugel.exam on exam_id = id_exam " +
                                    "inner join sugel.user_sub on id_user_sub = user_sub_id " +
                                    "inner join sugel.user on user_sub.user_id = user.ID_user " +
                                    "inner join sugel.person on person.User_id = user.ID_user " +
                                    "where user.ID_user = ?  and exam.code = ?");
                    stmtClose.setInt(1,id_user);
                    stmtClose.setString(2,code);
                    ResultSet resclose = stmtClose.executeQuery();
                    while (resclose.next()) {
                       Question question = new Question();
                        question.setNombreAlumno(resclose.getString("name")+ " " +resclose.getString("lastname1") + " " + (resclose.getString("lastname2") == null || resclose.getString("lastname2").isEmpty() ? "" : resclose.getString("lastname2")));
                        question.setId_exam_question(resclose.getInt("id_exam_question"));
                        question.setExam_id(resclose.getInt("exam_id"));
                        question.setQues_id(resclose.getInt("User_id"));
                        question.setAnswer_id(resclose.getInt("answer_id"));
                        question.setQuestion(resclose.getString("question"));
                        question.setAnswer(resclose.getString("answer"));
                        lista.add(question);
                    }
                }
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    public List<Person> findAllStudents(int id_exam) {
        List<Person> lista = new ArrayList<>();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.exam  where id_exam = ?");
            stmt.setInt(1,id_exam);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                Exam ex = new Exam();
                ex.setCode(res.getString("code"));
                PreparedStatement stmtUser =
                        con.prepareStatement("select * from sugel.person " +
                                "inner join sugel.user on ID_user = person.User_id " +
                                "inner join sugel.user_sub on user_sub.user_id = ID_user " +
                                "inner join sugel.exam on id_user_sub = user_sub_id " +
                                "where code = ? and statusex = 2 order by lastname1 ASC");
                stmtUser.setString(1,ex.getCode());
                ResultSet resuser = stmtUser.executeQuery();
                while(resuser.next()) {
                    Person per = new Person();
                    per.setUser_id(resuser.getInt("User_id"));
                    per.setName(resuser.getString("name"));
                    per.setLastname1(resuser.getString("lastname1"));
                    per.setLastname2(resuser.getString("lastname2"));
                    if(per.getLastname2() == null || per.getLastname2().isEmpty()){
                        per.setLastname2("");
                    }
                    per.setGrade(resuser.getString("grade"));
                    lista.add(per);
                }
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    @Override
    public Object findOne(int id) {
        return null;
    }


    public Object findMateria(int grade,String group, String subname) {
        Subject mater = new Subject();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.subject where grade = ? AND groupSub = ? AND subname = ? order by id_sub DESC");
            stmt.setInt(1,grade);
            stmt.setString(2,group);
            stmt.setString(3,subname);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                mater.setId_sub(res.getInt("id_sub"));
                mater.setGrade(res.getInt("grade"));
                mater.setGrouSub(res.getString("groupSub"));
                mater.setSubname(res.getString("subname"));
                mater.setStatusub(res.getInt("statusub"));
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return mater;
    }

    public boolean findsubDocente(int grade,String group, String subname) {
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.subject where grade = ? AND groupSub = ? AND subname = ?");
            stmt.setInt(1,grade);
            stmt.setString(2,group);
            stmt.setString(3,subname);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                return true;
            }
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    public Object findOneByCode(String codigo) {
        Exam exm = new Exam();
        Connection con = new MysqlConector().connect();
        try {

            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.exam " +
                            "inner join sugel.user_sub on user_sub_id = id_user_sub " +
                            "inner join sugel.subject on id_sub = sub_id " +
                            "where exam.code = ?");
            stmt.setString(1,codigo);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                exm.setId_exam(res.getInt("id_exam"));
                exm.setCode(res.getString("code"));
                exm.setGrade(res.getString("grade"));
                exm.setStatusex(res.getString("statusex"));
                exm.setDateex(res.getString("dateex"));
                exm.setUser_sub_id(res.getInt("user_sub_id"));
                exm.setNamex(res.getString("namex"));
                exm.setNamexSub(res.getString("subname"));

                PreparedStatement stmtT =
                        con.prepareStatement("select * from sugel.exam_question_answer " +
                                "inner join sugel.exam on id_exam = exam_id " +
                                " where exam.code = ?");
                stmtT.setString(1,codigo);
                ResultSet rest = stmtT.executeQuery();
                if(rest.next()){
                    exm.setType_exam(rest.getString("open_Answer"));
                }

            }else {
                exm.setCode("Invalido");
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return exm;
    }

    public Object findOneQuestionOne(int idexam) {
        Exam_Question_Answer exm = new Exam_Question_Answer();
        Connection con = new MysqlConector().connect();
        try {

            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.exam_question_answer inner join sugel.exam on " +
                            "id_exam = exam_id " +
                            "where exam_id = ?");
            stmt.setInt(1,idexam);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                exm.setAnswer_id(res.getInt("answer_id"));
                exm.setOpen_Answer(res.getString("open_Answer"));
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return exm;
    }

    public Object findexameninconcluso(int iduser) {
        Exam exm = new Exam();
        Connection con = new MysqlConector().connect();
        try {

            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.exam " +
                            "inner join sugel.user_sub on id_user_sub = id_user_sub " +
                            "inner join sugel.user on user_id = ID_user " +
                            "where ID_user = ? and statusex = ? order by id_exam DESC ");
            stmt.setInt(1,iduser);
            stmt.setInt(2,1);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                exm.setCode(res.getString("code"));
                exm.setStatusex(res.getString("statusex"));
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return exm;
    }

    public Object findNamex(int idexam) {
        String name = "";
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.exam where id_exam = ?");
            stmt.setInt(1,idexam);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
            name = res.getString("namex");
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return name;
    }

    public Object findOneUserSub(int user, int subject) {
        User_sub us = new User_sub();
        Connection con = new MysqlConector().connect();
        try {

            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.user_sub where user_id = ? AND sub_id = ?");
            stmt.setInt(1,user);
            stmt.setInt(2,subject);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                us.setId_user_sub(res.getInt("id_user_sub"));
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return us;
    }

    public boolean findOneUserSubRegitro(int user, int subject) {
        User_sub us = new User_sub();
        Connection con = new MysqlConector().connect();
        try {

            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.user_sub where user_id = ? AND sub_id = ?");
            stmt.setInt(1,user);
            stmt.setInt(2,subject);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                return false;
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return true;
    }
    public Boolean finOpenExam(String code, int Idperson) {
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.exam " +
                            "inner join sugel.user_sub on user_sub_id = id_user_sub " +
                            "inner join sugel.user on User_id = ID_user " +
                            "inner join sugel.exam_question_answer on id_exam = exam_id " +
                            "inner join sugel.person on user.ID_user = person.User_id " +
                            "where exam.code = ? and person.ID_person = ?");
            stmt.setString(1,code);
            stmt.setInt(2,Idperson);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                return true;
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }


    public Object finOpenExamID(String code, int Idperson) {
        Exam ex = new Exam();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.exam " +
                            "inner join sugel.user_sub on user_sub_id = id_user_sub " +
                            "inner join sugel.user on User_id = ID_user " +
                            "inner join sugel.person on user.ID_user = person.User_id " +
                            "where exam.code = ? and person.ID_person = ?");
            stmt.setString(1,code);
            stmt.setInt(2,Idperson);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                ex.setId_exam(res.getInt("id_exam"));
                ex.setStatusex(res.getString("statusex"));
                ex.setUser_sub_id(res.getInt("user_sub_id"));
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ex;
    }


    public Object findEQA(int idExm, int quess) {
        Question QUES = new Question();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.exam_question_answer" +
                            " where exam_id = ? AND ques_id = ?");
            stmt.setInt(1,idExm);
            stmt.setInt(2,quess);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                QUES.setId_exam_question(res.getInt("id_exam_question"));
                QUES.setAnswer_id(res.getInt("answer_id"));
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return QUES;
    }

    public Object findSubject(String codigo) {
        Exam ex = new Exam();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt =
                    con.prepareStatement("select * from sugel.subject " +
                            "inner join sugel.user_sub on id_sub = sub_id " +
                            "inner join sugel.exam on user_sub_id = id_user_sub "+
                            "where exam.code = ?");
            stmt.setString(1,codigo);
            ResultSet res = stmt.executeQuery();
            if(res.next()){
                ex.setSub_id(res.getInt("sub_id"));
                ex.setNamex(res.getString("namex"));
            }
            res.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ex;
    }
    @Override
    public boolean update(int id, Object object) {
        return false;
    }

    public boolean updateEQA(int quesid, int idExm, int idEQ) {
        boolean estado = false;
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "update sugel.exam_question_answer set ques_id = ? " +
                            "where exam_id = ? AND id_exam_question = ?");
            stmt.setInt(1,quesid);
            stmt.setInt(2,idExm);
            stmt.setInt(3,idEQ);
            estado = stmt.executeUpdate() > 0 ? true:false;
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return estado;
    }

    public boolean updateEQAnswer(String answer, int idQues, int idEQ) {
        boolean estado = false;
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "update sugel.exam_question_answer set open_Answer = ? " +
                            "where ques_id = ? AND id_exam_question = ?");
            stmt.setString(1,answer);
            stmt.setInt(2,idQues);
            stmt.setInt(3,idEQ);
            estado = stmt.executeUpdate() > 0 ? true:false;
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return estado;
    }


    public boolean updateQues(int quesid, String quess) {
        boolean estado = false;
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "update sugel.question set question= ?" +
                            "where id_ques = ?"
            );
            stmt.setString(1,quess);
            stmt.setInt(2,quesid);
            estado = stmt.executeUpdate() > 0 ? true:false;
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return estado;
    }
    public boolean updateAnswer(int idanswer, String answer) {
        boolean estado = false;
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "update sugel.answer set answer= ? " +
                            "where id_answer = ?"
            );
            stmt.setString(1,answer);
            stmt.setInt(2,idanswer);
            estado = stmt.executeUpdate() > 0 ? true:false;
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return estado;
    }

    public boolean updateCode(int idUsSub, String code, int idExam) {
        boolean estado = false;
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "update sugel.exam set code= ? " +
                            "where user_sub_id = ? AND id_exam = ?"
            );
            stmt.setString(1,code);
            stmt.setInt(2,idUsSub);
            stmt.setInt(3,idExam);
            estado = stmt.executeUpdate() > 0 ? true:false;
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return estado;
    }

    public boolean updateCloseAnswer(int idExamQues,int idAnswer) {
        boolean estado = false;
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "update sugel.exam_question_answer set answer_id = ? " +
                            "where id_exam_question = ? "
            );
            stmt.setInt(1,idAnswer);
            stmt.setInt(2,idExamQues);
            estado = stmt.executeUpdate() > 0 ? true:false;
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return estado;
    }

    public boolean updateStatusEstudent(int idExam) {
        boolean estado = false;
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "update sugel.exam set statusex = ? , grade = ? " +
                            "where id_exam = ? "
            );
            stmt.setInt(1,2);
            stmt.setInt(2,11);
            stmt.setInt(3,idExam);
            estado = stmt.executeUpdate() > 0 ? true:false;
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return estado;
    }

    public boolean updateStatusExmanDocente(int idExam, int status) {
        boolean estado = false;
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "update sugel.exam set statusex = ?, grade = ? " +
                            "where id_exam = ? "
            );
            stmt.setInt(1,status);
            stmt.setInt(2,10);
            stmt.setInt(3,idExam);
            estado = stmt.executeUpdate() > 0 ? true:false;
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return estado;
    }

    public boolean updatestatussub(int idsub, int status, int iduser) {
        boolean estado = false;
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "update sugel.subject set statusub = ? " +
                            "where id_sub = ? "
            );
            stmt.setInt(1,status);
            stmt.setInt(2,idsub);
            estado = stmt.executeUpdate() > 0 ? true:false;
            PreparedStatement stmtexm = con.prepareStatement(
                    "select * from sugel.exam " +
                            "inner join sugel.user_sub on user_sub.id_user_sub = exam.user_sub_id " +
                            "inner join sugel.subject on user_sub.sub_id = subject.id_sub " +
                            "inner join sugel.user on user.ID_user = user_sub.user_id " +
                            "where id_sub = ? and user.ID_user = ?");
            stmtexm.setInt(1,idsub);
            stmtexm.setInt(2,iduser);
            ResultSet resxm = stmtexm.executeQuery();
            while (resxm.next()) {
                Exam ex = new Exam();
                ex.setId_exam(resxm.getInt("id_exam"));

                PreparedStatement stmtex = con.prepareStatement(
                        "SELECT * FROM sugel.exam " +
                                "WHERE id_exam = ?");

                stmtex.setInt(1, ex.getId_exam());
                ResultSet resex = stmtex.executeQuery();
                while (resex.next()) {
                    ex.setGradeex(resex.getString("grade"));
                    if (ex.getGradeex().equals("AU")) {
                        PreparedStatement stmtgrade = con.prepareStatement(
                                "UPDATE sugel.exam SET grade = 10, statusex = 0 " +
                                        "WHERE id_exam = ?");

                        stmtgrade.setInt(1, ex.getId_exam());
                        estado = stmtgrade.executeUpdate() > 0 ? true : false;
                    } else {
                        PreparedStatement stmtgrstatus = con.prepareStatement(
                                "UPDATE sugel.exam SET statusex = 0 " +
                                        "WHERE id_exam = ?");
                        stmtgrstatus.setInt(1, ex.getId_exam());
                        estado = stmtgrstatus.executeUpdate() > 0 ? true : false;
                    }
                }
            }

            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return estado;
    }


    public boolean updateCalificacion(int idExam, double grade) {
        boolean estado = false;
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "update sugel.exam set grade = ? " +
                            "where id_exam = ? "
            );
            stmt.setDouble(1,grade);
            stmt.setInt(2,idExam);
            estado = stmt.executeUpdate() > 0 ? true:false;
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return estado;
    }

    @Override
    public boolean delete(int id) {
        return false;
    }


    public boolean insertMateria(Subject mater) {
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement("insert into sugel.subject(grade,groupSub,subname,statusub) values(?,?,?,'1')");
            stmt.setInt(1, mater.getGrade());
            stmt.setString(2,mater.getGrouSub());
            stmt.setString(3,mater.getSubname());

            if(stmt.executeUpdate() > 0){
                return true;
            }
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    public boolean insertMateriaUsuario(int id_U, int id_M) {
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement("insert into sugel.user_sub(user_id,sub_id) values(?,?)");
            stmt.setInt(1, id_U);
            stmt.setInt(2,id_M);
            if(stmt.executeUpdate() > 0){
                return true;
            }
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    public int insertExam(int statusex, int user_sub_id, String namex) {
        int id = 0;
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement("insert into sugel.exam(statusex,grade,user_sub_id,namex) " +
                    "values(?,?,?,?)");
            stmt.setInt(1, statusex);
            stmt.setString(2,"SC");
            stmt.setInt(3, user_sub_id);
            stmt.setString(4,namex);
            if(stmt.executeUpdate() > 0){
                PreparedStatement stmtT = con.prepareStatement("select * from sugel.exam where user_sub_id = ? " +
                        "and namex = ? order by id_exam DESC");
                stmtT.setInt(1, user_sub_id);
                stmtT.setString(2,namex);
                ResultSet res = stmtT.executeQuery();
                if(res.next()){
                    id = res.getInt("id_exam");
                }
                return id;
            }
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return id;
    }

    public boolean insertEQA(List<Exam_Question_Answer> examQuestionAnswers) {
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "insert into sugel.exam_question_answer(exam_id,ques_id,answer_id,open_Answer) " +
                            "values(?,?,?,?)");

            for (Exam_Question_Answer eqa : examQuestionAnswers) {
                stmt.setInt(1, eqa.getExam_id());
                stmt.setInt(2, eqa.getQues_id());
                stmt.setInt(3, eqa.getAnswer_id());
                stmt.setString(4, eqa.getOpen_Answer());
                stmt.addBatch();
            }

            int[] results = stmt.executeBatch();
            for (int result : results) {
                if (result <= 0) {
                    return false;
                }
            }
            con.close();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Object insertQUES(String question, String typeQues) {
        Question ques = new Question();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement("call InsertQuestion (?,?)");
            stmt.setString(1,question);
            stmt.setString(2,typeQues);
            if(stmt.executeUpdate() > 0){
                PreparedStatement stmtQ = con.prepareStatement("select * from sugel.question where question = ? and type_question = ? ORDER BY id_ques DESC");
                stmtQ.setString(1,question);
                stmtQ.setString(2,typeQues);
                ResultSet res = stmtQ.executeQuery();
                if(res.next()){
                    ques.setQues_id(res.getInt("id_ques"));
                }
            }
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ques;
    }

    public Object insertAnswer(String answer) {
        Answer ans = new Answer();
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement("call InsertAnswer (?)");
            stmt.setString(1,answer);
            if(stmt.executeUpdate() > 0){
                PreparedStatement stmtQ = con.prepareStatement("select * from sugel.answer where answer = ?  ORDER BY id_answer DESC");
                stmtQ.setString(1,answer);
                ResultSet res = stmtQ.executeQuery();
                if(res.next()){
                    ans.setId_answer(res.getInt("id_answer"));
                }
            }
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ans;
    }

    public boolean insertEQAAnswer(int examid, int quesid, int answerid) {
        Connection con = new MysqlConector().connect();
        try {
            PreparedStatement stmt = con.prepareStatement(
                    "insert into sugel.exam_question_answer(exam_id,ques_id,answer_id,open_Answer) " +
                            "values(?,?,?,?)");
                stmt.setInt(1,examid);
                stmt.setInt(2, quesid);
                stmt.setInt(3, answerid);
                stmt.setString(4, "Respuesta");
            if(stmt.executeUpdate() > 0){
                return true;
            }
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    return false;
    }
}
