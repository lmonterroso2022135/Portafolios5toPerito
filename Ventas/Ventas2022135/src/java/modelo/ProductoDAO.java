
package modelo;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    int resp;
    
    
    public List listar(){
        String sql = "Select * from producto";
        List <Producto> listaProducto = new ArrayList<>();
        try{
            con = cn.Conexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Producto pr = new Producto();
                pr.setCodigoProducto(rs.getInt(1));
                pr.setNombreProducto(rs.getString(2));
                pr.setPrecio(rs.getDouble(3));
                pr.setStock(rs.getInt(4));
                pr.setEstado(rs.getString(5));
                listaProducto.add(pr);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return listaProducto;
    }
    
        public int agregar(Producto pr){
            String sql = "insert into Producto (nombreProducto, precio, stock, estado) values(?,?,?,?);";
            
            try{
                
                con = cn.Conexion();
                ps = con.prepareStatement(sql);
                ps.setString(1, pr.getNombreProducto());
                ps.setDouble(2, pr.getPrecio());
                ps.setInt(3, pr.getStock());
                ps.setString(4, pr.getEstado());
                ps.executeUpdate();
            }catch(Exception e){
                e.printStackTrace();
                System.out.println("No se pudo establecer conexion");
            }
            return resp;
        }

        
        public Producto listarCodigoProducto(int id){
            
            Producto pr = new Producto();
            String sql = "select * from producto where codigoProducto = "+id;
            try{
                con = cn.Conexion();
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                
                while(rs.next()){
                    pr.setCodigoProducto(rs.getInt(1));
                    pr.setNombreProducto(rs.getString(2));
                    pr.setPrecio(rs.getDouble(3));
                    pr.setStock(rs.getInt(4));
                    pr.setEstado(rs.getString(5));     
                }
                
            }catch(Exception e){
                e.printStackTrace();
                System.out.println("No se puede establecer la conexion");
            }
            return pr;
        }
    
        
        public int actualizar(Producto pr){
            String sql = "update producto set nombreProducto = ?, precio = ?, stock = ?, estado = ? where codigoProducto = ?";
            try{
                con = cn.Conexion();
                ps = con.prepareStatement(sql);
                ps.setString(1, pr.getNombreProducto());
                ps.setDouble(2, pr.getPrecio());
                ps.setInt(3, pr.getStock());
                ps.setString(4, pr.getEstado());
                ps.setInt(5, pr.getCodigoProducto());
                ps.executeUpdate();
            }catch(Exception e){
                e.printStackTrace();
            }
            return resp;
        }
    
        
        public void eliminar(int id){
            String sql = "delete from producto where codigoProducto ="+id;
            try{
                con=cn.Conexion();
                ps = con.prepareStatement(sql);
                ps.executeUpdate();
            }catch(Exception e){
                e.printStackTrace();
            }
        }
    
}


