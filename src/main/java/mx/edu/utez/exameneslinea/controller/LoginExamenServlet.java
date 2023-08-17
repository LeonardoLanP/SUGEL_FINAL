package mx.edu.utez.exameneslinea.controller;

import mx.edu.utez.exameneslinea.model.*;
import mx.edu.utez.exameneslinea.model.Daos.ExamenDao;
import mx.edu.utez.exameneslinea.model.Daos.UsuarioDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet(name = "LoginExamenServlet", value = "/ques_reload")
public class LoginExamenServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String codigo = req.getParameter("codigo");
        int id = (int) req.getSession().getAttribute("idEstudiantePerson");
        ExamenDao dao = new ExamenDao();
        UsuarioDao daoUs = new UsuarioDao();

        Person per = (Person) daoUs.findOne(id);
        Exam exm = (Exam) dao.findOneByCode(codigo);
        req.getSession().setAttribute("codex",codigo);

        if (exm.getCode().equals(codigo)) {
            if (exm.getStatusex().equals("1")) {
                if(!(dao.finOpenExam(codigo,id)) && exm.getType_exam().equals("Abierta")){

                    Exam ex = (Exam) dao.findSubject(codigo);
                    if(dao.findOneUserSubRegitro(per.getUser_id(),ex.getSub_id())){
                        dao.insertMateriaUsuario(per.getUser_id(),ex.getSub_id());
                    }
                    User_sub uS = (User_sub) dao.findOneUserSub(per.getUser_id(), ex.getSub_id());
                    int ExamInseId = dao.insertExam(1, uS.getId_user_sub(), ex.getNamex());
                    dao.updateCode(uS.getId_user_sub(),codigo,ExamInseId);

                    List<Question> questionList = dao.findAllExamStudent(codigo,exm.getUser_sub_id());
                    int cantidadPreguntasSeleccionar = questionList.size() / 2;
                    Set<Question> preguntasSeleccionadas = new HashSet<>();

                    List<Exam_Question_Answer> examQuestionAnswers = new ArrayList<>();
                    while (preguntasSeleccionadas.size() < cantidadPreguntasSeleccionar) {
                        int indiceAleatorio = (int) (Math.random() * questionList.size());
                        Question preguntaAleatoria = questionList.get(indiceAleatorio);
                        preguntasSeleccionadas.add(preguntaAleatoria);
                    }

                    Exam Newexam = (Exam) dao.finOpenExamID(codigo,id);
                    List<Question> preguntasSeleccionadasList = new ArrayList<>(preguntasSeleccionadas);
                    for (Question pregunta : preguntasSeleccionadasList) {
                        examQuestionAnswers.add(new Exam_Question_Answer(0, Newexam.getId_exam(), pregunta.getQues_id(),1,null));
                    }
                    dao.insertEQA(examQuestionAnswers);
                    List<Question> finalques;
                    finalques = dao.findAllExamStudentAbierta(codigo, uS.getId_user_sub());
                    req.getSession().setAttribute("subject", exm);
                    req.getSession().setAttribute("examenid", Newexam.getId_exam());
                    req.getSession().setAttribute("quests", finalques);
                    resp.sendRedirect(req.getContextPath() + "/Estudiante/examen.jsp");

                }else if(!(dao.finOpenExam(codigo,id)) && exm.getType_exam().equals("Multiple")){
                    Exam ex = (Exam) dao.findSubject(codigo);
                    if(dao.findOneUserSubRegitro(per.getUser_id(),ex.getSub_id())){
                        dao.insertMateriaUsuario(per.getUser_id(),ex.getSub_id());
                    }
                    User_sub uS = (User_sub) dao.findOneUserSub(per.getUser_id(), ex.getSub_id());
                    int ExamInseId = dao.insertExam(1, uS.getId_user_sub(), ex.getNamex());
                    dao.updateCode(uS.getId_user_sub(),codigo,ExamInseId);

                    List<Question> questionList = dao.finAllQuestionMultiple(exm.getId_exam());
                    int cantidadPreguntasSeleccionar = questionList.size() / 2;
                    Set<Question> preguntasSeleccionadas = new HashSet<>();
                    List<Exam_Question_Answer> examQuestionAnswers = new ArrayList<>();

                    while (preguntasSeleccionadas.size() < cantidadPreguntasSeleccionar) {
                        int indiceAleatorio = (int) (Math.random() * questionList.size());
                        Question preguntaAleatoria = questionList.get(indiceAleatorio);
                        preguntasSeleccionadas.add(preguntaAleatoria);
                    }
                    Exam Newexam = (Exam) dao.finOpenExamID(codigo,per.getId_person());
                    List<Question> preguntasSeleccionadasList = new ArrayList<>(preguntasSeleccionadas);
                    for (Question pregunta : preguntasSeleccionadasList) {
                        examQuestionAnswers.add(new Exam_Question_Answer(0, Newexam.getId_exam(), pregunta.getQues_id(),2,"Multiple"));
                    }
                    dao.insertEQA(examQuestionAnswers);
                    List<Question> finalques;
                    finalques = dao.finAllQuestionMultipleEstudiante(ExamInseId);
                    req.getSession().setAttribute("subject", exm);
                    req.getSession().setAttribute("examenid", Newexam.getId_exam());
                    req.getSession().setAttribute("quests", finalques);
                    resp.sendRedirect(req.getContextPath() +"/Estudiante/examen.jsp");
                }else{
                    Exam exam = (Exam) dao.finOpenExamID(codigo, id);
                    if(exam.getStatusex().equals("1")) {
                        Exam_Question_Answer EQA = (Exam_Question_Answer) dao.findOneQuestionOne(exam.getId_exam());
                        List<Question> questionList;
                        if (EQA.getAnswer_id() != 1 && EQA.getOpen_Answer().equals("Multiple")) {
                            questionList = dao.finAllQuestionMultipleEstudiante(exam.getId_exam());
                        } else {
                            questionList = dao.findAllExamStudentAbierta(codigo, exam.getUser_sub_id());
                        }
                        req.getSession().setAttribute("subject", exm);
                        req.getSession().setAttribute("examenid", exam.getId_exam());
                        req.getSession().setAttribute("quests", questionList);
                        resp.sendRedirect(req.getContextPath() + "/Estudiante/examen.jsp");
                    }else if(exam.getStatusex().equals("2")){
                        req.getSession().setAttribute("mensaje","completado");
                        resp.sendRedirect(req.getContextPath() +"/Estudiante/acceso.jsp");
                    }else{
                        resp.sendRedirect(req.getContextPath() +"paginaDeError.jsp");
                    }
                }
            } else {
                req.getSession().setAttribute("mensaje","desactivado");
                resp.sendRedirect(req.getContextPath() +"/Estudiante/acceso.jsp");
            }
        } else {
            req.getSession().setAttribute("mensaje","noencontrado");
            resp.sendRedirect(req.getContextPath() + "/Estudiante/acceso.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String codigo = req.getParameter("codigo");
        int id = (int) req.getSession().getAttribute("idEstudiantePerson");
        ExamenDao dao = new ExamenDao();
        UsuarioDao daoUs = new UsuarioDao();

        Person per = (Person) daoUs.findOne(id);
        Exam exm = (Exam) dao.findOneByCode(codigo);
        req.getSession().setAttribute("codex",codigo);
        if (exm.getCode().equals(codigo)) {
            if (exm.getStatusex().equals("1")) {
                if(!(dao.finOpenExam(codigo,id)) && exm.getType_exam().equals("Abierta")){

                    Exam ex = (Exam) dao.findSubject(codigo);
                    if(dao.findOneUserSubRegitro(per.getUser_id(),ex.getSub_id())){
                        dao.insertMateriaUsuario(per.getUser_id(),ex.getSub_id());
                    }
                    User_sub uS = (User_sub) dao.findOneUserSub(per.getUser_id(), ex.getSub_id());
                    int ExamInseId = dao.insertExam(1, uS.getId_user_sub(), ex.getNamex());
                    dao.updateCode(uS.getId_user_sub(),codigo,ExamInseId);

                    List<Question> questionList = dao.findAllExamStudent(codigo,exm.getUser_sub_id());
                    int cantidadPreguntasSeleccionar = questionList.size() / 2;
                    Set<Question> preguntasSeleccionadas = new HashSet<>();

                    List<Exam_Question_Answer> examQuestionAnswers = new ArrayList<>();
                    while (preguntasSeleccionadas.size() < cantidadPreguntasSeleccionar) {
                        int indiceAleatorio = (int) (Math.random() * questionList.size());
                        Question preguntaAleatoria = questionList.get(indiceAleatorio);
                        preguntasSeleccionadas.add(preguntaAleatoria);
                    }

                    Exam Newexam = (Exam) dao.finOpenExamID(codigo,id);
                    List<Question> preguntasSeleccionadasList = new ArrayList<>(preguntasSeleccionadas);
                    for (Question pregunta : preguntasSeleccionadasList) {
                        examQuestionAnswers.add(new Exam_Question_Answer(0, Newexam.getId_exam(), pregunta.getQues_id(),1,null));
                    }
                    dao.insertEQA(examQuestionAnswers);
                    List<Question> finalques;
                    finalques = dao.findAllExamStudentAbierta(codigo, uS.getId_user_sub());
                    req.getSession().setAttribute("subject", exm);
                    req.getSession().setAttribute("examenid", Newexam.getId_exam());
                    req.getSession().setAttribute("quests", finalques);
                    resp.sendRedirect(req.getContextPath() + "/Estudiante/examen.jsp");

                }else if(!(dao.finOpenExam(codigo,id)) && exm.getType_exam().equals("Multiple")){
                    Exam ex = (Exam) dao.findSubject(codigo);
                    if(dao.findOneUserSubRegitro(per.getUser_id(),ex.getSub_id())){
                        dao.insertMateriaUsuario(per.getUser_id(),ex.getSub_id());
                    }
                    User_sub uS = (User_sub) dao.findOneUserSub(per.getUser_id(), ex.getSub_id());
                    int ExamInseId = dao.insertExam(1, uS.getId_user_sub(), ex.getNamex());
                    dao.updateCode(uS.getId_user_sub(),codigo,ExamInseId);

                    List<Question> questionList = dao.finAllQuestionMultiple(exm.getId_exam());
                    int cantidadPreguntasSeleccionar = questionList.size() / 2;
                    Set<Question> preguntasSeleccionadas = new HashSet<>();
                    List<Exam_Question_Answer> examQuestionAnswers = new ArrayList<>();

                    while (preguntasSeleccionadas.size() < cantidadPreguntasSeleccionar) {
                        int indiceAleatorio = (int) (Math.random() * questionList.size());
                        Question preguntaAleatoria = questionList.get(indiceAleatorio);
                        preguntasSeleccionadas.add(preguntaAleatoria);
                    }
                    Exam Newexam = (Exam) dao.finOpenExamID(codigo,per.getId_person());
                    List<Question> preguntasSeleccionadasList = new ArrayList<>(preguntasSeleccionadas);
                    for (Question pregunta : preguntasSeleccionadasList) {
                        examQuestionAnswers.add(new Exam_Question_Answer(0, Newexam.getId_exam(), pregunta.getQues_id(),2,"Multiple"));
                    }
                    dao.insertEQA(examQuestionAnswers);
                    List<Question> finalques;
                    finalques = dao.finAllQuestionMultipleEstudiante(ExamInseId);
                    req.getSession().setAttribute("subject", exm);
                    req.getSession().setAttribute("examenid", Newexam.getId_exam());
                    req.getSession().setAttribute("quests", finalques);
                    resp.sendRedirect(req.getContextPath() +"/Estudiante/examen.jsp");
                }else{
                    Exam exam = (Exam) dao.finOpenExamID(codigo, id);
                    if(exam.getStatusex().equals("1")) {
                        Exam_Question_Answer EQA = (Exam_Question_Answer) dao.findOneQuestionOne(exam.getId_exam());
                        List<Question> questionList;
                        if (EQA.getAnswer_id() != 1 && EQA.getOpen_Answer().equals("Multiple")) {
                            questionList = dao.finAllQuestionMultipleEstudiante(exam.getId_exam());
                        } else {
                            questionList = dao.findAllExamStudentAbierta(codigo, exam.getUser_sub_id());
                        }
                        req.getSession().setAttribute("subject", exm);
                        req.getSession().setAttribute("examenid", exam.getId_exam());
                        req.getSession().setAttribute("quests", questionList);
                        resp.sendRedirect(req.getContextPath() + "/Estudiante/examen.jsp");
                    }else if(exam.getStatusex().equals("2")){
                        req.getSession().setAttribute("mensaje","completado");
                        resp.sendRedirect(req.getContextPath() +"/Estudiante/acceso.jsp");
                    }else{
                        resp.sendRedirect(req.getContextPath() +"paginaDeError.jsp");
                    }
                }
            } else {
                req.getSession().setAttribute("mensaje","desactivado");
                resp.sendRedirect(req.getContextPath() +"/Estudiante/acceso.jsp");
            }
        } else {
            req.getSession().setAttribute("mensaje","noencontrado");
            resp.sendRedirect(req.getContextPath() + "/Estudiante/acceso.jsp");
        }
    }
}
