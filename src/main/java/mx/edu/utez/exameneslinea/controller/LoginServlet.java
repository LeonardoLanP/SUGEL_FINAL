package mx.edu.utez.exameneslinea.controller;

import mx.edu.utez.exameneslinea.model.Daos.ExamenDao;
import mx.edu.utez.exameneslinea.model.Daos.UsuarioDao;
import mx.edu.utez.exameneslinea.model.Exam;
import mx.edu.utez.exameneslinea.model.Person;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@WebServlet(name = "UsuarioServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String rol = req.getParameter("rol");
        String sesion = req.getParameter("sesion");

        if (rol != null && sesion == null) {
            req.getSession().setAttribute("rol", rol);
            resp.sendRedirect(req.getContextPath() + "/login.jsp?rol=" + rol);
        } else {
            HttpSession session = req.getSession();
            session.invalidate();
            req.getSession().setAttribute("mensaje","salir");
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String usuario = req.getParameter("usuario");
        String contrasena = req.getParameter("contrasena");
        String rol =(String) req.getSession().getAttribute("rol");
        int idRol;
        if(rol.equals("admin")){
            idRol = 1;
        }else if (rol.equals("docente")){
            idRol = 2;
        }else{
            idRol = 3;
        }
        UsuarioDao dao  = new UsuarioDao();
        Person usr = (Person) dao.findOne(usuario,contrasena,idRol);

        if (usr.getID_user() != 0 && usr.getRol_id() == idRol) {
            if (usr.getRol_id() == 1 && usr.getUser_status() == 1) {
                req.getSession().setAttribute("sesion", usr);
                resp.sendRedirect(req.getContextPath() + "/Administrador/inicio.jsp");
            } else if (usr.getRol_id() == 2 && usr.getUser_status() == 1) {
                req.getSession().setAttribute("sesion", usr);
                resp.sendRedirect(req.getContextPath() + "/docente/buscar-materias");
            } else if (usr.getRol_id() == 3 && usr.getUser_status() == 1) {
                req.getSession().setAttribute("sesion", usr);
                req.getSession().setAttribute("idEstudiantePerson", usr.getId_person());
                ExamenDao exm= new ExamenDao();
                Exam examen = new Exam();
                Exam exmdocente = new Exam();

                examen = (Exam) exm.findexameninconcluso(usr.getID_user());
                exmdocente = (Exam) exm.findOneByCode(examen.getCode());
                if(examen.getStatusex()!=null && exmdocente.getStatusex() != null && !exmdocente.getStatusex().isEmpty() && !examen.getStatusex().isEmpty()){
                    if(examen.getStatusex().equals("1") && exmdocente.getStatusex().equals("1")){
                        req.getSession().setAttribute("codex",examen.getCode());
                        req.getSession().setAttribute("inconcluso", "inconcluso");
                        resp.sendRedirect(req.getContextPath() + "/ques_reload?codigo="+examen.getCode());
                    }else{
                        resp.sendRedirect(req.getContextPath() + "/Estudiante/acceso.jsp");
                    }
                }else{
                    resp.sendRedirect(req.getContextPath() + "/Estudiante/acceso.jsp");
                }
            } else {
                req.getSession().setAttribute("status", "desactivado");
                resp.sendRedirect(req.getContextPath() + "/login.jsp?rol="+rol);
            }
        } else {
            req.getSession().setAttribute("status", "noRegistrado");
            resp.sendRedirect(req.getContextPath() + "/login.jsp?rol="+rol);

        }
    }
}
