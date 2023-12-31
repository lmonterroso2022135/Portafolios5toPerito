
package org.luismonterroso.controller;

import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javax.swing.JOptionPane;

import org.luismonterroso.bean.TipoPlato;
import org.luismonterroso.db.Conexion;
import org.luismonterroso.main.Principal;

public class TipoPlatoController implements Initializable{
    private Principal escenarioPrincipal;
    private enum operaciones{GUARDAR, ELIMINAR,
                            ACTUALIZAR, NINGUNO};
    private operaciones tipoDeOperacion = operaciones.NINGUNO;
    private ObservableList<TipoPlato> listaTipoPlato;
    
    @FXML private TextField txtCodigoTipoPlato;
    @FXML private TextField txtDescripcionTipoPlato;
    
    @FXML private TableView tblTipoPlatos;
    @FXML private TableColumn colCodigoTipoPlato;
    @FXML private TableColumn colDescripcionTipoPlato;
    
    @FXML private Button btnNuevo;
    @FXML private Button btnEliminar;
    @FXML private Button btnReporte;
    @FXML private Button btnEditar;
    
    @FXML private ImageView imgNuevo;
    @FXML private ImageView imgReporte;
    @FXML private ImageView imgEliminar;
    @FXML private ImageView imgEditar;
    
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        cargarDatos();
    }
    
// MOSTRAR DATOS EN LA TABLA  //////////////////////////////   
    public void cargarDatos(){
        tblTipoPlatos.setItems(getTipoPlato());
        colCodigoTipoPlato.setCellValueFactory(new PropertyValueFactory<TipoPlato, Integer>("codigoTipoPlato"));
        colDescripcionTipoPlato.setCellValueFactory(new PropertyValueFactory<TipoPlato, String>("descripcionTipoPlato"));
    }
    
    
    public ObservableList<TipoPlato> getTipoPlato(){
        ArrayList <TipoPlato> lista = new ArrayList<TipoPlato>();
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_ListarTipoPlatos");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()){
                lista.add(new TipoPlato(resultado.getInt("codigoTipoPlato"),
                        resultado.getString("descripcionTipo")));
            }
            
        }catch(Exception e){
            e.printStackTrace();
        
        }
        return listaTipoPlato = FXCollections.observableArrayList(lista);
        
    }
    
// ////////////////////////////////////////////////////////////
    public void nuevo(){
        switch(tipoDeOperacion){
            case NINGUNO:
                activarControles();
                limpiarControles();
                btnNuevo.setText("Guardar");
                btnEliminar.setText("Cancelar");
                btnEditar.setDisable(true);
                btnReporte.setDisable(true);
                imgNuevo.setImage(new Image("/org/luismonterroso/image/aceptar.png"));
                imgEliminar.setImage(new Image("/org/luismonterroso/image/cancelar.png"));
                tipoDeOperacion = operaciones.GUARDAR;
            break;
            case GUARDAR:
                guardar();
                limpiarControles();
                desactivarControles();
                btnNuevo.setText("  Nuevo");
                btnEliminar.setText("  Eliminar");
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                imgNuevo.setImage(new Image("/org/luismonterroso/image/nuevo.png"));
                imgEliminar.setImage(new Image("/org/luismonterroso/image/delete.png"));
                tipoDeOperacion = operaciones.NINGUNO;
                cargarDatos();
            break;
        }
    
    
    }
        public void editar(){
    
        switch(tipoDeOperacion){
            case NINGUNO:
                if(tblTipoPlatos.getSelectionModel().getSelectedItem() !=null){
                    btnNuevo.setDisable(true);
                    btnEliminar.setDisable(true);
                    btnEditar.setText("Actualizar");
                    btnReporte.setText("Cancelar");
                    imgEditar.setImage(new Image("/org/luismonterroso/image/actualizar.png"));
                    imgReporte.setImage(new Image("/org/luismonterroso/image/cancelar.png"));
                    activarControles();
                    tipoDeOperacion = operaciones.ACTUALIZAR;
                }else{
                   JOptionPane.showMessageDialog(null, "Debe seleccionar un elemento");
                }
                 break;
            case ACTUALIZAR:
                actualizar();
                limpiarControles();
                desactivarControles();
                btnNuevo.setDisable(false);
                btnEliminar.setDisable(false);
                btnEditar.setText(" Editar");
                btnReporte.setText("Reporte");
                imgEditar.setImage(new Image("/org/luismonterroso/image/edit.png"));
                imgReporte.setImage(new Image("/org/luismonterroso/image/report.png"));
                cargarDatos();
                tipoDeOperacion = operaciones.NINGUNO;
                break;
        }
        
    }
        public void actualizar(){
            try{
                PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_EditarTipoPlato(?,?)");
                TipoPlato  registro = (TipoPlato)tblTipoPlatos.getSelectionModel().getSelectedItem();
                registro.setDescripcionTipoPlato(txtDescripcionTipoPlato.getText());
                procedimiento.setInt(1,registro.getCodigoTipoPlato());
                procedimiento.setString(2,registro.getDescripcionTipoPlato());
                procedimiento.execute();
            
            }catch(Exception e){
                e.printStackTrace();
            
            }
        
        }
    public void eliminar(){
        switch(tipoDeOperacion){
            case GUARDAR:
                limpiarControles();
                desactivarControles();
                btnNuevo.setText(" Nuevo  ");
                btnEliminar.setText(" Eliminar ");
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                imgNuevo.setImage(new Image("/org/luismonterroso/image/nuevo.png"));
                imgEliminar.setImage(new Image("/org/luismonterroso/image/delete.png"));
                tipoDeOperacion = operaciones.NINGUNO;
                
                break;
            default:
                if(tblTipoPlatos.getSelectionModel().getSelectedItem() !=null){
                    int respuesta =JOptionPane.showConfirmDialog(null, "Esta seguro de eliminar el registro?? ", "Eliminar TipoPlato",JOptionPane.YES_NO_OPTION,JOptionPane.QUESTION_MESSAGE);
                    
                    if(respuesta ==JOptionPane.YES_OPTION){
                        try{
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_EliminarEmpresa(?)");
                            procedimiento.setInt(1, ((TipoPlato)tblTipoPlatos.getSelectionModel().getSelectedItem()).getCodigoTipoPlato());
                            procedimiento.execute();
                            listaTipoPlato.remove(tblTipoPlatos.getSelectionModel().getSelectedItem());
                            limpiarControles(); 
                            
                            
                        }catch(Exception e){
                         e.printStackTrace();
                         
                        }
                    }  
                }else{
                    JOptionPane.showMessageDialog(null, "Debe seleccionar un elemento ");
                }
                seleccionarElemento();
        }
    }
    public void reporte(){
        switch(tipoDeOperacion){
            case ACTUALIZAR:
                limpiarControles();
                desactivarControles();
                btnNuevo.setDisable(false);
                btnEliminar.setDisable(false);
                btnEditar.setText(" Editar");
                btnReporte.setText(" Reporte");
                imgEditar.setImage(new Image("/org/luismonterroso/image/edit.png"));
                imgReporte.setImage(new Image("/org/luismonterroso/image/report.png"));
                cargarDatos();
                tipoDeOperacion = operaciones.NINGUNO;
                
        }
    }
    
    public void guardar(){
        TipoPlato registro= new TipoPlato();
        registro.setDescripcionTipoPlato(txtDescripcionTipoPlato.getText());
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_AgregarTipoPlato(?)");
            procedimiento.setString(1, registro.getDescripcionTipoPlato());
            procedimiento.execute();
            listaTipoPlato.add(registro);
        }catch(Exception e){
            e.printStackTrace();
        
        }
    
    }
    
// /////////////////////////////////////////////////////////////////////
    public void seleccionarElemento(){
        txtCodigoTipoPlato.setText(String.valueOf(((TipoPlato)tblTipoPlatos.getSelectionModel().getSelectedItem()).getCodigoTipoPlato()));
        txtDescripcionTipoPlato.setText(((TipoPlato)tblTipoPlatos.getSelectionModel().getSelectedItem()).getDescripcionTipoPlato());
    }
    
    public void desactivarControles(){
        txtCodigoTipoPlato.setEditable(false);
        txtDescripcionTipoPlato.setEditable(false);
    }
    public void activarControles(){
        txtCodigoTipoPlato.setEditable(true);
        txtDescripcionTipoPlato.setEditable(true);
    }    
    public void limpiarControles(){
        txtCodigoTipoPlato.clear();
        txtDescripcionTipoPlato.clear();
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
    
}
