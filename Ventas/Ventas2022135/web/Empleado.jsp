<%-- 
    Document   : Empleado
    Created on : 20/07/2023, 01:52:27 PM
    Author     : informatica
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <title>Empleados</title>
    </head>
    <body>
        <div class="d-flex">
            <div class="card col-sm-4">
                <div class="card-body">
                    <form action="Controlador?menu=Empleado" method="POST"  onsubmit="return validarCampos()">
                        <div class="form-group">
                            <label>DPI:</label>
                            <input type="text" value="${empleado.getDPIEmpleado()}" name="txtDPIEmpleado" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Nombre:</label>
                            <input type="text" value="${empleado.getNombresEmpleado()}" name="txtNombresEmpleado" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Telefono:</label>
                            <input type="text" value="${empleado.getTelefonoEmpleado()}" name="txtTelefonoEmpleado" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Estado:</label>
                            <input type="text" value="${empleado.getEstado()}" name="txtEstado" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Usuario:</label>
                            <input type="text" value="${empleado.getUsuario()}" name="txtUsuario" class="form-control">
                        </div>
                        <input type="submit" name="accion" value="agregar" class="btn btn-info">
                        <input type="submit" name="accion" value="actualizar" class="btn btn-info">
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
                            <td>TELEFONO</td>
                            <td>ESTADO</td>
                            <td>USUARIO</td>
                            <td>ACCIONES</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="empleado" items="${empleados}">
                            <tr>
                                <td>${empleado.getCodigoEmpleado()}</td>
                                <td>${empleado.getDPIEmpleado()}</td>
                                <td>${empleado.getNombresEmpleado()}</td>
                                <td>${empleado.getTelefonoEmpleado()}</td>
                                <td>${empleado.getEstado()}</td>
                                <td>${empleado.getUsuario()}</td>
                                <td>
                                    <a class="btn btn-warning" href="Controlador?menu=Empleado&accion=Editar&codigoEmpleado=${empleado.getCodigoEmpleado()}">Editar</a>
                                    <a class="btn btn-danger" href="Controlador?menu=Empleado&accion=Eliminar&codigoEmpleado=${empleado.getCodigoEmpleado()}" onclick="return confirm('¿Esta seguro que quiere eliminar el dato?')" >Eliminar </a>
                                    </script>    
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <script>
            function validarCampos() {
                var dpi = document.getElementsByName("txtDPIEmpleado")[0].value;
                var nombre = document.getElementsByName("txtNombresEmpleado")[0].value;
                var telefono = document.getElementsByName("txtTelefonoEmpleado")[0].value;
                var estado = document.getElementsByName("txtEstado")[0].value;
                var usuario = document.getElementsByName("txtUsuario")[0].value;
                
                if (dpi === "" || nombre === "" || telefono === "" || estado === "" || usuario === "") {
                    alert("La accion no es valida, llene todos los campos.");

                    return false;
                }
                return true;
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    </body>
</html>
