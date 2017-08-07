/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pc
 */
import java.sql.*;
public class ClsConexion {
    private static final String USERNAME="root";
    private static final String PASSWORD="";
    private static final String  CON_STRING="jdbc:mysql://localhost:3306/cajachica";

    public ClsConexion() {
        Connection conn=null;
        try{conn=DriverManager.getConnection(CON_STRING,USERNAME,PASSWORD);
            System.out.println("Conectado");
            Statement stat=(Statement) conn.createStatement();
        
        }catch(SQLException e){
                System.out.println(e);
                
        }
        
    }
    
}
