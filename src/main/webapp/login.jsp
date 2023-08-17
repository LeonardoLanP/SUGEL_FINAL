<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="/assets/img/sugel.png" type="image/png">
    <link rel="stylesheet" href="assets/css/boot/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="assets/css/estiloHeader/header.css">
     <link rel="stylesheet" type="text/css" href="assets/css/estiloLogin/login.css">

    <title>Inicio de sesión</title>
</head>

<body>

 <header class="header">
    <div class="container">
    <div class="btn-menu">
      <label for="btn-menu">☰</label>
    </div>
      <div class="logo">
      </div>
      
      <div class="menu">
        <img src="assets/img/sugel.png" alt="Logo">
      </div>
    </div>
  </header>
  <div class="capa"></div>

<input type="checkbox" id="btn-menu">
<div class="container-menu">
  <div class="cont-menu">
    <nav>
      <a href="index.jsp">Inicio</a>
        <c:choose>
            <c:when test="${rol == 'estudiante'}">
                <a href="./login?rol=estudiante"><strong>Estudiante</strong></a>
            </c:when>
            <c:otherwise>
                <a href="./login?rol=estudiante">Estudiante</a>
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${rol == 'docente'}">
                <a href="./login?rol=docente"><strong>Docente</strong></a>
            </c:when>
            <c:otherwise>
                <a href="./login?rol=docente">Docente</a>
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${rol == 'admin'}">
                <a href="./login?rol=admin"><strong>Administrador</strong></a>
            </c:when>
            <c:otherwise>
                <a href="./login?rol=admin">Administrador</a>
            </c:otherwise>
        </c:choose>
    </nav>
    <label for="btn-menu"><i class="bi bi-x-lg"></i></label>
  </div>
</div>
     

    <div class="hero">
      <div class="hero-bg">
        <div class="bg"></div>
        <div class="bg bg2"></div>
        <div class="bg bg3"></div>
      </div>
      <div class="hero-text">

         <!--FORMULARIO-->
        <div class="log">

         <form class="" action="login" method="post">
              <h1><c:choose>
                  <c:when test="${rol == 'docente'}">Docente</c:when>
                  <c:when test="${rol == 'estudiante'}">Estudiante</c:when>
                  <c:when test="${rol == 'admin'}">Administrador</c:when>
              </c:choose></h1>
              <div class="inputbox">
                <input type="text" name="usuario" required="" id="usuario">
                <span>Nombre de usuario</span> 
                <i></i>  
              </div>
              <div class="inputbox">
                <input type="password" name="contrasena" required="" id="contrasena" >
                <span>Contraseña</span> 
                <i></i>
                  <input type="hidden" name="rol" value="<%= request.getAttribute("rol") %>">
              </div>
              <input type="submit" value="Ingresar" id="ingresar" name="ingresar">
         </form> 
            
        </div>


     </div>
   
  </div>

 <script src="assets/css/js/bootstrap.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

 <script type="text/javascript">
     document.addEventListener('DOMContentLoaded', function() {
     var status = '<%= request.getParameter("status") %>';
     if (status === 'noRegistrado') {

     } else if (status === 'desactivado') {
     }
 });
 </script>

 <script>
     <%String mensaje = (String) request.getSession().getAttribute("status");
         if (mensaje != null && !mensaje.isEmpty()) {
             switch (mensaje) {
                 case "desactivado":
     %>
     Swal.fire({
         icon: 'error',
         title: 'Oops...',
         text: 'Usuario desactivado. Solicita la reactivación!',
         timer: 5000,
        confirmButtonColor: '#001256',
     })
     <%break;case "noRegistrado": %>
     Swal.fire({
         icon: 'error',
         title: 'Oops...',
         text: 'Usuario o contraseña incorrectos. Intenta de nuevo!',
         timer: 5000,
         confirmButtonColor: '#001256',
     })
     <%break;} request.getSession().removeAttribute("status");}%>
 </script>

 <SCRIPT>
     fetch('https://cdn.jsdelivr.net/npm/sweetalert2@11')
         .then(response => {
             if (!response.ok) {
                 throw new Error(
                     Swal.fire({
                         icon: 'error',
                         title: 'Error de conexion',
                         timer: 1500,
                     }));
             }
             return response;
         })
         .then(() => {
         })
         .catch(error => {
             console.error(error);
             window.location.href = 'coneccion.jsp';
         });

 </SCRIPT>

</body>
</html>
