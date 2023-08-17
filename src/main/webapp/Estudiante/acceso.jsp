<%@ page import="mx.edu.utez.exameneslinea.model.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="../assets/img/sugel.png" type="image/png">
	<title>Bienvenido</title>
	 <link rel="stylesheet" type="text/css" href="./../assets/css/estiloHeader/header.css">
	 <link rel="stylesheet" type="text/css" href="./../assets/css/estudiante/acceso.css">
	 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">
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
			<img src="../assets/img/sugel.png" alt="Logo">
		</div>
	</div>
</header>

	<input type="checkbox" id="btn-menu">
	<div class="container-menu">
		<div class="cont-menu">
			<center><div class="perfil"><i class="bi bi-person-heart"></i><br>
				<h4><%= ((Person) request.getSession().getAttribute("sesion")).getName() %></h4></div></center>
			<nav>
				<div class="min-menA">
					<a href="../docente/historial-estudiante">Historial</a>
				</div>
				<div class="salir"><a href="../login?sesion=salir">Cerrar sesión</a></div>
			</nav>
			<label for="btn-menu"><i class="bi bi-x-lg"></i></label>
		</div>
	</div>

	<div class="hexagon-container">
    <div class="hexagon hexagon-top-left"></div>
    <div class="hexagon hexagon-bottom-right"></div>
  </div>

  <div class="box">
 			<form action="../ques_reload" method="post">
 				<h2>¡Hola <%= ((Person) request.getSession().getAttribute("sesion")).getName()%>!</h2>
 				<h3>Ingresa el código de acceso al examen</h3>
 				<img src="../assets/img/docente.svg">
				<div class="inputbox">
					<input type="text" name="codigo" id="codigo" required="">
					<span>Código</span>
					<i></i>
				</div>
				<input type="submit" name="acceso" id="acceso" value="Acceder">
 			</form>
  </div>

	<script src="./../assets/css/js/bootstrap.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.js"></script>
	<script>
	<%String mensaje = (String) request.getSession().getAttribute("mensaje");
		if (mensaje != null && !mensaje.isEmpty()) {
			switch (mensaje) {
				case "exito":
	%>
		Swal.fire({
			title: '¡Tus respuestas se han enviado con éxito!',
			icon: 'success',
			confirmButtonColor: '#001256',
			confirmButtonText: 'OK',
			timer: 4000,
		});
		<%break;case "desactivado": %>
		Swal.fire({
			icon: 'question',
			title: 'Oops...',
			text: '¡El examen ha sido desactivado!',
			confirmButtonColor: '#001256',
			confirmButtonText: 'OK',
			timer: 4000,
		});
		<%break;case "noencontrado": %>
		Swal.fire({
			icon: 'error',
			title: 'Oops...',
			text: 'Código de examen no valido, intenta de nuevo!',
			confirmButtonColor: '#001256',
			confirmButtonText: 'OK',
			timer: 4000,
		});
		<%break;case "completado": %>
		Swal.fire({
			icon: 'info',
			title: '¡Ya has respondido este examen!',
			confirmButtonColor: '#001256',
			confirmButtonText: 'OK',
			timer: 4000,
		});
	<%break;} request.getSession().removeAttribute("mensaje");}%>
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