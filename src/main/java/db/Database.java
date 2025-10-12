/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import clases.Image;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author alumne
 */
public final class Database {
    
    // HACER TODAS LAS BUSQUEDAS CON LIKE
    
    private final Connection connection;
    
    public Database(){
        connection = getConnection(); // Creacion conexion
    };
    
    // Método que crea y devuelve una conexión a la base de datos de las imágenes
    public Connection getConnection()
    {
        Connection c = null;
        try
        {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            c = DriverManager.getConnection("jdbc:derby://localhost:1527/pr2;user=pr2;password=pr2");
        }
        catch (ClassNotFoundException | SQLException e) {
            System.err.println(e.getMessage());
        }
        
        return c;
    }
    
    public Connection torna()
    {
        return connection;
    }
    
    // Metodo para acabar conexion a la base de datos
    public void Shutdown()
    {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            // connection close failed.
            System.err.println(e.getMessage());
        }
    }
    
    // Consulta si el usuario tiene la contraseña correcta
    public boolean consultaUsuario(String user, String password)
    {
        boolean b = false;            
        //String query = "SELECT * from USUARIOS where ID_USUARIO = " + user;
        //String query = "select * from usuarios where id_usuario = 'Juan'";
        String query = "select * from usuarios where id_usuario = '" + user + "'";

        try(PreparedStatement statement = connection.prepareStatement(query))
        {            
            ResultSet rs = statement.executeQuery();
            while(rs.next())  
            {
                return(rs.getString("PASSWORD").equals(password));  
            }
        } 
        catch(Exception e)
        {
            System.err.println(e.getMessage()); 
        }
        return b;
    }
    
    public boolean insertaImagen(Image i)
    {
        boolean done = false;
        String query = "INSERT INTO image (title, description, keywords, author, creator, capture_date, storage_date, filename) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
          
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            
            statement.setString(1, i.getTitle());
            statement.setString(2, i.getDescription());
            statement.setString(3, i.getKeywords());
            statement.setString(4, i.getAuthor());
            statement.setString(5, i.getCreator());
            statement.setString(6, i.getCaptureDate());
            statement.setString(7, i.getStorageDate());
            statement.setString(8, i.getFilename()); 
            
            int rows = statement.executeUpdate();
            if (rows > 0) {
                done = true; 
            }
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }
        return done;
    }
      
}
