<%@ page import="mx.edu.utez.exameneslinea.model.Person" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="../assets/img/sugel.png" type="image/png">
    <title></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/estiloHeader/admin.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="../assets/css/admin/gestion.css">
</head>
<style type="text/css">
    input[name="matricula"] {
        display: none;
    }
</style>

<body>
<!-- Registro de usuarios -->
<div class="overlay" id="overlay">
    <div class="pop-up" id="pop-up">
        <a href="#" id="btn-cerrar" class="btn-cerrar"><i class="bi bi-x-lg"></i></a>
        <h2 class="equipo">Registro de usuarios</h2>
        <form method="post" action="../admin/registro-user">
            <input type="text" name="nombre" placeholder="Nombres*" required="" maxlength="45">
            <input type="text" name="apellido1" placeholder="Apellido paterno*" required="" maxlength="30">
            <input type="text" name="apellido2" placeholder="Apellido materno" maxlength="30" >
            <input type="text" name="CURP" placeholder="CURP*" required="" maxlength="18" oninput="convertirMayusculas(this)" >
            <input type="email" name="correo" placeholder="correo@institucional*" required value="@utez.edu.mx" maxlength="45" oninput="convertirMinusculas(this)">
            <label for="rol">Selecciona el rol del nuevo usuario:</label><br>
            <select name="rol" id="rol" onchange="mostrarOcultarMatricula()" required="">
                <option value="">Seleccione un Rol*</option>
                <option value="estudiante">Estudiante</option>
                <option value="docente">Docente</option>
            </select>
            <input type="text" name="matricula" placeholder="Matricula*" maxlength="11"  oninput="convertirMinusculas(this)">
            <br><input type="submit" value="Agregar" onclick="validarFormulario(event)">
        </form>
    </div>
</div>

<!-- Termina el registro de usuarios -->

<!-- Formulario para modificar un usuario -->
<input type="checkbox" id="btn-modal">
<div class="container-modal">
    <div class="content-modal">
        <h2 id="nombreuser"></h2>
        <form action="../admin/actualizar-user" method="POST" id="formulario-modal" onsubmit="return validarFormularioUpdate()">
            <input type="hidden" name="id_user" id="id_user" value="">
            <label>Nombres*:</label>
            <input type="text" name="nombre" id="nombre" maxlength="45" required="">
            <label>Apellido paterno*:</label>
            <input type="text" name="ap1" id="ap1" maxlength="30" required="">
            <label>Apellido materno:</label>
            <input type="text" name="ape2" id="ape2" maxlength="30">
            <label>CURP*:</label>
            <input type="text" name="CURP" id="curp" maxlength="18" required="" oninput="convertirMayusculas(this)">
            <label>Correo*:</label>
            <input type="email" name="correo" placeholder="correo@institucional" required="" id="email" maxlength="45" oninput="convertirMinusculas(this)">
            <label for="user">Usuario*:</label>
            <input type="text" name="usuario" id="user" maxlength="30" required="">
            <label>Actualizar contraseña:</label>
            <input type="text" name="pass" id="pass" value=""  maxlength="30">
            <br><input type="submit" name="" value="Modificar" id="btn-enviar">
        </form>
        <div class="btn-cerrar">
            <label for="btn-modal">Cancelar</label>
        </div>
    </div>
</div>

<!-- Formulario para modificar un usuario -->

<div class="background"></div>
<header class="header">
    <div class="container">
        <div class="btn-menu">
            <label for="btn-menu">☰</label>
        </div>
        <div class="logo"></div>
        <div class="menu">
            <img src="../assets/img/sugel.png" alt="Logo">
        </div>
    </div>
</header>

<input type="checkbox" id="btn-menu">
<div class="container-menu">
    <div class="cont-menu">
        <center>
            <div class="perfil">
                <i class="bi bi-person-circle"></i><br>
                <h4>Admin</h4>
                <h4><%= ((Person) request.getSession().getAttribute("sesion")).getName() %></h4>
            </div>
        </center>

        <nav>
            <a href="#btn-modal"  class="editar-usuario" id="btn-abre" onclick="cargarDatosUsuario(<%= ((Person) request.getSession().getAttribute("sesion")).getID_user() %>)">Editar Perfil</a>
            <c:choose>
                <c:when test="${personType == 'docente'}">
                    <a href="../admin/gestion-docente-alumno?id=docente"><strong>Gestionar docentes</strong></a>
                </c:when>
                <c:otherwise>
                    <a href="../admin/gestion-docente-alumno?id=docente">Gestionar docentes</a>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${personType == 'estudiante'}">
                    <a href="../admin/gestion-docente-alumno?id=estudiante"><strong>Gestionar estudiantes</strong></a>
                </c:when>
                <c:otherwise>
                    <a href="../admin/gestion-docente-alumno?id=estudiante">Gestionar estudiantes</a>
                </c:otherwise>
            </c:choose>
            <div class="min-menA">
                <a href="#"  class="btn-abrir" id="btn-abrir" for="btn-menu">Agregar usuario</a>
            </div>
            <div class="salir">
                <a href="../login?sesion=salir">Cerrar sesión</a>
            </div>
        </nav>
        <label for="btn-menu"><i class="bi bi-x-lg"></i></label>
    </div>
</div>

<div class="contenedor">
    <div class="acciones">
        <h1>Gestión de usuarios</h1>
        <table>
            <thead>
            <tr>
                <td colspan="4">
                    <c:choose>
                        <c:when test="${personType == 'docente'}">Docentes</c:when>
                        <c:when test="${personType == 'estudiante'}">Estudiantes</c:when>
                        <c:otherwise>Usuario</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${personList}" var="person">
                <tr>
                    <td>
                        <label class="switchBtn">
                            <input type="checkbox" id="toggleSwitch_${person.id_person}" ${person.user_status == 1 ? 'checked' : ''} onChange="updateUserStatus(${person.id_person})">
                            <div class="slide round" id="toggleText_${person.id_person}"></div>
                        </label>
                    </td>
                    <td colspan="2" id="">${person.lastname1} ${person.lastname2} ${person.name}</td>
                    <td>
                        <div class="boton-modal">
                            <label for="btn-modal" class="editar-usuario" onclick="cargarDatosUsuario(${person.id_person})">
                                Editar
                            </label>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript" src="../assets/js/agregar.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.7/dist/sweetalert2.min.js"></script>

<script>
    <% List<String> mensaje = (List<String>) request.getSession().getAttribute("statusNewUser");
        String user = (String) request.getSession().getAttribute("newuser");
        String updateuser = (String) request.getSession().getAttribute("update");

       if (mensaje != null) {
           String duplicado = "";
       for (String dup: mensaje) {
           duplicado = duplicado + dup +", ";
       }
       %>
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: 'Este <%=duplicado%> se encuetra registrado en otra cuenta',
        timer: 5000,
    });
    <% }else if(user!= null){%>
    Swal.fire({
        icon: 'success',
        title: 'Nuevo Usuario <%=user%>',
        text: 'Usuario registrado con éxito',
        timer: 5000,
    });
    <%}else if(updateuser != null){%>
    Swal.fire({
        icon: 'success',
        title: 'Usuario actualizado con éxito',
        timer: 3000,
    });
    <%}request.getSession().removeAttribute("statusNewUser");
    request.getSession().removeAttribute("newuser");
    request.getSession().removeAttribute("update");%>

</script>

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
                    email: datosUsuario[4].trim(),
                    user: datosUsuario[5].trim(),
                    rol: datosUsuario[6].trim(),
                    id: datosUsuario[7].trim(),
                };
                $("#id_user").val(usuario.id);
                if(usuario.rol ===  "1"){
                    $("#nombreuser").text('Administrador ' + usuario.name);
                }else if(usuario.rol ===  "2"){
                    $("#nombreuser").text('Docente ' + usuario.name);
                }else{
                    $("#nombreuser").text('Estudiante ' + usuario.name);
                }
                $("#nombre").val(usuario.name);
                $("#ap1").val(usuario.lastname1);
                $("#ape2").val(usuario.lastname2);
                $("#curp").val(usuario.curp);
                $("#email").val(usuario.email);
                $("#user").val(usuario.user);

                var userLabel = $('label[for="user"]');
                if (usuario.rol === "3") {
                    userLabel.text("Usuario/Matricula*:");
                } else {
                    userLabel.text("Usuario*:");
                }

                document.getElementById("btn-modal").checked = true;

            },
            error: function() {
                console.log("Error en la solicitud Ajax.");
            }
        });
    }
</script>

<script type="text/javascript">
    function convertirMayusculas(element) {
        element.value = element.value.toUpperCase();
    }
    function convertirMinusculas(element) {
        element.value = element.value.toLowerCase();
    }

    function mostrarOcultarMatricula() {
        var rol = $('#rol').val();
        var matriculaInput = $('input[name="matricula"]');
        if (rol === 'estudiante') {
            matriculaInput.prop('required', true);
            matriculaInput.show();
        } else {
            matriculaInput.prop('required', false);
            matriculaInput.val('');
            matriculaInput.hide();
        }
    }
</script>


<script>
    function updateUserStatus(personId) {
        var checkbox = document.getElementById("toggleSwitch_" + personId);
        var estado = checkbox.checked ? 1 : 0;
        var action = estado === 0 ? 'desactivar' : 'activar';
        var actionText = '';

        switch (action) {
            case 'desactivar':
                actionText = 'Esta acción le impedirá al usuario acceder al sistema';
                break;
            case 'activar':
                actionText = 'Esta acción le permitirá al usuario acceder al sistema';
                break;
            }

        Swal.fire({
            icon: 'warning',
            title: '¿Estás seguro de ' + action + ' este usuario?',
            text: actionText,
            showCancelButton: true,
            confirmButtonColor: '#001256',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Aceptar',
            cancelButtonText: 'Cancelar',
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: "POST",
                    url: "../admin/cambio-status",
                    data: { personId: personId, estado: estado },
                    success: function (data) {
                        console.log(data);
                        Swal.fire({
                            icon: 'success',
                            title: 'Cambios guardados',
                            showConfirmButton: false,
                            timer: 3000,
                            confirmButtonColor: '#001256',
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
</script>

<script>
    function validarFormulario(event) {
        event.preventDefault();

        const nombre = document.querySelector('input[name="nombre"]').value;
        const apellido1 = document.querySelector('input[name="apellido1"]').value;
        const apellido2 = document.querySelector('input[name="apellido2"]').value;
        const CURP = document.querySelector('input[name="CURP"]').value;
        const correo = document.querySelector('input[name="correo"]').value;
        const rol = document.querySelector('#rol').value;
        const matricula = document.querySelector('input[name="matricula"]').value;

        const regexNombre = /^[A-ZÁÉÍÓÚÑ][a-záéíóúüñ]*( [A-ZÁÉÍÓÚÑ][a-záéíóúüñ]*)*$/;
        if (!regexNombre.test(nombre) || !regexNombre.test(apellido1) || (apellido2 && !regexNombre.test(apellido2))) {
            Swal.fire({
                icon: 'error',
                title: 'Verifica tu información',
                text: 'Corrobora tu nombre o apellidos esté escrito correctamen',
                showConfirmButton: true,
                timer: 5000,
                confirmButtonColor: '#001256',
            });
            return false;
        }

        const regexCURP = /^[A-Za-z0-9]+$/;
        if (CURP.length !== 18  || !regexCURP.test(CURP)) {
            Swal.fire({
                icon: 'error',
                title: 'Verifica tu información',
                text: 'CURP no válida',
                showConfirmButton: true,
                timer: 5000,
                confirmButtonColor: '#001256',
            });
            return false;
        }

        if (!correo.endsWith('@utez.edu.mx') || correo.split('@')[0] === '') {
            Swal.fire({
                icon: 'error',
                title: 'Verifica tu información',
                text: 'Solo se admiten correos XXXXXXXX@utez.edu.mx',
                showConfirmButton: true,
                timer: 5000,
                confirmButtonColor: '#001256',

            });
            return false;
        }

        if (rol === '') {
            Swal.fire({
                icon: 'error',
                title: 'Rol',
                text: 'Selecciona un rol',
                showConfirmButton: true,
                timer: 5000,
                confirmButtonColor: '#001256',
            });
            return false;
        }

        if (rol === 'estudiante') {
            if (matricula.trim() === '') {
                Swal.fire({
                    icon: 'error',
                    title: 'Verifica tu información',
                    text: 'Matrícula no válida',
                    showConfirmButton: true,
                    timer: 5000,
                    confirmButtonColor: '#001256',
                });
                return false;
            }
            const matriculaPart = correo.split('@')[0];
            if (matricula !== matriculaPart) {
                Swal.fire({
                    icon: 'error',
                    title: 'Verifica tu información',
                    text: 'La matrícula no coincide con tu correo',
                    showConfirmButton: true,
                    timer: 5000,
                    confirmButtonColor: '#001256',
                });
                return false;
            }
        }
        event.target.form.submit();
    }
</script>
<script type="text/javascript">
    function validarFormularioUpdate() {
        const nombre = document.getElementById('nombre').value.trim();
        const apellido1 = document.getElementById('ap1').value.trim();
        const apellido2 = document.getElementById('ape2').value.trim();
        const curp = document.getElementById('curp').value.trim();
        const correo = document.getElementById('email').value.trim();
        const usuario = document.getElementById('user').value.trim();
        const contrasena = document.getElementById('pass').value.trim();

        const btnEnviar = document.getElementById('btn-enviar');

        btnEnviar.addEventListener('click', () => {
            document.getElementById("btn-modal").checked = true;
        });

        const regexNombre = /^[A-ZÁÉÍÓÚÑ][a-záéíóúüñ]*( [A-ZÁÉÍÓÚÑ][a-záéíóúüñ]*)*$/;
        if (!regexNombre.test(nombre) || !regexNombre.test(apellido1) || (apellido2 && !regexNombre.test(apellido2))) {
            Swal.fire({
                icon: 'error',
                title: 'Verifica tu información',
                text: 'Corrobora tu nombre',
                showConfirmButton: true,
                timer: 6000,
                confirmButtonColor: '#001256',
            });
            return false;
        }

        const regexCURP = /^[A-Za-z0-9]+$/;
        if (curp.length !== 18  || !regexCURP.test(curp)) {
            Swal.fire({
                icon: 'error',
                title: 'Verifica tu información',
                text: 'CURP no válida',
                showConfirmButton: true,
                timer: 6000,
                confirmButtonColor: '#001256',
            });
            return false;
        }

        if (!correo.endsWith('@utez.edu.mx') || correo.split('@')[0] === '') {
            Swal.fire({
                icon: 'error',
                title: 'Verifica tu información',
                text: 'Solo se admiten correos XXXXXXXX@utez.edu.mx',
                showConfirmButton: true,
                timer: 6000,
                confirmButtonColor: '#001256',
            });
            return false;
        }

        if (!correo.endsWith('@utez.edu.mx')) {
            Swal.fire({
                icon: 'error',
                title: 'Verifica tu información',
                text: 'Solo se admiten correos XXXXXXXX@utez.edu.mx',
                showConfirmButton: true,
                timer: 6000,
                confirmButtonColor: '#001256',
            });
            return false;
        }

        if (!usuario.match(/^[A-Za-z0-9_áéíóúÁÉÍÓÚñÑ]+$/)) {
            Swal.fire({
                icon: 'error',
                title: 'Verifica tu información',
                text: 'Por favor ingrese un usuario válido',
                showConfirmButton: true,
                timer: 6000,
                confirmButtonColor: '#001256',
            });
            return false;
        }

        if (contrasena && (contrasena.length < 3 || contrasena.length > 20)) {
            Swal.fire({
                icon: 'error',
                title: 'Verifica tu información',
                text: 'La nueva contraseña debe tener entre 3 y 20 caracteres.',
                showConfirmButton: true,
                timer: 6000,
                confirmButtonColor: '#001256',
            });
            return false;
        }
        Swal.fire({
            icon: 'warning',
            title: '¿Estás seguro de modificar este usuario?',
            text: 'Esta acción modificará los datos del usuario',
            showCancelButton: true,
            confirmButtonText: 'Aceptar',
            cancelButtonText: 'Cancelar',
            confirmButtonColor: '#001256',
            cancelButtonColor: '#d33',
            trimer: 8000,
        }).then((result) => {
            if (result.isConfirmed) {
                btnEnviar.addEventListener('click', () => {
                    document.getElementById("btn-modal").checked = false;
                });
                document.getElementById('formulario-modal').submit();
            }
        });
        return false;

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
