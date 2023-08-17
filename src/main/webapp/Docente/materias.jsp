<%@ page import="mx.edu.utez.exameneslinea.model.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="../assets/img/sugel.png" type="image/png">
    <title>Materias</title>
	<link rel="stylesheet" type="text/css" href="../assets/css/estiloHeader/header.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" type="text/css" href="../assets/css/docente/materias.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">

</head>

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
      <div class="min-menA">
			<a href="#" class="btn-abrir" id="btn-abrir" onclick="cargarDatosUsuario(<%= ((Person) request.getSession().getAttribute("sesion")).getId_person()%>)">Editar perfil</a>
		</div>
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
          <h2 class="equipo">Registro de materia</h2>
            <form accept="" method="post" action="../docente/resgitra-materia">
                <input type="text" name="nombre" placeholder="Nombre de la materia*" required="" maxlength="50" pattern="[A-Za-zÁÉÍÓÚáéíóúüÜñÑ ]*">
              <div class="g">
                <label for="grado">Grado*:</label>
              <input type="number" name="grado" id="grado" required="" max="12" min="1">
              <label for="grupo">Grupo*:</label>
              <input type="text" name="grupo" id="grupo" required="" pattern="[A-Z]" oninput="convertirMayusculas(this)" maxlength="1" minlength="1">
              </div>
              <input type="submit" name="" value="Agregar">
            </form>
        <div class="btn-cerrar">
          <label for="btn-modal">Cancelar</label>
        </div>
      </div>
    </div>

    <!--TERMINA LA 1° MODIFICACION-->

<!--Comienza el contenido principal-->
			<div class="contenedor">
        <!--Main es todo el contenedor de los recuadros de la materia-->
                <div class="main">
                    <c:forEach items="${subjectlista}" var="materia">
                        <!-- materia es el contedor completo de la materia y todo el recuadro es a su vez un enlace a ver los examenes de esa materia-->
                        <div class="materia">
                            <label class="switchBtn">
                                <input type="checkbox" id="toggleSwitch_${materia.id_sub}" ${materia.statusub == 1 ? 'checked' : ''} onChange="updatesubject(${materia.id_sub})">
                                <div class="slide round" id="toggleText${materia.id_sub}"></div>
                            </label>
                            <div class="img">
                                <img src="" class="materiaImg">
                            </div>
                            <a href="#" id="link_${materia.id_sub}" onclick="checkAccess(${materia.id_sub});">
                            <div class="info">
                                    <h2>${materia.subname}</h2>
                                    <h3>${materia.grade} ° ${materia.grouSub}</h3>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
                <!--2° MODIFICACIÓN-->
                <div class="boton-modal">
                    <label for="btn-modal">
                        +
                    </label>
                </div>
                <!-- ULTIMA-->

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.js"></script>
	<script type="text/javascript" src="../assets/js/agregar.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        <%String mensaje = (String) request.getSession().getAttribute("subcreate");
            if (mensaje != null && !mensaje.isEmpty()) {
                switch (mensaje) {
                    case "creada":
        %>
        Swal.fire({
            title: '¡Materia creada con exito!',
            icon: 'success',
            confirmButtonColor: '#001256',
            confirmButtonText: 'OK',
            timer: 3000,
        });
        <%break;case "nocreada": %>
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: '!Ya cuentas con una materia con la misma información!',
            confirmButtonColor: '#001256',
            confirmButtonText: 'OK',
            timer: 5000,
        });
        <%break;case "cambios": %>
        Swal.fire({
            icon: 'success',
            title: 'Se han actualizado correctamente tus datos',
            confirmButtonColor: '#001256',
            confirmButtonText: 'OK',
            timer: 3000,
        });
        <%break;} request.getSession().removeAttribute("subcreate");}%>
    </script>

    <script>
        function convertirMayusculas(element) {
            element.value = element.value.toUpperCase();
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
    </script>

    <script>
        const materias = document.querySelectorAll('.materia');

        const imagenesDisponibles = [
            'class.svg',
            'estudiantes.svg',
            'profesores.svg',
            'usD.svg',
            'usE.svg',
            'docente.svg'
        ];

        function getRandomIndex() {
            return Math.floor(Math.random() * imagenesDisponibles.length);
        }

        function updateImageAndStyles(materiaDiv, isChecked) {
            const materiaImg = materiaDiv.querySelector('.materiaImg');

            if (isChecked) {
                const randomIndex = getRandomIndex();
                materiaDiv.classList.remove('disabled');
                materiaImg.src = `../assets/img/`+imagenesDisponibles[randomIndex];
            } else {
                materiaDiv.classList.add('disabled');
                materiaImg.src = '../assets/img/desactivada.svg';
            }
        }

        materias.forEach((materia) => {
            const checkbox = materia.querySelector('input[type="checkbox"]');
            checkbox.addEventListener('change', () => {
                updatesubject(checkbox, materia);
            });
            updateImageAndStyles(materia, checkbox.checked);
        });

        function updatesubject(checkbox, materiaDiv) {
            var subid = checkbox.id.split('_')[1];
            var estado = checkbox.checked ? 1 : 0;
            var action = estado === 0 ? 'desactivar' : 'activar';
            var actionText = '';

            switch (action) {
                case 'desactivar':
                    actionText = 'Esta acción impedirá el acceso a todo el contenido de la materia';
                    break;
                case 'activar':
                    actionText = 'Esta acción te permitirá el acceso al contenido de la materia';
                    break;
            }

            Swal.fire({
                icon: 'warning',
                title: '¿Estás seguro de ' + action + ' esta Materia?',
                text: actionText,
                showCancelButton: true,
                confirmButtonColor: '#001256',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Aceptar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: "../docente/cambio-status-sub",
                        data: { subid: subid, estado: estado },
                        success: function (data) {
                            console.log(data);
                            updateImageAndStyles(materiaDiv, checkbox.checked);
                            Swal.fire({
                                icon: 'success',
                                title: 'Cambios guardados',
                                showConfirmButton: false,
                                timer: 2000,
                            });
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
                } else {
                    checkbox.checked = !estado;
                }
            });
        }


        function checkAccess(id) {
            const toggleChecked = document.getElementById(`toggleSwitch_`+id).checked;

            if (!toggleChecked) {
                Swal.fire({
                    icon: 'error',
                    title: 'Acceso denegado',
                    text: 'Para acceder al contenido, la materia debe estar activada',
                });
            } else {
                window.location.href = "../docente/buscar-examenes?materiaId="+id;
            }
        }



        const contentElement = document.querySelector('.main');


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


            const imageElement = document.createElement('img');
            imageElement.src = '../assets/img/vaciom.svg';
            emptyContentContainer.appendChild(imageElement);


            const textElement = document.createElement('h2');
            textElement.textContent = 'Aún no hay materias registradas';
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
                    title: 'Verifica tu informacion',
                    text: 'Corrobora que tu nombre y apellido esté escrito correctamente.',
                    confirmButtonColor: '#001256',
                    showConfirmButton: true,
                });
                return false;
            }
            if (apellido2.trim() !== '' && !regexNombreApellido.test(apellido2)) {
                Swal.fire({
                    icon: 'error',
                    title: 'Verifica tu información',
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
                            text: 'Comunicate con el administrador para más información.',
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
    </script>

    <SCRIPT>
        function verificarConexion() {
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
        }
        setInterval(verificarConexion, 1000);
    </SCRIPT>







</body>
</html>