<%@ page import="mx.edu.utez.exameneslinea.model.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="../assets/img/sugel.png" type="image/png">
    <title>Preguntas</title>
	<link rel="stylesheet" type="text/css" href="../assets/css/estiloHeader/header.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" type="text/css" href="../assets/css/docente/materias.css">
    <link rel="stylesheet" type="text/css" href="../assets/css/docente/preguntas.css">
</head>

<style>
    .boton-opcion label.disabled {
        color: #777777;
        pointer-events: none;
        cursor: default;
    }
</style>


<body>
	<!-- FORMULARIO PARA EL REGISTRO DE USUARIOS-->

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
                <div class="min-menA"><a href="#" class="btn-abrir" id="btn-abrir" onclick="cargarDatosUsuario(<%= ((Person) request.getSession().getAttribute("sesion")).getId_person()%>)">Editar perfil</a></div>
                <a href="../docente/buscar-examenes?materiaId=<%=  request.getSession().getAttribute("idsub") %>" >Examenes</a>
                <a href="../docente/buscar-materias" >Materias</a>
                <div class="salir"><a href="../login?sesion=salir">Cerrar sesión</a></div>
            </nav>
            <label for="btn-menu"><i class="bi bi-x-lg"></i></label>
        </div>
    </div>

			<div class="contenedor">
        <!--Main es todo el contenedor de los recuadros de la materia-->
        <div class="mai">
            <form id="examenForm">
                <h2><%= request.getSession().getAttribute("nombrexamen")%></h2>
                <c:forEach items="${questions}" var="question">
                    <c:choose>
                        <c:when test="${question.ques_id == 1 && question.answer_id == 1}">
                            <div class="abierta">
                                <textarea class="pregunta" data-id="${question.ques_id}" data-answer-id="1"  placeholder="Ingresa la pregunta del examen"></textarea>
                            </div>
                        </c:when>
                        <c:when test="${question.ques_id != 1 && question.answer_id == 1}">
                            <div class="abierta">
                                <textarea class="pregunta" data-id="${question.ques_id}" data-answer-id="1" placeholder="Ingresa la pregunta del examen">${question.question}</textarea>
                            </div>
                        </c:when>
                    <c:when test="${question.ques_id >= 2 && question.answer_id >= 2}">
                        <div class="multiple">
                            <textarea class="pregunta" data-id="${question.ques_id}" data-answer-id="${question.answer_id}" placeholder="Ingresa la pregunta del examen">${question.question}</textarea>
                            <c:choose>
                                <c:when test="${empty question.answers}">
                                    <input type="text" class="opcion" data-id="${question.ques_id}" data-answer-id="0" placeholder="Ingresa la opción">
                                    <input type="text" class="opcion" data-id="${question.ques_id}" data-answer-id="0" placeholder="Ingresa la opción">
                                </c:when>
                                <c:when test="${question.answers.size() == 1}">
                                    <c:forEach items="${question.answers}" var="answer">
                                        <input type="text" class="opcion" data-id="${question.ques_id}" data-answer-id="${answer.id_answer}" placeholder="Ingresa la opción" value="${answer.answer}">
                                        <input type="text" class="opcion" data-id="${question.ques_id}" data-answer-id="0" placeholder="Ingresa la opción">
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${question.answers}" var="answer">
                                        <input type="text" class="opcion" data-id="${question.ques_id}" data-answer-id="${answer.id_answer}" placeholder="Ingresa la opción" value="${answer.answer}">
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            <div class="boton-opcion" id="btn-opcion">
                                <label for="btn-opcion" onclick="agregarInput(this)">+</label>
                            </div>
                        </div>
                    </c:when>
                </c:choose>
                </c:forEach>
            </form>
        </div>
            </div>

  <script type="text/javascript" src="../assets/js/agregar.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.20/dist/sweetalert2.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        $(document).ready(function() {
            $(document).on("input", "textarea.pregunta", function() {
                var $multipleDiv = $(this).closest(".multiple");
                var $opcionesInputs = $multipleDiv.find("input.opcion");
                var $btnOpcion = $multipleDiv.find(".boton-opcion label");

                if ($(this).val().trim() === "") {
                    $opcionesInputs.prop("disabled", true);
                    $opcionesInputs.css("background-color", "#CCCCCC");
                    $btnOpcion.addClass("disabled");
                } else {
                    $opcionesInputs.prop("disabled", false);
                    $opcionesInputs.css("background-color", "");
                    $btnOpcion.removeClass("disabled");
                }
            });

            $("textarea.pregunta").trigger("input");
        });
    </script>

    <script>
        document.addEventListener("click", function(event) {
            if (event.target.id === "btn-opcion") {
                agregarInput(event.target);
            }
        });

        function agregarInput(boton) {
            var divMultiple = boton.parentElement.parentElement;
            var ultimosInputs = divMultiple.querySelectorAll('input.opcion');

            if (ultimosInputs.length >= 6) {
                var $btnOpcion = $(boton);
                $btnOpcion.css("background-color", "#CCCCCC");
                $btnOpcion.addClass("disabled");
                $btnOpcion.off("click");
                return;
            }

            var ultimoInput = ultimosInputs[ultimosInputs.length - 1];
            var nuevoInput = document.createElement('input');
            nuevoInput.setAttribute('type', 'text');
            nuevoInput.setAttribute('class', 'opcion');
            nuevoInput.setAttribute('data-id', boton.parentElement.previousElementSibling.dataset.id);
            nuevoInput.setAttribute('data-answer-id', '0');
            nuevoInput.setAttribute('placeholder', 'Ingresa la opción');
            divMultiple.insertBefore(nuevoInput, ultimoInput.nextSibling);
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

        $(document).ready(function() {
            function sendDataToServer(id, answerId, value, element) {
                var dataToSend = {
                    "id": id,
                    "answer_id": answerId,
                    "value": value
                };

                $.ajax({
                    url: "../RegistrarQuestionServlet",
                    method: "POST",
                    data: JSON.stringify(dataToSend),
                    contentType: "application/json",
                    success: function(data) {
                        var newId = data.newId;
                        var newAnswerId = data.newAnswerId;

                        if ($(element).hasClass("pregunta") && id === 2 && answerId === 2) {
                            var $multipleDiv = $(element).closest(".multiple");
                            $multipleDiv.find("textarea.pregunta").data("id", newId).attr("data-id", newId);
                            $multipleDiv.find("input.opcion").each(function(index) {
                                var currentAnswerId = $(this).data("answer-id");
                                $(this).data("id", newId).attr("data-id", newId);
                                if (currentAnswerId === 0) {
                                    $(this).data("answer-id", newAnswerId).attr("data-answer-id", newAnswerId);
                                }
                            });
                        } else {
                            $(element).data("id", newId).attr("data-id", newId);
                            $(element).data("answer-id", newAnswerId).attr("data-answer-id", newAnswerId);
                        }

                    },
                    error: function(xhr, status, error) {
                        console.error("Error en la solicitud AJAX:", status, error);
                    }
                });
            }

            $(document).on("change", "textarea.pregunta, input.opcion", function() {
                var id = $(this).data("id");
                var answerId = $(this).data("answer-id");
                var value = $(this).val();
                sendDataToServer(id, answerId, value, this);
            });
        });
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
                    text: 'Corrobora que tu nombre o apellido esté escrito correctamente.',
                    showConfirmButton: true,
                    confirmButtonColor: '#001256',
                });
                return false;
            }
            if (apellido2.trim() !== '' && !regexNombreApellido.test(apellido2)) {
                Swal.fire({
                    icon: 'error',
                    title: 'Verifica tu información',
                    text: '¡Corrobora que tu apellido esté escrito correctamente!',
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
                            text: 'Comunicate con el administrador para más informacion.',
                            confirmButtonText: 'Aceptar',
                            timer: 5000,
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