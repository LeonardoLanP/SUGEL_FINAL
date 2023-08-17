<%@ page import="mx.edu.utez.exameneslinea.model.Exam" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="../assets/img/sugel.png" type="image/png">
	<title>Examen</title>
	<link rel="stylesheet" type="text/css" href="../assets/css/estiloHeader/header.css">
	<link rel="stylesheet" type="text/css" href="../assets/css/estudiante/examen.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">
</head>
<body>
	
	<div class="background">
	</div>
		<header class="header">
    <div class="container">
      <div class="logo">
      </div>
      
      <div class="menu">
        <img src="../assets/img/sugel.png" alt="Logo">
      </div>
    </div>
  </header>
	<div class="contenedor">
		<h1><%= ((Exam) request.getSession().getAttribute("subject")).getNamexSub()%></h1>
		<h1><%= ((Exam) request.getSession().getAttribute("subject")).getNamex() %></h1>
		<form id="examen" action="../examen/enviar-Respuesta" method="post">
			<c:forEach items="${quests}" var="pregunta">
				<c:choose>
					<c:when test="${pregunta.answer_id == 1}">
						<div class="pregunta">
							<label id="${pregunta.ques_id}">${pregunta.question}</label>
							<div class="respuesta-text">
                        <textarea name="respuesta-t" cols="30" rows="5" class="pregunta" data-id="${pregunta.ques_id}"
								  data-answer-id="${pregunta.id_exam_question}" placeholder="Ingresa tu respuesta. . .">${pregunta.open_Answer}</textarea>
							</div>
						</div>
					</c:when>
					<c:when test="${pregunta.answer_id >= 2}">
						<div class="pregunta">
							<label>${pregunta.question}</label>
							<c:forEach items="${pregunta.answers}" var="answer">
								<div class="respuesta-radio">
									<input type="radio" name="${pregunta.id_exam_question}" id="${answer.id_answer}" class="respuesta"
									<c:if test="${answer.id_answer eq pregunta.answer_id}">
										   checked
									</c:if>>
									<label for="${answer.id_answer}">${answer.answer}</label>
								</div>
							</c:forEach>
						</div>
					</c:when>
				</c:choose>
			</c:forEach>

			<center><input type="submit" value="Finalizar examen" id="btnEnviar"></center>
		</form>
			</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.js"></script>
	<script>
	<%String mensaje = (String) request.getSession().getAttribute("inconcluso");
		if (mensaje != null && !mensaje.isEmpty()) {%>
	Swal.fire({
	icon: 'warning',
	title: 'Se ha retomado el curso de tu examen',
	text: 'Se seguirá retomando hasta que se concluya o sea desactivado',
	timer: 5000,
	confirmButtonColor: '#001256',
	});
	<% } request.getSession().removeAttribute("inconcluso");%>
</script>

	<script type="text/javascript">
		$(document).ready(function() {
			function sendDataToServer(id, answerId, value, element) {
				var dataToSend = {
					"ques_id": id,
					"answer_id": answerId,
					"open_Answer": value
				};
				$.ajax({
					url: "../examen/Registrar-Respuestas",
					method: "POST",
					data: JSON.stringify(dataToSend),
					contentType: "application/json",
					success: function(data) {
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
		document.addEventListener('DOMContentLoaded', function() {
		$(document).ready(function () {
			$(".respuesta-radio").on("click", function () {
				const id_exam_ques = $(this).find("input").attr("name");
				const id_answer = $(this).find("input").attr("id");
				actualizarRespuesta(id_exam_ques, id_answer);
			});
		});
		});
		function actualizarRespuesta(id_exam_ques, id_answer) {
			$.ajax({
				type: "POST",
				url: "../examen/cabio-respuestas",
				data: {
					id_exam_ques: id_exam_ques,
					id_answer: id_answer
				},
				success: function (response) {
				},
				error: function (xhr, status, error) {
					console.error("Error en la solicitud AJAX:", error);
				}
			});
		}
	</script>

	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
		$(document).ready(function () {

			$(".respuesta-radio").on("click", function () {
				const radio = $(this).find(".respuesta");
				radio.prop("checked", true);
				actualizarEstilosRespuestas();
			});
		});
		});

		function actualizarEstilosRespuestas() {
			$(".respuesta-radio").each(function () {
				const radio = $(this).find(".respuesta");
				const label = $(this).find("label");
				if (radio.prop("checked")) {
					label.css({
						backgroundColor: 'transparent',
						content: 'o',
						marginRight: '10px',
						borderRadius: '50%'
					});
				} else {
					label.css({
						backgroundColor: '',
						color: '',
						content: '',
						fontSize: '',
						textAlign: '',
						lineHeight: '',
						width: '',
						height: '',
						marginRight: '',
						borderRadius: ''
					});
				}
			});
		}
	</script>

	<script>
		document.addEventListener('DOMContentLoaded', function() {
		document.getElementById('btnEnviar').addEventListener('click', function (event) {
			event.preventDefault();
			mostrarConfirmacion();
		});
		});
		function mostrarConfirmacion() {
			Swal.fire({
				title: '¿Estás seguro?',
				text: '¿Deseas finalizar el examen?',
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#001256',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Sí, finalizar',
				cancelButtonText: 'Cancelar'
			}).then((result) => {
				if (result.isConfirmed) {
					document.getElementById('examen').submit();
				}
			});
		}
	</script>

	<script>
		var alertaMostrada = false;

		function verificarEstadoUsuario() {
			if (alertaMostrada) {
				return;
			}

			$.ajax({
				url: '../admin/verificar-estado-usuario',
				method: 'GET',
				dataType: 'json',
				success: function(response) {
					if (response.usuarioActivo) {
						alertaMostrada = true;
						Swal.fire({
							icon: 'warning',
							title: 'Tu cuenta ha sido desactivada',
							text: 'Comunícate con el administrador para más información',
							confirmButtonText: 'Aceptar',
							confirmButtonColor: '#001256',
							timer: 7000,
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

		function verificarEstadoExamen() {
			if (alertaMostrada) {
				return;
			}

			$.ajax({
				url: '../docente/verificar-estado-examen',
				method: 'GET',
				dataType: 'json',
				success: function(response) {
					if (response.usuarioActivo) {
						alertaMostrada = true;
						Swal.fire({
							icon: 'warning',
							title: 'El examen ha sido desactivado',
							text: 'Comunícate con el docente para más información',
							confirmButtonText: 'Aceptar',
							confirmButtonColor: '#001256',
							timer: 7000,
						}).then(function() {
							setTimeout(function() {
								window.location.href = "acceso.jsp";
							}, 1000);
						});
					}
				},
				error: function() {
					console.log("Error al verificar el estado del usuario.");
				}
			});
		}
		setInterval(verificarEstadoExamen, 1000);

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