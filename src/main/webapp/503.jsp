<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="icon" href="assets/img/sugel.png" type="image/png">
    <link rel="stylesheet" type="text/css" href="assets/css/estiloHeader/header.css">
     <link rel="stylesheet" type="text/css" href="assets/css/estiloLogin/login.css">
    <title>Oops!</title>
</head>

<body>

 <header class="header">
    <div class="container">
    
      <div class="logo">
      </div>
      
      <div class="menu">
        <img src="assets/img/sugel.png" alt="Logo">
      </div>
    </div>
  </header>
  <div class="capa"></div>



    <div class="hero">
      <div class="hero-bg">
        <div class="bg"></div>
        <div class="bg bg2"></div>
        <div class="bg bg3"></div>
      </div>
      <div class="hero-text">
      
      <img src="assets/img/503.svg">

        <h2>¡Oops!</h2><br>
        <button id="btn-regresar">Regresar</button>
     </div>
   
  </div>
 
  <script src="assets/js/bootstrap.js"></script>
  <script>
      const btnRegresar = document.getElementById('btn-regresar');

      btnRegresar.addEventListener('click', function() {
          window.location.href = 'index.jsp';
      });
  </script>
</body>
</html>
