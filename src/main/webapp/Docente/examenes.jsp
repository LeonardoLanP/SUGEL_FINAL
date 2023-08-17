<%@ page import="mx.edu.utez.exameneslinea.model.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="../assets/img/sugel.png" type="image/png">
    <title>Examenes</title>
	<link rel="stylesheet" type="text/css" href="../assets/css/estiloHeader/header.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" type="text/css" href="../assets/css/docente/materias.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">
    <link rel="stylesheet" type="text/css" href="../assets/css/docente/boton.css">
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
                <div>
                    <h4><%= ((Person) request.getSession().getAttribute("sesion")).getName() %></h4>
                </div>
            </div>
            </center>
            <nav>
                <div class="min-menA">
                    <a href="#" class="btn-abrir" id="btn-abrir" onclick="cargarDatosUsuario(<%= ((Person) request.getSession().getAttribute("sesion")).getId_person()%>)">Editar perfil</a>
                </div>
                <a href="../docente/buscar-materias" >Materias</a>
                <div class="salir"><a href="../login?sesion=salir">Cerrar sesión</a></div>
            </nav>
            <label for="btn-menu"><i class="bi bi-x-lg"></i></label>
        </div>
    </div>
<!--Termina el menu-->


   <!--Formulario para modificar un usuario
      ESTO FUE LO QUE SE CAMBIO-->
<input type="checkbox" id="btn-modal">
    <div class="container-modal">
      <div class="content-modal">
          <h2 class="equipo">Registro de examen</h2>
          <form method="post" action="../examen/registrar-examen">
              <input type="text" name="nombreex" placeholder="Nombre del examen*" required=""
                     maxlength="45" id="nombreex"><br><br>
              <div class="g">
                  <label>Ingresa el tipo de preguntas de tu examen</label>
                  <div class="respuesta-radio">
                      <input type="radio" name="tipo" id="opcion1" class="respuesta" value="Abierta">
                      <label for="opcion1">Abiertas</label>
                  </div>
                  <div class="respuesta-radio">
                      <input type="radio" name="tipo" id="opcion2" class="respuesta" value="Multiple">
                      <label for="opcion2">Cerradas</label>
                  </div>
                  <br><br>
                  <label>Ingresa la cantidad de preguntas que debe tener cada examen*:</label>
                  <input type="number" name="numberex" required="" id="numberex" min="5" max="100">
              </div>
              <input type="submit" value="Agregar">
          </form>

          <div class="btn-cerrar">
          <label for="btn-modal">
            Cancelar
          </label>
        </div>
      </div>
    </div>

    <!--TERMINA LA 1° MODIFICACION-->

<!--Comienza el contenido principal-->
			<div class="contenedor">
        <!--Main es todo el contenedor de los recuadros de la materia-->
                <div class="m">
            <!-- materia es el contedor completo de la materia y todo el recuadro es a su vez un enlace a ver los examenes de esa materia-->
        <c:forEach items="${exam}" var="examen">
                    <a id="enlaceQuesGra_${examen.id_exam}" href="../examen/buscar-pregunta?codeex=${examen.code}&examenid=${examen.id_exam}&grade=${examen.gradeex}">
      		    <div class="examenes">
                    <label class="switchBtn">
                        <input type="checkbox" id="toggleSwitch_${examen.id_exam}" ${examen.statusex == 1 ? 'checked' : ''} data-examen-id="${examen.id_exam}" onChange="updateExamStatus(${examen.id_exam},'${examen.gradeex}')">
                        <div class="slide round" id="toggleText${examen.id_exam}"></div>
                    </label>
        <div class="imagen">
                <img src="https://img.freepik.com/vector-gratis/ilustracion-concepto-examenes_114360-1815.jpg?w=2000"/>
        </div>
        <div class="pie">
            <p><strong>Codigo: ${examen.code}</strong></p>
            <p><strong>EXAMEN: ${examen.namex}</strong></p>
            <p>Realizado por: </p>
                <p>${examen.studenAnswer}</p>

        </div>

    </div>
                    </a>
        </c:forEach>

        </div>

                <!--2° MODIFICACIÓN-->
                  <div class="boton-modal">
                    <label for="btn-modal">
                      +
                    </label>
                  </div>
                <!-- ULTIMA-->
				
			</div>







	<script type="text/javascript" src="../assets/js/agregar.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
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
    </script>


    <script type="text/javascript">

        const examenes = document.querySelectorAll('.examenes');

        function updateImageAndStyles(checkbox) {
            const examenDiv = checkbox.closest('.examenes');
            const imagen = examenDiv.querySelector('.imagen img');

            if (checkbox.checked) {
                examenDiv.classList.remove('disabled');
                imagen.src = 'https://img.freepik.com/vector-gratis/ilustracion-concepto-examenes_114360-1815.jpg?w=2000';
            } else {
                examenDiv.classList.add('disabled');
                imagen.src = '../assets/img/desactivada.svg';
            }
        }

        examenes.forEach((examen) => {
            const checkbox = examen.querySelector('input[type="checkbox"]');
            checkbox.addEventListener('change', () => {
                updateExamStatus(checkbox);
            });
            updateImageAndStyles(checkbox);
        });

        function updateExamStatus(examID,grade) {
            var checkbox = document.getElementById("toggleSwitch_" + examID);
            var estado = checkbox.checked ? 1 : 0;
            var action = estado === 0 ? 'desactivar' : 'activar';
            var actionText = '';

        switch (action) {
            case 'desactivar':
                actionText = 'Esta acción impedirá a los estudiantes responder el examen';
                break;
            case 'activar':
                actionText = 'Esta acción te impedirá hacer modificaciones en las preguntas del examen. ¡Recuerda compartir el código de acceso con tus alumnos para que puedan responder a este examen!';
                break;
            }
            if (grade !== 'AU'){
                Swal.fire({
                    icon: 'warning',
                    title: '¿Estás seguro de ' + action + ' este examen?',
                    text: actionText,
                    showCancelButton: true,
                    confirmButtonText: 'Aceptar',
                    cancelButtonText: 'Cancelar',
                    confirmButtonColor: '#001256',
                    cancelButtonColor: '#d33',
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "POST",
                            url: "../examen/cambio-status",
                            data: {examID: examID, estado: estado, grade: grade},
                            success: function (data) {
                                console.log(data);
                                if (data.fail) {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Verifica que todos los campos de tu examen estén llenos',
                                        showConfirmButton: false,
                                        timer: 4000,
                                    });
                                    checkbox.checked = !estado;
                                } else if(data.ques){
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Asegurate de que cada pregunta tenga almenos 2 respuestas',
                                        showConfirmButton: false,
                                        timer: 4000,
                                    });
                                    checkbox.checked = !estado;
                                } else {
                                    const enlaceQuesGra = document.getElementById('enlaceQuesGra_'+examID);
                                    let urlActual = enlaceQuesGra.href;
                                    const nuevaURL = urlActual.replace(/grade=[^&]+/,`grade=AU`);
                                    enlaceQuesGra.href = nuevaURL;
                                    const input = document.getElementById(`toggleSwitch_`+examID);
                                    input.setAttribute('onchange', `updateExamStatus(`+examID+`,'AU')`);

                                    updateImageAndStyles(checkbox);
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Cambios guardados',
                                        showConfirmButton: false,
                                        timer: 1500,
                                    });
                                    const NEWURL = nuevaURL + (nuevaURL.includes('?') ? '&' : '?') + 'primeraVez=true';
                                    document.cookie = 'alertaMostrada=true; expires=Fri, 31 Dec 9999 23:59:59 GMT; path=/';
                                    window.location.href = NEWURL;

                                }
                            },
                            error: function () {
                                console.log("Error en la solicitud Ajax.");
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error al guardar los cambios',
                                    text: 'Hubo un problema al intentar guardar los cambios.',
                                    showConfirmButton: true,
                                    confirmButtonColor: '#001256',
                                });
                                checkbox.checked = !estado;
                            }
                        });
                    }
                });
        }else{
                Swal.fire({
                    icon: 'warning',
                    title: '¿Estás seguro de ' + action + ' este examen?',
                    showCancelButton: true,
                    confirmButtonColor: '#001256',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Aceptar',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "POST",
                            url: "../examen/cambio-status",
                            data: {examID: examID, estado: estado, grade: grade},
                            success: function (data) {
                                console.log(data);
                                updateImageAndStyles(checkbox);
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Cambios guardados',
                                    showConfirmButton: false,
                                    timer: 1500,
                                });
                            },
                            error: function () {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error al guardar los cambios',
                                    text: 'Hubo un problema al intentar guardar los cambios.',
                                    showConfirmButton: true,
                                    confirmButtonColor: '#001256',
                                });
                                checkbox.checked = !estado;
                            }
                        });
                    } else {
                        checkbox.checked = !estado;
                    }
                });
            }
        }

        const contentElement = document.querySelector('.m');


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
            emptyContentContainer.style.margin = '30px auto';


            const imageElement = document.createElement('img');
            imageElement.src = '../assets/img/vacioe.svg';
            emptyContentContainer.appendChild(imageElement);


            const textElement = document.createElement('h2');
            textElement.textContent = 'Aún no hay exámenes registrados';
            emptyContentContainer.appendChild(textElement);

            contentElement.appendChild(emptyContentContainer);
        }

    </script>
    <script>
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
                    text: 'Corrobora que tu nombre y apellido este escrito correctamente.',
                    showConfirmButton: true,
                    confirmButtonColor: '#001256',
                });
                return false;
            }
            if (apellido2.trim() !== '' && !regexNombreApellido.test(apellido2)) {
                Swal.fire({
                    icon: 'error',
                    title: 'Verifica tu información',
                    text: '¡Corrobora que tu apellido materno este escrito correctamente!',
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
                            timer: 6000,
                            confirmButtonColor: '#001256',
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
