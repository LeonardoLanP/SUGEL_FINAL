<%@ page import="mx.edu.utez.exameneslinea.model.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="icon" href="../assets/img/sugel.png" type="image/png">
  <title>Resumen</title>
	<link rel="stylesheet" type="text/css" href="../assets/css/estiloHeader/header.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" type="text/css" href="../assets/css/docente/materias.css">
  <link rel="stylesheet" type="text/css" href="../assets/css/docente/resumen.css">
		<link rel="stylesheet" type="text/css" href="../assets/css/docente/boton.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">

</head>
<body>

    <div class="overlay" id="overlay" >
      <div class="pop-up" id="pop-up">
        <a href="#" id="btn-cerrar" class="btn-cerrar"><i class="bi bi-x-lg"></i></a>
        <h2 id="nombreuser">Docente <%= ((Person) request.getSession().getAttribute("sesion")).getName() %></h2>
        <form action="../docente/actualizar-datos-docente" method="POST" id="formulario-modal" onsubmit="return validarFormulario()">
          <input type="hidden" name="referer" value="${pageContext.request.requestURI}">
          <label>Nombre/s*:</label>
          <input type="text" name="nombre" id="nombre" maxlength="45">
          <label>Apellido paterno*:</label>
          <input type="text" name="ap1" id="ap1" maxlength="30">
          <label>Apellido materno*:</label>
          <input type="text" name="ape2" id="ape2" maxlength="30">
          <label>CURP*:</label>
          <input type="text" name="CURP" id="curp" maxlength="18" readonly>
          <label>Actualizar contraseña:</label>
          <input type="text" name="pass" id="pass" maxlength="20" minlength="3">
          <br><center><input type="submit" name="" value="Modificar" id="btn-enviar"></center>

        </form>
      </div>
    </div>
    <!--Termina el registro de usuarios-->
	<div class="background"></div>
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
        <a href="#" class="btn-abrir" id="btn-abrir" onclick="cargarDatosUsuario(<%= ((Person) request.getSession().getAttribute("sesion")).getId_person()%>)">Editar perfil</a>
		</div>
      <a href="../docente/buscar-examenes?materiaId=<%=  request.getSession().getAttribute("idsub") %>" >Examenes</a>
      <a href="../docente/buscar-materias" >Materias</a>
      <div class="salir"><a href="../login?sesion=salir">Cerrar sesión</a></div>
    </nav>
    <label for="btn-menu"><i class="bi bi-x-lg"></i></label>
  </div>
</div>

<!--Termina el menu-->
<div class="lista">
  <table>
    <c:forEach items="${estudiantes}" var="estudiante">
      <tr class="estudiante">
        <td id="${estudiante.user_id}">${estudiante.name} ${estudiante.lastname1} ${estudiante.lastname2}<div class="calif">${estudiante.grade}</div></td>
      </tr>
    </c:forEach>
  </table>
</div>

<div class="resumen">
  <div class="examen">
    <span class="c"><i class="bi bi-x-lg"></i></span>
    <center><button id="modalBtn">Calificar</button></center>
  </div>
</div>

<!-- Ventana modal -->
<div class="modal" id="myModal">
  <div class="modal-content">
    <span class="close" id="closeBtn"><i class="bi bi-x-lg"></i></span>
    <form id="calificacionForm">
      <label for="calificacion">Calificación:</label>
      <input style="text-align: center;" type="number" name="calificacion" id="calificacion" max="100" min="0">
      <br>
      <input type="hidden" name="examid" id="examid" value="">
      <input type="hidden" name="estudentid" id="estudentid" value="">
      <input type="submit" value="Enviar">
    </form>
    <div class="tooltip">Ingresa el porcentaje que obtuvo el estudiante, sin el signo de porcentaje</div>
  </div>
</div>





    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="../assets/js/agregar.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/js-cookie@3.0.1/dist/js.cookie.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.js"></script>



    <script type="text/javascript">
      jQuery(document).ready(function() {
        $('.estudiante').click(function() {
          var userId = $(this).find('td').attr('id');
          console.log(userId + " ID del usuario a buscar")
          obtenerPreguntasYRespuestas(userId);
        });
      });

      function obtenerPreguntasYRespuestas(userId) {
        $.ajax({
          type: 'POST',
          url: '../examen/respuestas-estudiantes',
          data: { userId: userId },
          success: function(response) {
            console.log("Llegó la respuesta del servidor");
            mostrarPreguntasYRespuestas(response);
          },
          error: function() {
            alert('Error al obtener preguntas y respuestas.');
          }
        });
      }

      function mostrarPreguntasYRespuestas(response) {
        var preguntasHTML = '';
        var nombreAlumno = response[0].nombreAlumno;

        preguntasHTML += '<div class="examen">';
        preguntasHTML += '<span class="c"><i class="bi bi-x-lg"></i></span>';
        preguntasHTML += '<h2>' + nombreAlumno + '</h2>';

        for (var i = 0; i < response.length; i++) {
          preguntasHTML += '<div class="pregunta">' + response[i].question + '<div class="respuesta">';
          preguntasHTML += '<div class="resp"></div><strong>' + response[i].answer + '</strong>';
          preguntasHTML += '</div></div>';
          var examId = response[i].exam_id;
          var idest = response[i].ques_id;
        }

        preguntasHTML += `<center><button id="modalBtn" data-answer-id="`+examId+`" data-estudiante-id="`+idest+`">Calificar</button></center>`;
        preguntasHTML += '</div>';

        $('.resumen').html(preguntasHTML);

        manejarEventosModal();
      }

      function manejarEventosModal() {
        const modalBtn = document.getElementById('modalBtn');

        const modal = document.getElementById('myModal');


        const closeBtn = document.getElementById('closeBtn');

        function openModal() {
          modal.style.display = 'block';
        }

        function closeModal() {
          modal.style.display = 'none';
        }

        modalBtn.addEventListener('click', openModal);

        closeBtn.addEventListener('click', closeModal);

        window.addEventListener('click', (event) => {
          if (event.target === modal) {
            closeModal();
          }
        });

        const input = document.querySelector('.modal-content input');
        const tooltip = document.querySelector('.tooltip');

        function showTooltip() {
          tooltip.classList.add('show');
          tooltip.classList.remove('hide');
        }

        function hideTooltip() {
          tooltip.classList.add('hide');
          tooltip.classList.remove('show');
        }

        input.addEventListener('mouseover', showTooltip);

        input.addEventListener('mouseout', hideTooltip);

        input.addEventListener('input', hideTooltip);

        const closeButton = document.querySelector('.c');

        closeButton.addEventListener('click', () => {
          examenContainer.style.display = 'none';
        });

      }
    </script>

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

  
  const examenContainer = document.querySelector('.resumen');

  const tdElements = document.querySelectorAll('table td');

  tdElements.forEach((tdElement) => {
    tdElement.addEventListener('click', () => {
      examenContainer.style.display = 'block';
    });
  });

  $(document).ready(function() {
  $('#calificacionForm').submit(function(event) {
    event.preventDefault();

    var examenID = $('#modalBtn').data('answer-id');
    var estudianteid = $('#modalBtn').data('estudiante-id');

    var calificacion = $('#calificacion').val();

    console.log(examenID,estudianteid,calificacion)
    $('#examid').val(examenID);
    $('#estudentid').val(estudianteid);


    $.ajax({
      type: 'POST',
      url: '../docente/califcar-alumno',
      data: $('#calificacionForm').serialize(),
      success: function(response) {
        console.log(response);
        var estudianteId = estudianteid;
        var nuevaCalificacion = response.nuevaCalificacion;
        var estudianteElement = $('#' + estudianteId);
        estudianteElement.find('.calif').text(nuevaCalificacion);

        $('#myModal').hide();
        $('#calificacion').val('');

        switch (nuevaCalificacion) {
          case 'AU':
            estudianteElement.find('.calif').css('background-color', '#203276');
            break;
          case 'DE':
            estudianteElement.find('.calif').css('background-color', '#2B439C');
            break;
          case 'SA':
            estudianteElement.find('.calif').css('background-color', '#40549D');
            break;
          case 'NA':
            estudianteElement.find('.calif').css('background-color', '#E74C3C');
            break;
          default:
            estudianteElement.find('.calif').css('background-color', '#555');
            break;
        }
        var estudianteRow = estudianteElement.closest('tr');
        estudianteRow.fadeOut(300).fadeIn(300).fadeOut(300).fadeIn(300);

      },
      error: function() {
        alert('Error al enviar la calificación.');
      }
    });
  });
});




  const params = new URLSearchParams(window.location.search);
  const codeex = params.get('codeex');
  const examenid = params.get('examenid');
  const grade = params.get('grade');

  const storageKey = `alertaMostrada_${codeex}_${examenid}_${grade}`;

  const alertaMostrada = localStorage.getItem(storageKey);

  if (!alertaMostrada) {
    Swal.fire({
      icon: 'info',
      title: '¡Bienvenido!',
      text: 'Este es el resumen en donde podrás evaluar a los estudiantes que realicen tu examen',
      showConfirmButton: true,
      timer: 30000,
    });

    localStorage.setItem(storageKey, 'true');
  }



  function validarFormulario() {
        const nombre = document.getElementById('nombre').value;
        const apellido1 = document.getElementById('ap1').value;
        const apellido2 = document.getElementById('ape2').value;
        const contrasena = document.getElementById('pass').value;
        const regexNombreApellido = /^[A-Z][a-z]+( [A-Z][a-z]+)*$/;
        if (!regexNombreApellido.test(nombre) || !regexNombreApellido.test(apellido1)) {
          Swal.fire({
            icon: 'error',
            title: 'Verifica tu información',
            text: 'Corrobora que tu nombre o apellido esté escrito correctamente.',
            showConfirmButton: true,
            confirmButtonColor: '#001256',
          });
          return false;
        }
        if (apellido2.trim() !== '' && !regexNombreApellido.test(apellido2)) {
          Swal.fire({
            icon: 'error',
            title: 'erifica tu información',
            text: '¡Corrobora que tu apellido materno esté escrito correctamente!',
            showConfirmButton: true,
            confirmButtonColor: '#001256',
          });
          return false;
        }
        if (contrasena.length > 0 && (contrasena.length < 3 || contrasena.length > 20)) {
          Swal.fire({
            icon: 'error',
            title: 'Verifica tu información',
            text: 'La nueva contraseña debe tener entre 3 y 20 caracteres.',
            showConfirmButton: true,
            confirmButtonColor: '#001256',
          });
          return false;
        }
        return true;
      }

      function cargarDatosUsuario(userId) {
        $.ajax({
          type: "POST",
          url: "../admin/buscar-datos",
          data: { userId: userId },
          success: function(data) {
            var datosUsuario = data.split('\n');
            var usuario = {
              name: datosUsuario[0].trim(),
              lastname1: datosUsuario[1].trim(),
              lastname2: datosUsuario[2].trim(),
              curp: datosUsuario[3].trim(),
              id: datosUsuario[7].trim(),
            };

            $("#id_user").val(usuario.id);
            $("#nombreuser").val(usuario.name);
            $("#nombre").val(usuario.name);
            $("#ap1").val(usuario.lastname1);
            $("#ape2").val(usuario.lastname2);
            $("#curp").val(usuario.curp);

            $("#overlay").prop("checked", true);
          },
          error: function() {
            console.log("Error en la solicitud Ajax.");
          }
        });
      }

      function verificarEstadoUsuario() {
        $.ajax({
          url: '../admin/verificar-estado-usuario',
          method: 'GET',
          dataType: 'json',
          success: function(response) {
            if (response.usuarioActivo) {
              Swal.fire({
                icon: 'warning',
                title: 'Tu cuenta ha sido desactivada',
                text: 'Comunícate con el administrador para más información',
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#001256',
                timer: 5000,
              }).then(function() {
                setTimeout(function() {
                  window.location.href = "../index.jsp";
                }, 1000);
              });
            }
          },
          error: function() {
            console.log("Error al verificar el estado del usuario.");
          }
        });
      }
      setInterval(verificarEstadoUsuario, 1000);


//Si la tabla esta vacía muestra que no hay respuestas aún
      const contentElement = document.querySelector('table');

  
  if (contentElement && contentElement.childElementCount === 0) {
    
    const emptyContentContainer = document.createElement('div');
    contentElement.style.background = 'none';
    contentElement.style.width = '100%';
    contentElement.style.height = '100hv';
    contentElement.style.display = 'flex';
    emptyContentContainer.style.textAlign = 'center';
    emptyContentContainer.style.width = '30%';
    emptyContentContainer.style.height = '40%';
    emptyContentContainer.style.color = '#001256';
    emptyContentContainer.style.font.size = '20px';
    emptyContentContainer.style.font.weight = '800';
    emptyContentContainer.style.margin = '30px auto';

    
    

    
    const textElement = document.createElement('h2');
    
    textElement.textContent = 'Aún no hay respuestas disponibles';
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

</body>
</html>