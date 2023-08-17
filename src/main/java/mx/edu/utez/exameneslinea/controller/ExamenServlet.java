package mx.edu.utez.exameneslinea.controller;

import com.google.gson.Gson;
import mx.edu.utez.exameneslinea.model.*;
import mx.edu.utez.exameneslinea.model.Daos.ExamenDao;
import com.google.gson.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ExamenServlet", value = "/examen/*")

public class ExamenServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getPathInfo();
        ExamenDao dao = new ExamenDao();
        switch (action){
            case "/buscar-pregunta":
                int idexam = Integer.parseInt(req.getParameter("examenid"));
                String grade = req.getParameter("grade");
                int id = idexam;

                if(grade.equals("SC")){
                    Exam_Question_Answer eqa = (Exam_Question_Answer) dao.findOneQuestionOne(idexam);
                    List<Question> lista;
                    String name = (String) dao.findNamex(id);
                    if(eqa.getAnswer_id() >=2){
                        lista = dao.finAllQuestionMultiple(id);
                    }else{
                        lista = dao.findQuestion(idexam);
                    }
                    req.getSession().setAttribute("nombrexamen", name);
                    req.getSession().setAttribute("questions", lista);
                    req.getSession().setAttribute("examenidques", id);
                    resp.sendRedirect(req.getContextPath() +  "/Docente/preguntas.jsp");
                }else if(grade.equals("AU")){
                    String code = req.getParameter("codeex");
                    List<Person> lista;
                    lista = dao.findAllStudents(idexam);
                    req.getSession().setAttribute("estudiantes", lista);
                    req.getSession().setAttribute("codeaccess", code);
                    resp.sendRedirect(req.getContextPath() +  "/Docente/resumen.jsp");
                }else {
                    resp.sendRedirect(req.getContextPath() +  "error.jsp");
                }

                break;
            case "":
                break;
            default:
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getPathInfo();
        List<Exam> lista;
        ExamenDao daoex = new ExamenDao();
        Gson gson = new Gson();


        switch (action){
            case "/registrar-examen":
                String examen = req.getParameter("nombreex");
                int numQues = Integer.parseInt(req.getParameter("numberex"))*2;
                String typeQues = req.getParameter("tipo");
                Person per =(Person) req.getSession().getAttribute("sesion");
                int idSub = (int) req.getSession().getAttribute("idsub");

                User_sub usersub = (User_sub) daoex.findOneUserSub(per.getID_user(),idSub);
                int idExamNew = daoex.insertExam(0,usersub.getId_user_sub(),examen);
                List<Exam_Question_Answer> examQuestionAnswers = new ArrayList<>();

                for (int i = 0; i < numQues; i++) {
                    if (typeQues.equals("Abierta")) {
                        examQuestionAnswers.add(new Exam_Question_Answer(0, idExamNew, 1,1,"Abierta"));
                    } else if (typeQues.equals("Multiple")) {
                        examQuestionAnswers.add(new Exam_Question_Answer(0, idExamNew, 2,2,"Multiple"));
                    }
                }

                daoex.insertEQA(examQuestionAnswers);

                lista = daoex.findAllExam(idSub,per.getID_user());
                req.getSession().removeAttribute("exam");
                req.getSession().setAttribute("exam", lista);
                resp.sendRedirect(req.getContextPath() + "/Docente/examenes.jsp");
                break;
            case "/Registrar-Respuestas":
                BufferedReader reader = req.getReader();
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
                Exam_Question_Answer respuesta = gson.fromJson(sb.toString(), Exam_Question_Answer.class);
                int id = respuesta.getQues_id();
                int idEQA = respuesta.getAnswer_id();
                String value = respuesta.getOpen_Answer();

                daoex.updateEQAnswer(value,id,idEQA);
                break;
            case "/cabio-respuestas":
                int id_exam_ques = Integer.parseInt(req.getParameter("id_exam_ques"));
                int id_answer = Integer.parseInt(req.getParameter("id_answer"));
                daoex.updateCloseAnswer(id_exam_ques,id_answer);
            break;
            case "/enviar-Respuesta":
                int examenid =(int) req.getSession().getAttribute("examenid");
                if(daoex.updateStatusEstudent(examenid)){
                    req.getSession().setAttribute("mensaje","exito");
                    resp.sendRedirect(req.getContextPath() +"/Estudiante/acceso.jsp");
                }else{
                    resp.sendRedirect(req.getContextPath() +"500.jsp");
                }
                break;
            case"/cambio-status":
                int examID = Integer.parseInt(req.getParameter("examID"));
                int estado = Integer.parseInt(req.getParameter("estado")) == 1 ? 1 : 0;
                Exam_Question_Answer eqa = (Exam_Question_Answer) daoex.findOneQuestionOne(examID);
                List<Question> listas;
                int contador = 0;
                int contadorques = 0;

                if(!(eqa.getAnswer_id() >=2)){
                    contadorques = 2;
                    listas = daoex.findQuestion(examID);
                    for (Question mul: listas) {
                        if(mul.getQuestion().isEmpty() || mul.getQuestion() == null){
                            contador++;
                        }
                    }
                }else{
                    listas = daoex.finAllQuestionMultiple(examID);
                    for (Question mul: listas) {
                        if(mul.getQuestion().isEmpty() || mul.getQuestion() == null){
                            contador++;
                        }
                        contadorques = 0;
                            for (Answer ans : mul.getAnswers()) {
                                if (ans.getAnswer().isEmpty() || ans.getAnswer() == null) {
                                    contador++;
                                }
                                contadorques++;
                            }
                        if(contadorques<2 || contador>0){
                            break;
                        }
                    }
                }
                if(!(contador>0) && contadorques >=2) {
                    if (daoex.updateStatusExmanDocente(examID, estado)) {
                        JsonObject jsonResponse = new JsonObject();
                        jsonResponse.addProperty("success", true);
                        resp.setContentType("application/json");
                        resp.setCharacterEncoding("UTF-8");
                        resp.getWriter().write(jsonResponse.toString());
                        resp.setStatus(HttpServletResponse.SC_OK);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "paginaDeError.jsp");
                    }
                }else if(contadorques < 2){
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("ques", true);
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    resp.getWriter().write(jsonResponse.toString());
                    resp.setStatus(HttpServletResponse.SC_OK);
                }else{
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("fail", true);
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    resp.getWriter().write(jsonResponse.toString());
                    resp.setStatus(HttpServletResponse.SC_OK);
                }
                break;
            case"/respuestas-estudiantes":
                int userId = Integer.parseInt(req.getParameter("userId"));
                String codeex = (String) req.getSession().getAttribute("codeaccess");
                List<Question> preguntasRespuestas = daoex.findAllAnswerStudents(userId,codeex);
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                String jsonResponse = gson.toJson(preguntasRespuestas);
                PrintWriter out = resp.getWriter();
                out.print(jsonResponse);
                out.flush();
                break;
            default:
        }
    }
}
