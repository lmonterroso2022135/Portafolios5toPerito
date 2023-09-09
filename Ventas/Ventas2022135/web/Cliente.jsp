<%-- 
    Document   : Cliente
    Created on : 15/08/2023, 06:59:02 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <title>Clientes</title>
    </head>
    <body>
        <div class="d-flex">
            <div class="card col-sm-4">
                <div class="card-body">
                    <form action="Controlador?menu=Cliente" method="POST" onsubmit="return validarCampos()">
                        <div class="form-group">
                            <label>DPI:</label>
                            <input type="text" value="${cliente.getDPICliente()}" name="txtDPICliente" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Nombre:</label>
                            <input type="text" value="${cliente.getNombresCliente()}" name="txtNombresCliente" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Direccion:</label>
                            <input type="text" value="${cliente.getDireccionCliente()}" name="txtDireccionCliente" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Estado:</label>
                            <input type="text" value="${cliente.getEstado()}" name="txtEstado" class="form-control">
                        </div>
                        <input type="submit" name="accion" value="agregar" class="btn btn-info" href="Controlador?menu=Clientes&accion=Agregar">
                        <input type="submit" name="accion" value="Actualizar" class="btn btn-success" href="Controlador?menu=Clientes&accion=Actualizar">
                    </form>
                </div>
            </div>
            <div class="col-sm-8">
                <table class="table table-hober">
                    <thead>
                        <tr>
                            <td>CODIGO</td>
                            <td>DPI</td>
                            <td>NOMBRES</td>
                            <td>DIRECCION</td>
                            <td>ESTADO</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cliente" items="${clientes}">
                            <tr>
                                <td>${cliente.getCodigoCliente()}</td>
                                <td>${cliente.getDPICliente()}</td>
                                <td>${cliente.getNombresCliente()}</td>
                                <td>${cliente.getDireccionCliente()}</td>
                                <td>${cliente.getEstado()}</td>
                                <td>
                                    <a class="btn btn-warning" href="Controlador?menu=Cliente&accion=Editar&codigoCliente=${cliente.getCodigoCliente()}">Editar</a>
                                    <a class="btn btn-danger" href="Controlador?menu=Cliente&accion=Eliminar&codigoCliente=${cliente.getCodigoCliente()}" onclick="return confirm('Seguro que desea eleminar este dato?')">Eliminar</a>

                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <script>
            function validarCampos() {
                // Obtén los valores de los campos de entrada
                var dpi = document.getElementsByName("txtDPICliente")[0].value;
                var nombre = document.getElementsByName("txtNombresCliente")[0].value;
                var direccion = document.getElementsByName("txtDireccionCliente")[0].value;
                var estado = document.getElementsByName("txtEstado")[0].value;

                // Verifica si alguno de los campos está vacío
                if (dpi === "" || nombre === "" || direccion === "" || estado === "") {
                    // Muestra una alerta
                    alert("La accion no es valida, llene todos los campos.");
                    // Detén el envío del formulario
                    return false;
                }

                // Si todos los campos están llenos, permite que el formulario se envíe
                return true;
            }
        </script>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>   
    </body>
</html>
