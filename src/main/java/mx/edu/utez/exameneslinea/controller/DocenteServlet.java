package mx.edu.utez.exameneslinea.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import mx.edu.utez.exameneslinea.model.Daos.ExamenDao;
import mx.edu.utez.exameneslinea.model.Daos.UsuarioDao;
import mx.edu.utez.exameneslinea.model.Exam;
import mx.edu.utez.exameneslinea.model.Person;
import mx.edu.utez.exameneslinea.model.Subject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "DocenteServlet", value = "/docente/*")
public class DocenteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getPathInfo();
        UsuarioDao daou = new UsuarioDao();
        ExamenDao daoex = new ExamenDao();
        List<Subject> lista = null;
        switch (action){
            case "/buscar-examenes":
                int materiaId = Integer.parseInt(req.getParameter("materiaId"));
                Person per =(Person) req.getSession().getAttribute("sesion");
                int idsub = (int) req.getSession().getAttribute("idsub");
                if (idsub != 0) {
                    lista = daoex.findAllExam(idsub,per.getID_user());
                }else {
                    lista = daoex.findAllExam(materiaId,per.getID_user());
                }
                req.getSession().setAttribute("exam", lista);
                req.getSession().setAttribute("idsub",materiaId);
                resp.sendRedirect(req.getContextPath() + "/Docente/examenes.jsp");
                break;
            case"/buscar-materias":
                Person pers =(Person) req.getSession().getAttribute("sesion");
                lista = daoex.findAllMa(pers.getID_user());
                req.getSession().setAttribute("subjectlista", lista);
                req.getSession().setAttribute("idsub",0);
                resp.sendRedirect(req.getContextPath() + "/Docente/materias.jsp");
                break;
            case "/historial-estudiante":
                Person estudiate =(Person) req.getSession().getAttribute("sesion");
                List<Person> listagrade = daou.findAllgrades(estudiate.getUser_id());
                req.getSession().setAttribute("materias", listagrade);
                resp.sendRedirect(req.getContextPath() + "/Estudiante/historial.jsp");
                break;
            case "/verificar-estado-examen":
                String codex = (String) req.getSession().getAttribute("codex");
                boolean usuarioActivo = daou.verificarestatusexamen(codex);
                resp.setContentType("application/json");
                PrintWriter out = resp.getWriter();
                out.print("{\"usuarioActivo\": " + usuarioActivo + "}");
                out.flush();
                break;
            default:
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getPathInfo();
        UsuarioDao daou = new UsuarioDao();
        ExamenDao dao = new ExamenDao();

        switch (action){
            case "/actualizar-datos-docente":
                String urlActual = req.getParameter("referer");
                Person per =(Person) req.getSession().getAttribute("sesion");
                String name = req.getParameter("nombre");
                String last1 = req.getParameter("ap1");
                String last2 = req.getParameter("ape2");
                String pass = req.getParameter("pass");
                Person usr = new Person();
                usr.setName(name);
                usr.setLastname1(last1);
                usr.setLastname2(last2);
                if(!pass.equals("")){
                    daou.updatepass(per.getID_user(),pass,per.getRol_id());
                }
                daou.updateDocente(per.getUser_id(),usr);
                req.getSession().setAttribute("subcreate", "cambios");
                resp.sendRedirect(urlActual);
                break;
            case "/resgitra-materia":
                String nameS = req.getParameter("nombre");
                int grade = Integer.parseInt(req.getParameter("grado"));
                String group = req.getParameter("grupo");
                Person pers =(Person) req.getSession().getAttribute("sesion");
                if(!(dao.findsubDocente(grade,group,nameS))){
                    dao.insertMateria(new Subject(0,grade,group,nameS,1));
                    Subject mater = (Subject) dao.findMateria(grade,group,nameS);
                    dao.insertMateriaUsuario(pers.getID_user(),mater.getId_sub());

                    req.getSession().setAttribute("materias", mater);
                    req.getSession().setAttribute("subcreate", "creada");
                    resp.sendRedirect(req.getContextPath() + "/docente/buscar-materias");
                }else{
                    req.getSession().setAttribute("subcreate", "nocreada");
                    resp.sendRedirect(req.getContextPath() + "/docente/buscar-materias");
                }
                break;
            case "/califcar-alumno":
                int estudianteId = Integer.parseInt(req.getParameter("examid"));
                double calificacion = Double.parseDouble(req.getParameter("calificacion")) / 10;
                String nomeclatura = "";
                ExamenDao daox = new ExamenDao();
                if (calificacion >= 9.9 && calificacion <= 10) {
                    nomeclatura = "AU";
                 } else if (calificacion >= 9 && calificacion <= 9.8) {
                    nomeclatura = "DE";
                }else if (calificacion >= 8 && calificacion <= 8.9) {
                    nomeclatura = "SA";
                }else {
                    nomeclatura = "NA";
                }

                if (daox.updateCalificacion(estudianteId, calificacion)) {
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("status", "success");
                    jsonResponse.addProperty("message", "Calificación actualizada exitosamente");
                    jsonResponse.addProperty("nuevaCalificacion", nomeclatura);
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    Gson gson = new Gson();
                    String jsonString = gson.toJson(jsonResponse);
                    resp.getWriter().write(jsonString);
                } else {
                    resp.sendRedirect(req.getContextPath() + "error.jsp");
                }
                break;
            case"/cambio-status-sub":
                Person perex =(Person) req.getSession().getAttribute("sesion");
                int subid = Integer.parseInt(req.getParameter("subid"));
                int estado = Integer.parseInt(req.getParameter("estado")) == 1 ? 1 : 0;

                if(dao.updatestatussub(subid,estado,perex.getID_user())){
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("success",true);
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    resp.getWriter().write(jsonResponse.toString());
                    resp.setStatus(HttpServletResponse.SC_OK);
                }else{
                    resp.sendRedirect(req.getContextPath() +"paginaDeError.jsp");
                }
                break;
            default:
        }
    }
}
