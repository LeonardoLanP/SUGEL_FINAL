<%@ page import="mx.edu.utez.exameneslinea.model.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Historial</title>
	 <link rel="stylesheet" type="text/css" href="../assets/css/estiloHeader/header.css">
  <link rel="icon" href="../assets/img/sugel.png" type="image/png">
	 <link rel="stylesheet" type="text/css" href="../assets/css/estudiante/acceso.css">
	 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<style type="text/css">

</style>
<body>
  <header class="header">
    <div class="container">
    <div class="btn-menu">
      <label for="btn-menu">☰</label>
    </div>
      <div class="logo">
      </div>
      
      <div class="menu">
        <img src="../assets/img/sugel.png" alt="Logo">
      </div>
    </div>
  </header>

  
<!--  --------------->
<input type="checkbox" id="btn-menu">
<div class="container-menu">
  <div class="cont-menu">

    <center><div class="perfil"><i class="bi bi-person-heart"></i><br>
      <h4><%= ((Person) request.getSession().getAttribute("sesion")).getName() %></h4></div></center>

    <nav>   
      <div class="min-menA">
      <a href="acceso.jsp">Regresar</a>
    </div>
      <div class="salir"><a href="../login?sesion=salir">Cerrar sesión</a></div>
    </nav>
    <label for="btn-menu"><i class="bi bi-x-lg"></i></label>
  </div>
</div>

<!--Termina el menu-->


	<div class="hexagon-container">
    <div class="hexagon hexagon-top-left"></div>
    <div class="hexagon hexagon-bottom-right"></div>
  </div>

  <div class="content">
    <c:forEach items="${materias}" var="calif">
      <div class="hist">
        <center><h3>${calif.subname} ${calif.namex}</h3></center>
        <div class="inf">
          <div class="prof">
            <label>Nombre del docente:</label> ${calif.name}
          </div>
          <div class="date">
            <label>fecha:</label> ${calif.datex}
          </div>
        </div>
        <div class="cal">
          <label>Calificación:</label><div class="calif">${calif.grade}</div>
        </div>
      </div>
    </c:forEach>
  </div>


  <script type="text/javascript">
  const califElements = document.querySelectorAll('.calif');

  califElements.forEach((califElement) => {
    const text = califElement.textContent.trim();

    switch (text) {
      case 'AU':
        califElement.style.backgroundColor = '#203276';
        break;
      case 'DE':
        califElement.style.backgroundColor = '#2B439C';
        break;
      case 'SA':
        califElement.style.backgroundColor = '#40549D';
        break;
      case 'NA':
        califElement.style.backgroundColor = '#E74C3C';
        break;
      default:
        califElement.style.backgroundColor = '#555';
        break;
    }
  });

     const contentElement = document.querySelector('.content');

     if (contentElement && contentElement.childElementCount === 0) {

       const emptyContentContainer = document.createElement('div');
       contentElement.style.background = 'none';
       emptyContentContainer.style.textAlign = 'center';
       emptyContentContainer.style.width = '30%';
       emptyContentContainer.style.height = '40%';
       emptyContentContainer.style.color = '#001256';
       emptyContentContainer.style.margin = '30px auto';


       const imageElement = document.createElement('img');
       imageElement.src = '../assets/img/vacio.svg';
       emptyContentContainer.appendChild(imageElement);


       const textElement = document.createElement('h2');
       textElement.textContent = 'Aún no hay contenido por mostrar';
       emptyContentContainer.appendChild(textElement);


       contentElement.appendChild(emptyContentContainer);
     }
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
              window.location.href = '../coneccion.jsp';
            });

  </SCRIPT>
  

</body>
</html>