
package org.luismonterroso.controller;

import eu.schudt.javafx.controls.calendar.DatePicker;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Locale;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.ImageView;
import javafx.scene.layout.GridPane;
import org.luismonterroso.bean.Empresa;
import org.luismonterroso.bean.Presupuesto;
import org.luismonterroso.db.Conexion;
import org.luismonterroso.main.Principal;

public class PresupuestoController implements Initializable {
    private Principal escenarioPrincipal;
    private enum operaciones {GUARDAR, ELIMINAR, ACTUALIZAR, NINGUNO}
    private operaciones tipoDeOperacion = operaciones.NINGUNO;
    private ObservableList<Presupuesto> listaPresupuesto;
    private ObservableList<Empresa> listaEmpresa;
    private DatePicker fecha;
    
    @FXML private TextField txtCodigoPresupuesto;
    @FXML private TextField txtCantidadPresupuesto;
    @FXML private GridPane grpFecha;
    @FXML private ComboBox cmbCodigoEmpresa;
    
    @FXML private TableView tblPresupuestos;
    @FXML private TableColumn colCodigoEmpresa;
    @FXML private TableColumn colFechaSolicitud;
    @FXML private TableColumn colCantidadPresupuesto;
    @FXML private TableColumn colCodigoPresupuesto;
    
    @FXML private Button btnNuevo;
    @FXML private Button btnEliminar;
    @FXML private Button btnEditar;
    @FXML private Button btnReporte;
    
    @FXML private ImageView imgNuevo;
    @FXML private ImageView imgEliminar;
    @FXML private ImageView imgEditar;
    @FXML private ImageView imgReporte;
    
    
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        cargarDatos();
        fecha = new DatePicker(Locale.ENGLISH);
        fecha.setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
        fecha.getCalendarView().todayButtonTextProperty().set("Today");
        fecha.getCalendarView().setShowWeeks(true);
        fecha.getStylesheets().add("/org/luismonterroso/resource/TonnysKinal.css");
        cmbCodigoEmpresa.setItems(getEmpresa());
        grpFecha.add(fecha, 3, 0);
    }
    
    public void cargarDatos(){
        tblPresupuestos.setItems(getPresupuesto());
        colCodigoPresupuesto.setCellValueFactory(new PropertyValueFactory<Presupuesto, Integer>("codigoPresupuesto"));
        colFechaSolicitud.setCellValueFactory(new PropertyValueFactory<Presupuesto, Integer>("fechaSolicitud"));
        colCantidadPresupuesto.setCellValueFactory(new PropertyValueFactory<Presupuesto, Integer>("cantidadPresupuesto"));
        colCodigoEmpresa.setCellValueFactory(new PropertyValueFactory<Presupuesto, Integer>("codigoEmpresa"));
    }
    
    public void seleccionarElemento(){
        txtCodigoPresupuesto.setText(String.valueOf(((Presupuesto)tblPresupuestos.getSelectionModel().getSelectedItem()).getCodigoPresupuesto()));
//        txtCantidadPresupuesto.setText(String.valueOf((Presupuesto)tblPresupuestos.getSelectionModel().getSelectedItem()).getCantidadPresupuesto());
//        cbmCodigoEmpresa.getSelectionModel().select(buscarEmpresa(5));
    }
    
    public ObservableList<Presupuesto> getPresupuesto(){
        ArrayList<Presupuesto> lista = new ArrayList<Presupuesto>();
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_ListarPresupuestos");
            ResultSet resultado = procedimiento.executeQuery();
            while(resultado.next()){
                lista.add(new Presupuesto(resultado.getInt("codigoPresupuesto"),
                                        resultado.getDate("fechaSolicitud"),
                                        resultado.getDouble("cantidadPresupuesto"),
                                        resultado.getInt("codigoEmpresa")));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return listaPresupuesto = FXCollections.observableArrayList(lista);
    }
    
    public ObservableList<Empresa> getEmpresa(){
        ArrayList<Empresa> lista = new ArrayList<Empresa>();
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_ListarEmpresas");   
            ResultSet resultado = procedimiento.executeQuery();
            while(resultado.next()){
                lista.add(new Empresa(resultado.getInt("codigoEmpresa"),
                          resultado.getString("nombreEmpresa"),
                          resultado.getString("direccion"),
                          resultado.getString("telefono")));
            }   
        }catch(Exception e){
            e.printStackTrace();
        }  
        return listaEmpresa = FXCollections.observableArrayList(lista);
    }
  
    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
    }
    
    public void ventanaEmpresa(){
        escenarioPrincipal.ventanaEmpresa();
    }
}
