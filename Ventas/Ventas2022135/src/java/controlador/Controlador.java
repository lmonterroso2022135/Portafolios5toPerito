package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Cliente;
import modelo.ClienteDAO;
import modelo.Empleado;
import modelo.EmpleadoDAO;
import modelo.Producto;
import modelo.ProductoDAO;
import modelo.Venta;

public class Controlador extends HttpServlet {

    Empleado empleado = new Empleado();
    Producto producto = new Producto();
    Cliente cliente = new Cliente();
    Venta venta = new Venta();

    EmpleadoDAO empleadoDAO = new EmpleadoDAO();
    ProductoDAO productoDAO = new ProductoDAO();
    ClienteDAO clienteDAO = new ClienteDAO();

    List<Venta> lista = new ArrayList<>();

    int codEmpleado;
    int codProducto;
    int codCliente;
    

    int item = 0;
    int codPro, cantid;
    String descripcion;
    Double precio, subTotal;
    Double totalPagar;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");
        String codEmp=request.getParameter("codEmp"); //////////////////////////////////////////////////////////////////////////////////////////////////
        
        if (menu.equals("Principal")) {
            request.getRequestDispatcher("principal.jsp").forward(request, response);
            
            return;
        } else if (menu.equals("Home")) {
            //System.out.println(codEmp);
            
            Empleado e = empleadoDAO.listarCodigoEmpleado(Integer.parseInt(codEmp));
           // System.out.println(e);
            request.setAttribute("empleado", e);
            request.setAttribute("cod", codEmp);
            
            request.getRequestDispatcher("Home.jsp").forward(request, response);
            
        } else if (menu.equals("Empleado")) {
            switch (accion) {
                case "listar":
                    List listaEmpleado = empleadoDAO.listar();
                    request.setAttribute("empleados", listaEmpleado);
                    break;
                case "agregar":
                    String DPI = request.getParameter("txtDPIEmpleado");
                    String nombres = request.getParameter("txtNombresEmpleado");
                    String telefono = request.getParameter("txtTelefonoEmpleado");
                    String est = request.getParameter("txtEstado");
                    String user = request.getParameter("txtUsuario");
                    empleado.setDPIEmpleado(DPI);
                    empleado.setNombresEmpleado(nombres);
                    empleado.setTelefonoEmpleado(telefono);
                    empleado.setEstado(est);
                    empleado.setUsuario(user);
                    empleadoDAO.agregar(empleado);
                    request.getRequestDispatcher("Controlador?menu=Empleado&accion=listar").forward(request, response);
                    break;
                case "Editar":
                    codEmpleado = Integer.parseInt(request.getParameter("codigoEmpleado"));
                    Empleado e = empleadoDAO.listarCodigoEmpleado(codEmpleado);
                    request.setAttribute("empleado", e);
                    request.getRequestDispatcher("Controlador?menu=Empleado&accion=listar").forward(request, response);
                    break;
                case "actualizar":
                    String bDPI = request.getParameter("txtDPIEmpleado");
                    String bNombres = request.getParameter("txtNombresEmpleado");
                    String bTelefono = request.getParameter("txtTelefonoEmpleado");
                    String bEst = request.getParameter("txtEstado");
                    String bUser = request.getParameter("txtUsuario");
                    empleado.setDPIEmpleado(bDPI);
                    empleado.setNombresEmpleado(bNombres);
                    empleado.setTelefonoEmpleado(bTelefono);
                    empleado.setEstado(bEst);
                    empleado.setUsuario(bUser);
                    empleado.setCodigoEmpleado(codEmpleado);
                    empleadoDAO.actualizar(empleado);
                    request.getRequestDispatcher("Controlador?menu=Empleado&accion=listar").forward(request, response);
                    break;
                case "Eliminar":
                    codEmpleado = Integer.parseInt(request.getParameter("codigoEmpleado"));
                    empleadoDAO.eliminar(codEmpleado);
                    request.getRequestDispatcher("Controlador?menu=Empleado&accion=listar").forward(request, response);
                    break;
            }
            request.getRequestDispatcher("Empleado.jsp").forward(request, response);
         } else if (menu.equals("CarritoCompra")) {
//            switch (accion) {
//                case "Eliminar":
//                    codProducto = Integer.parseInt(request.getParameter("codigoProducto"));
//                    if (listaCarrito.size() > 0) {
//                        for (int i = 0; i < listaCarrito.size(); i++) {
//                            if (codProducto == listaCarrito.get(i).getCodigoProducto()) {
//                                posicion = i;
//                            }
//                        }
//                        if (codProducto == listaCarrito.get(posicion).getCodigoProducto()) {
//                            System.out.println(contador);
//                            contador = contador - listaCarrito.get(posicion).getCantidad();
//                            totalPagar = totalPagar - listaCarrito.get(posicion).getSubtotal();
//                            listaCarrito.remove(posicion);
//                        }
//                    }
//                    request.setAttribute("contador", contador);
//                    request.setAttribute("listaCarrito", listaCarrito);
//                    break;
//                case "Cancelar":
//                    if (listaCarrito.size() > 0) {
//                        listaCarrito.clear();
//                        contador = 0;
//                        totalPagar = 0.0;
//                    }
//                    request.setAttribute("contador", contador);
//                    request.setAttribute("totalPagar", totalPagar);
//                    request.setAttribute("listaCarrito", listaCarrito);
//                    break;
//            }
//            request.setAttribute("listaCarrito", listaCarrito);
            request.setAttribute("totalPagar", totalPagar);
            request.getRequestDispatcher("CarritoCompra.jsp").forward(request, response);
        
        } else if (menu.equals("Producto")) {
            switch (accion) {
                case "listar":
                    List listaProducto = productoDAO.listar();
                    request.setAttribute("productos", listaProducto);
                    break;
                case "agregar":
                    String nombre = request.getParameter("txtNombreProducto");
                    String precio = request.getParameter("txtPrecio");
                    String stock = request.getParameter("txtStock");
                    String est = request.getParameter("txtEstado");
                    producto.setNombreProducto(nombre);
                    producto.setPrecio(Double.parseDouble(precio));
                    producto.setStock(Integer.parseInt(stock));
                    producto.setEstado(est);
                    productoDAO.agregar(producto);
                    request.getRequestDispatcher("Controlador?menu=Producto&accion=listar").forward(request, response);
                    break;

                case "Editar":
                    codProducto = Integer.parseInt(request.getParameter("codigoProducto"));
                    Producto p = productoDAO.listarCodigoProducto(codProducto);
                    request.setAttribute("producto", p);
                    request.getRequestDispatcher("Controlador?menu=Producto&accion=listar").forward(request, response);
                    break;

                case "Actualizar":
                    String nombre2 = request.getParameter("txtNombreProducto");
                    String precio2 = request.getParameter("txtPrecio");
                    String stock2 = request.getParameter("txtStock");
                    String est2 = request.getParameter("txtEstado");
                    producto.setNombreProducto(nombre2);
                    producto.setPrecio(Double.parseDouble(precio2));
                    producto.setStock(Integer.parseInt(stock2));
                    producto.setEstado(est2);
                    producto.setCodigoProducto(codProducto);
                    productoDAO.actualizar(producto);
                    request.getRequestDispatcher("Controlador?menu=Producto&accion=listar").forward(request, response);
                    break;

                case "Eliminar":
                    codProducto = Integer.parseInt(request.getParameter("codigoProducto"));
                    productoDAO.eliminar(codProducto);
                    request.getRequestDispatcher("Controlador?menu=Producto&accion=listar").forward(request, response);
                    break;
            }

            request.getRequestDispatcher("Producto.jsp").forward(request, response);
        } else if (menu.equals("Cliente")) {
            switch (accion) {
                case "listar":
                    List listaCliente = clienteDAO.listar();
                    request.setAttribute("clientes", listaCliente);
                    break;
                case "agregar":
                    String DPI = request.getParameter("txtDPICliente");
                    String nombres = request.getParameter("txtNombresCliente");
                    String direccion = request.getParameter("txtDireccionCliente");
                    String est = request.getParameter("txtEstado");
                    cliente.setDPICliente(DPI);
                    cliente.setNombresCliente(nombres);
                    cliente.setDireccionCliente(direccion);
                    cliente.setEstado(est);
                    clienteDAO.agregar(cliente);
                    request.getRequestDispatcher("Controlador?menu=Cliente&accion=listar").forward(request, response);
                    break;
                case "Editar":
                    codCliente = Integer.parseInt(request.getParameter("codigoCliente"));
                    Cliente cl = clienteDAO.listarCodigoCliente(codCliente);
                    request.setAttribute("cliente", cl);
                    request.getRequestDispatcher("Controlador?menu=Cliente&accion=listar").forward(request, response);
                    break;
                case "Actualizar":
                    String DPI3 = request.getParameter("txtDPICliente");
                    String nombres3 = request.getParameter("txtNombresCliente");
                    String direccion3 = request.getParameter("txtDireccionCliente");
                    String est3 = request.getParameter("txtEstado");

                    cliente.setDPICliente(DPI3);
                    cliente.setNombresCliente(nombres3);
                    cliente.setDireccionCliente(direccion3);
                    cliente.setEstado(est3);
                    cliente.setCodigoCliente(codCliente);
                    clienteDAO.actualizar(cliente);
                    request.getRequestDispatcher("Controlador?menu=Cliente&accion=listar").forward(request, response);

                case "Eliminar":
                    codCliente = Integer.parseInt(request.getParameter("codigoCliente"));
                    clienteDAO.eliminar(codCliente);

                    request.getRequestDispatcher("Controlador?menu=Cliente&accion=listar").forward(request, response);
                    break;
            }
            request.getRequestDispatcher("Cliente.jsp").forward(request, response);
        } else if (menu.equals("RegistrarVenta")) {

            switch (accion) {
                case "BuscarCliente":
                    int cod = Integer.parseInt(request.getParameter("txtCodigoCliente"));
                    cliente = clienteDAO.listarCodigoCliente(cod);
                    request.setAttribute("cliente", cliente);
                    break;
                case "BuscarProducto":
                    int codProd = Integer.parseInt(request.getParameter("txtCodigoProducto"));
                    producto = productoDAO.listarCodigoProducto(codProd);
                    request.setAttribute("producto", producto);
                    break;
                case "Agregar":
                    request.setAttribute("cliente", cliente);
                    totalPagar = 0.0;
                    item = item + 1;
                    codPro = producto.getCodigoProducto();
                    descripcion = request.getParameter("txtNombreProducto");
                    precio = Double.parseDouble(request.getParameter("txtPrecio"));
                    cantid = Integer.parseInt(request.getParameter("txtCantidad"));
                    subTotal = precio * cantid;
                    venta = new Venta();
                    venta.setItem(item);
                    venta.setCodigoProducto(codPro);
                    venta.setDescripcionProd(descripcion);
                    venta.setPrecio(precio);
                    venta.setCantidad(cantid);
                    venta.setSubtotal(subTotal);
                    lista.add(venta);
                    for (int i = 0; i < lista.size(); i++) {
                        totalPagar = totalPagar + lista.get(i).getSubtotal();
                    }
                    request.setAttribute("totalPagar", totalPagar);
                    request.setAttribute("lista", lista);
                    break;
            }
            request.getRequestDispatcher("RegistrarVentas.jsp").forward(request, response);

        } else if (menu.equals("Carrito")) {
            List listaProducto = productoDAO.listar();
            request.setAttribute("productos", listaProducto);
            request.getRequestDispatcher("Producto.jsp").forward(request, response);
        }

    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
