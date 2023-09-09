<%-- 
    Document   : principal
    Created on : 14/07/2023, 05:22:13 PM
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" crossorigin="anonymous">
        <title>Menu Principal</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg nvbar-light bg-dark">

            <div class="collapse navbar-collapse d-lg-flex justify-content-between" id="navbarSupportedContent">
                <ul class="navbar-nav">
                    <li class="nav-item active"  name="home">
                        <a style="margin-left: 10px; border: none" class="btn btn-outline-light" aria-current="page" href="Controlador?menu=Home&codEmp=${usuario.getCodigoEmpleado()}" target="myFrame">Home</a>
                    </li>
                    <li class="nav-item" name="pruducto">
                        <a style="margin-left: 10px; border: none" class="btn btn-outline-light" class="nav-link" href="Controlador?menu=Producto&accion=listar" target="myFrame">Producto</a>
                    </li>
                    <li class="nav-item"  name="empleado">
                        <a style="margin-left: 10px; border: none" class="btn btn-outline-light" class="nav-link" href="Controlador?menu=Empleado&accion=listar"  target="myFrame">Empleado</a>
                    </li>
                    <li class="nav-item"  name="cliente">
                        <a style="margin-left: 10px; border: none" class="btn btn-outline-light" class="nav-link" href="Controlador?menu=Cliente&accion=listar" target="myFrame">Cliente</a>
                    </li>
                    <li class="nav-item"  name="ventas">
                        <a style="margin-left: 10px; border: none" class="btn btn-outline-light" class="nav-link" href="Controlador?menu=RegistrarVenta&accion=dafault" target="myFrame">Registrar venta</a>
                    </li>
                </ul>
            </div>

            <div style="border: 1px; padding: 10px; position: relative">

                <svg id="carrito" xmlns="http://www.w3.org/2000/svg" height="1.7em" viewBox="0 0 576 512" fill="white">
                <path d="M0 24C0 10.7 10.7 0 24 0H69.5c22 0 41.5 12.8 50.6 32h411c26.3 0 45.5 
                      25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3H170.7l5.4 28.5c2.2 11.3 
                      12.1 19.5 23.6 19.5H488c13.3 0 24 10.7 24 24s-10.7 24-24 24H199.7c-34.6 
                      0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5H24C10.7 48 0 37.3 0 
                      24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 
                      48 0 1 1 0-96z"/>
                </svg>
                <div style="position: absolute; background-color:  #ffcc33; color: #000; width: 18px; height: 18px; display: flex; align-items: center; justify-content: center; border-radius: 50%; top: 50%; right: 0" >
                    
                    <span>0</span>
                </div>
            </div>


            <div class="dropdown">
                <button style="border: none"  class="btn btn-outline-light dropdown-toggle" type="button" id="dropDownMenuButton" data-toggle="dropdown" aria-expanded="true">
                    ${usuario.getNombresEmpleado()}
                </button>
                <div class="dropdown-menu text-center"arail-labellebdy="dropDownMenuButton" >
                    <a class="dropdown-item" href="#">
                        <img id="usuarioImg" src="" alt="" width="60" style=" border-radius: 50%; overflow: hidden;">
                    </a>    
                    <a class="dropdown-item" href="#">${usuario.getUsuario()} </a>
                    <a class="dropdown-item" href="#">${usuario.getUsuario()}@kinal.edu.gt</a>

                    <form action="Validar" method="POST">
                        <button name="accion" name="Salir" class="dropdown-item" href="#">Salir</button>
                    </form>

                </div>    
            </div>
        </nav>
           
                    
                    
        <div class="m-4" style="height: calc(100vh - 100px) ">

            <iframe name="myFrame" style="height: 100%; width: 100%; border:none"></iframe>

        </div>


        <script>
            // referencia a la imagen para setearla
            var uImg = document.getElementById("usuarioImg");
            // obteniendo codigo de usuario
            var uId = ${usuario.getCodigoEmpleado()};
            // Obtén una referencia al elemento SVG por su ID
            var svgElement = document.getElementById("carrito");


            // Agrega un evento de click al elemento SVG
            svgElement.addEventListener("click", function () {
                // Obtiene una referencia al iframe por su nombre
                var iframe = window.frames["myFrame"];

                // Carga "carrito.jsp" en el iframe
                iframe.location.href = "Controlador?menu=Carrito";
            });

            //setear imagenes segun el codigo de cada usuario
            switch (uId) {
                case 1:
                    uImg.src = "img/usuario1.png";
                    break;
                case 2:
                    uImg.src = "img/usuario2.png";
                    break;
                case 4:
                    uImg.src = "img/usuario4.jpeg";
                    break;
                default:
                    uImg.src = "img/default.png";
                    break;
            }

            
                   
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>   
    </body>
</html>
