package mx.edu.utez.exameneslinea.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.Gson;

import com.google.gson.JsonObject;
import mx.edu.utez.exameneslinea.model.Answer;
import mx.edu.utez.exameneslinea.model.Daos.ExamenDao;
import mx.edu.utez.exameneslinea.model.Question;

@WebServlet(name = "RegistrarQuestionServlet", value = "/RegistrarQuestionServlet")
public class RegistrarQuestionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        BufferedReader reader = req.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String jsonString = sb.toString();

        Gson gson = new Gson();
        JsonObject jsonObject = gson.fromJson(jsonString, JsonObject.class);
        int id = Integer.parseInt(jsonObject.get("id").getAsString());
        int answerId = Integer.parseInt(jsonObject.get("answer_id").getAsString());
        String value = jsonObject.get("value").getAsString();
        int idexam = (int) req.getSession().getAttribute("examenidques");

        ExamenDao daoex = new ExamenDao();

        if (answerId == 1) {
            if (id == 1) {
                Question QUES = (Question) daoex.insertQUES(value, "Abierta");
                Question ques = (Question) daoex.findEQA(idexam, 1);
                daoex.updateEQA(QUES.getQues_id(), idexam, ques.getId_exam_question());

                int newId = QUES.getQues_id();
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("originalId", id);
                jsonResponse.addProperty("newId", newId);

                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                PrintWriter out = resp.getWriter();
                out.print(jsonResponse.toString());
                out.flush();
            } else {
                daoex.updateQues(id, value);
                resp.setContentType("text/plain");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("Datos recibidos en el servidor con éxito");
            }
        } else if (answerId == 2) {
            if(id == 2){
                Question QUES = (Question) daoex.insertQUES(value, "Multiple");
                Question ques = (Question) daoex.findEQA(idexam, 2);
                daoex.updateEQA(QUES.getQues_id(), idexam, ques.getId_exam_question());

                int newId = QUES.getQues_id();
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("originalId", id);
                jsonResponse.addProperty("newId", newId);

                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                PrintWriter out = resp.getWriter();
                out.print(jsonResponse.toString());
                out.flush();
            } else if (id >= 2) {
                daoex.updateQues(id, value);
                resp.setContentType("text/plain");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("Datos recibidos en el servidor con éxito");
            }

        }else if(answerId == 0 || answerId >2){
            if(answerId == 0){
                Answer answer = (Answer) daoex.insertAnswer(value);
                daoex.insertEQAAnswer(idexam,id,answer.getId_answer());

                int newId = answer.getId_answer();
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("newId", id);
                jsonResponse.addProperty("newAnswerId", newId);

                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                PrintWriter out = resp.getWriter();
                out.print(jsonResponse.toString());
                out.flush();
            } else {
                daoex.updateAnswer(answerId, value);
                resp.setContentType("text/plain");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("Datos recibidos en el servidor con éxito");
            }
        }
    }

}


