<%-- 
    Document   : Home
    Created on : 25/08/2023, 01:00:52 PM
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <style>
            body {
                background-color: #FA6E4D;
            }
        </style>
        <title>JSP Page</title>
    </head>
    <body>

        <div class="container mt-4 col-lg-7">
            <div class="card col-sm-9">
                <div class="card-body">
                    <div class="form-group text-center">
                        <h3>Ventas</h3>
                        <img id="usuarioImg" src="" alt="Imagen de usuario" width="160"/><br>

                        <br><label>${empleado.getNombresEmpleado()}</label>
                        <br><label>${empleado.getDPIEmpleado()}</label>
                        <br><label>IN5BV</label>
                    </div>
                    <div>
                        <p>El proyecto de ventas se ha trabajado implementando el lenguaje Java, junto con HTML y JavaScript. Se hace uso del Bootstrap, el cual es un Framework que ayuda a desarrollar el proyecto de manera más rápida y eficaz.</p>
                    </div>
                    <div>
                        <p>El proyecto es un gestor de ventas, el cual cuenta con la capacidad de trabajar con 4 Entidades principales, las cuales serían: Producto, Empleado, Clientes y Registrar venta. El proyecto también cuenta con un 'Login' para poder acceder a este, donde se hace uso de un Usuario y su Contraseña </p>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // referencia a la imagen para setearla
            var uImg = document.getElementById("usuarioImg");
            // obteniendo codigo de usuario
            var uId = ${requestScope.cod};

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
