<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="assets/css/boot/bootstrap.css">
  <link rel="icon" href="assets/img/sugel.png" type="image/png">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link rel="stylesheet" type="text/css" href="assets/css/index.css">
  <link rel="stylesheet" type="text/css" href="assets/css/estiloHeader/header.css">
  <title>Sugel</title>
</head>

<body>
  <div class="background">
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
      <a href="#">Inicio</a>
      <a href="./login?rol=estudiante">Estudiante</a>
      <a href="./login?rol=docente">Docente</a>
      <a href="./login?rol=admin">Administrador</a>
    </nav>
    <label for="btn-menu"><i class="bi bi-x-lg"></i></label>
  </div>
</div>

  <section class="contenido">
    <div class="frase-cont">
      <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img src="assets/img/estudiantes.svg" class="d-block w-100" alt="...">
          </div>
          <div class="carousel-item">
            <img src="assets/img/calificaciones.svg" class="d-block w-100" alt="...">
          </div>
          <div class="carousel-item">
            <img src="assets/img/calificaciones.svg" class="d-block w-100" alt="...">
          </div>
        </div>
      </div>

      <div class="frase">
        <h1>"Cualquier momento es perfecto para aprender algo nuevo"</h1>
      </div>
      <div class="autor">
        <h3>-Albert Einstein</h3>
      </div>
    </div>

    <div class="Bienvenida">
      <h1>BIENVENIDO A SUGEL</h1>
      <h3>Sistema Universitario Gestor de Exámenes en Línea</h3>
    </div>
  </section>
</div>
 


    <!-- FOOTER -->
        <footer class="cont">
            <p><a href="#">Back to top</a></p>
            <p>&copy; 2023 SUGEL UTEZ. Integradora &middot; <a href="https://utez.edu.mx">UTEZ</a> &middot; </p>
            <div class="redes">
                
                        <a href="https://www.facebook.com/UTEZ.Morelos?mibextid=ZbWKwL"><i class="bi bi-facebook"></i></a>
                <a href="https://instagram.com/utezmorelos?igshid=MmJiY2I4NDBkZg=="><i class="bi bi-instagram"></i></a>
                    
                
            </div>
        </footer>

  <script src="assets/css/js/bootstrap.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script>
    <%String mensaje = (String) request.getSession().getAttribute("mensaje");
        if (mensaje != null && !mensaje.isEmpty()) {%>
    Swal.fire({
      icon: 'success',
      title: 'Sesión cerrada correctamente',
      timer: 5000,
      confirmButtonColor: '#001256',
    });
           <% } request.getSession().removeAttribute("mensaje");%>
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
                        confirmButtonColor: '#001256',

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
