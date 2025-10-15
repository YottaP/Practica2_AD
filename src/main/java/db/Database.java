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
import java.util.ArrayList;
import java.util.List;

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
    
    public boolean modificaImagen(String creator, String fileName)
    {
        boolean modificado = false;
        return modificado;
    }
      

/**
 * Busca imágenes en la base de datos según los criterios especificados.Si todos los parámetros son null o vacíos, devuelve todas las imágenes.
 * 
 * @param title Título de la imagen (búsqueda parcial)
 * @param description Descripción de la imagen (búsqueda parcial)
 * @param keywords Palabras clave (búsqueda parcial)
 * @param author Autor de la imagen (búsqueda parcial)
 * @param creator Creador/usuario que subió la imagen (búsqueda parcial)
 * @return Lista de objetos Image que coinciden con los criterios
 */
public List<Image> buscarImagenes(String title, String description, String keywords, 
                                   String author, String creator, String captureDateFrom, 
                                   String captureDateTo, String storageDateFrom, String storageDateTo) {
    List<Image> resultados = new ArrayList<>();
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        
        // Construir la consulta SQL dinámicamente según los parámetros
        StringBuilder sql = new StringBuilder("SELECT * FROM IMAGE WHERE 1=1");
        // Añadir condiciones solo si los parámetros no son nulos ni vacíos
        if(title != null && !title.trim().isEmpty()) {
            sql.append(" AND UPPER(TITLE) LIKE UPPER(?)");
        }
        if(description != null && !description.trim().isEmpty()) {
            sql.append(" AND UPPER(DESCRIPTION) LIKE UPPER(?)");
        }
        if(keywords != null && !keywords.trim().isEmpty()) {
            sql.append(" AND UPPER(KEYWORDS) LIKE UPPER(?)");
        }
        if(author != null && !author.trim().isEmpty()) {
            sql.append(" AND UPPER(AUTHOR) LIKE UPPER(?)");
        }
        if(creator != null && !creator.trim().isEmpty()) {
            sql.append(" AND UPPER(CREATOR) LIKE UPPER(?)");
        }
        
        // Ordenar los resultados por fecha de almacenamiento (más recientes primero)
        //sql.append(" ORDER BY FECHA_ALMACENAMIENTO DESC");
        
        ps = connection.prepareStatement(sql.toString());
        
        // Asignar los parámetros a la consulta preparada
        int paramIndex = 1;
        if(title != null && !title.trim().isEmpty()) {
            ps.setString(paramIndex++, "%" + title.trim() + "%");
        }
        if(description != null && !description.trim().isEmpty()) {
            ps.setString(paramIndex++, "%" + description.trim() + "%");
        }
        if(keywords != null && !keywords.trim().isEmpty()) {
            ps.setString(paramIndex++, "%" + keywords.trim() + "%");
        }
        if(author != null && !author.trim().isEmpty()) {
            ps.setString(paramIndex++, "%" + author.trim() + "%");
        }
        if(creator != null && !creator.trim().isEmpty()) {
            ps.setString(paramIndex++, "%" + creator.trim() + "%");
        }
        
        // Ejecutar la consulta
        rs = ps.executeQuery();
        
        // Procesar los resultados
        while(rs.next()) {
            Image img = new Image(
                rs.getString("TITLE"),
                rs.getString("DESCRIPTION"),
                rs.getString("KEYWORDS"),
                rs.getString("AUTHOR"),
                rs.getString("CREATOR"),
                rs.getString("CAPTURE_DATE"),
                rs.getString("STORAGE_DATE"),
                rs.getString("FILENAME")
            );
            resultados.add(img);
        }
        
        System.out.println("Búsqueda completada: " + resultados.size() + " imagen(es) encontrada(s)");
        
    } catch(SQLException e) {
        System.err.println("Error en búsqueda de imágenes: " + e.getMessage());
    } finally {
        // Cerrar recursos en orden inverso
        try {
            if(rs != null) rs.close();
            if(ps != null) ps.close();
        } catch(SQLException e) {
            System.err.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
    
    return resultados;
    }
}