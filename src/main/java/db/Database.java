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
    
    public boolean modificaImagen(Image imagen)
    {
    String sql = "UPDATE IMAGE SET" +
                " title = ?," +
                " description = ?," +
                " keywords = ?," +
                " author = ?," + 
                " creator = ?," +
                " capture_date = ?," +
                " storage_date = ?," +
                " filename = ?" +
            " WHERE id = ?";
        System.out.println(sql + '\n');
        System.out.println(imagen.getTitle() + '\n');
        System.out.println(imagen.getDescription() + '\n');
        System.out.println(imagen.getKeywords() + '\n');
        System.out.println(imagen.getAuthor() + '\n');
        System.out.println(imagen.getCreator() + '\n');
        System.out.println(imagen.getCaptureDate() + '\n');
        System.out.println(imagen.getStorageDate() + '\n'); 
        System.out.println(imagen.getFilename() + '\n');
        System.out.println(imagen.getID() + '\n');




        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, imagen.getTitle());
            ps.setString(2, imagen.getDescription());
            ps.setString(3, imagen.getKeywords());
            ps.setString(4, imagen.getAuthor());
            ps.setString(5, imagen.getCreator());
            ps.setString(6, imagen.getCaptureDate());
            ps.setString(7, imagen.getStorageDate());
            ps.setString(8, imagen.getFilename());
            ps.setInt(9, imagen.getID());


            int rows = ps.executeUpdate();
            return rows > 0; // true si se actualizó al menos una fila

        } catch (SQLException e) {
            return false;
        }
    }
      

/**
 * Busca imágenes en la base de datos según los criterios especificados.
 * Si todos los parámetros son null o vacíos, devuelve todas las imágenes.
 * 
 * @param id ID de la imagen (búsqueda exacta)
 * @param title Título de la imagen (búsqueda parcial)
 * @param description Descripción de la imagen (búsqueda parcial)
 * @param keywords Palabras clave (búsqueda parcial)
 * @param author Autor de la imagen (búsqueda parcial)
 * @param creator Creador/usuario que subió la imagen (búsqueda parcial)
 * @param captureDateFrom Fecha de captura desde (formato: yyyy-MM-dd)
 * @param captureDateTo Fecha de captura hasta (formato: yyyy-MM-dd)
 * @param storageDateFrom Fecha de almacenamiento desde (formato: yyyy-MM-dd)
 * @param storageDateTo Fecha de almacenamiento hasta (formato: yyyy-MM-dd)
 * @return Lista de objetos Image que coinciden con los criterios
 */
public List<Image> buscarImagenes(String id, String title, String description, String keywords, 
                                   String author, String creator, String captureDateFrom, 
                                   String captureDateTo, String storageDateFrom, String storageDateTo) {
    List<Image> resultados = new ArrayList<>();
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
       
        // Convertir fechas de yyyy-MM-dd a yyyy/MM/dd para comparar con la BD
        if(captureDateFrom != null && !captureDateFrom.trim().isEmpty()) {
            captureDateFrom = captureDateFrom.replace("-", "/");
        }
        if(captureDateTo != null && !captureDateTo.trim().isEmpty()) {
            captureDateTo = captureDateTo.replace("-", "/");
        }
        if(storageDateFrom != null && !storageDateFrom.trim().isEmpty()) {
            storageDateFrom = storageDateFrom.replace("-", "/");
        }
        if(storageDateTo != null && !storageDateTo.trim().isEmpty()) {
            storageDateTo = storageDateTo.replace("-", "/");
        }
        
        // Construir la consulta SQL dinámicamente según los parámetros
        StringBuilder sql = new StringBuilder("SELECT * FROM IMAGE WHERE 1=1");
        
        // Añadir condición para ID (búsqueda exacta)
        if(id != null && !id.trim().isEmpty()) {
            sql.append(" AND ID = ?");
        }
        
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
        
        // Añadir condiciones para rangos de fechas de captura
        if(captureDateFrom != null && !captureDateFrom.trim().isEmpty()) {
            sql.append(" AND CAPTURE_DATE >= ?");
        }
        if(captureDateTo != null && !captureDateTo.trim().isEmpty()) {
            sql.append(" AND CAPTURE_DATE <= ?");
        }
        
        // Añadir condiciones para rangos de fechas de almacenamiento
        if(storageDateFrom != null && !storageDateFrom.trim().isEmpty()) {
            sql.append(" AND STORAGE_DATE >= ?");
        }
        if(storageDateTo != null && !storageDateTo.trim().isEmpty()) {
            sql.append(" AND STORAGE_DATE <= ?");
        }
        
        // Ordenar los resultados por ID
        sql.append(" ORDER BY ID ASC");
        
        ps = connection.prepareStatement(sql.toString());
        
        // Asignar los parámetros a la consulta preparada
        int paramIndex = 1;
        
        
        // ID (búsqueda exacta)
        if(id != null && !id.trim().isEmpty()) {
            try {
                int idValue = Integer.parseInt(id.trim());
                ps.setInt(paramIndex, idValue);
                //System.out.println("  Param[" + paramIndex + "] (ID): " + idValue);
                paramIndex++;
            } catch(NumberFormatException e) {
                System.err.println("ID no válido: " + id);
                return resultados;
            }
        }
        
        // Campos de texto (búsqueda parcial con LIKE)
        if(title != null && !title.trim().isEmpty()) {
            String value = "%" + title.trim() + "%";
            ps.setString(paramIndex, value);
            //System.out.println("  Param[" + paramIndex + "] (TITLE): " + value);
            paramIndex++;
        }
        if(description != null && !description.trim().isEmpty()) {
            String value = "%" + description.trim() + "%";
            ps.setString(paramIndex, value);
            //System.out.println("  Param[" + paramIndex + "] (DESCRIPTION): " + value);
            paramIndex++;
        }
        if(keywords != null && !keywords.trim().isEmpty()) {
            String value = "%" + keywords.trim() + "%";
            ps.setString(paramIndex, value);
            //System.out.println("  Param[" + paramIndex + "] (KEYWORDS): " + value);
            paramIndex++;
        }
        if(author != null && !author.trim().isEmpty()) {
            String value = "%" + author.trim() + "%";
            ps.setString(paramIndex, value);
            //System.out.println("  Param[" + paramIndex + "] (AUTHOR): " + value);
            paramIndex++;
        }
        if(creator != null && !creator.trim().isEmpty()) {
            String value = "%" + creator.trim() + "%";
            ps.setString(paramIndex, value);
            //System.out.println("  Param[" + paramIndex + "] (CREATOR): " + value);
            paramIndex++;
        }
        
        // Fechas de captura
        if(captureDateFrom != null && !captureDateFrom.trim().isEmpty()) {
            ps.setString(paramIndex, captureDateFrom.trim());
            //System.out.println("  Param[" + paramIndex + "] (CAPTURE_DATE >=): [" + captureDateFrom.trim() + "]");
            paramIndex++;
        }
        if(captureDateTo != null && !captureDateTo.trim().isEmpty()) {
            ps.setString(paramIndex, captureDateTo.trim());
            //System.out.println("  Param[" + paramIndex + "] (CAPTURE_DATE <=): [" + captureDateTo.trim() + "]");
            paramIndex++;
        }
        
        // Fechas de almacenamiento
        if(storageDateFrom != null && !storageDateFrom.trim().isEmpty()) {
            ps.setString(paramIndex, storageDateFrom.trim());
            //System.out.println("  Param[" + paramIndex + "] (STORAGE_DATE >=): [" + storageDateFrom.trim() + "]");
            paramIndex++;
        }
        if(storageDateTo != null && !storageDateTo.trim().isEmpty()) {
            ps.setString(paramIndex, storageDateTo.trim());
            //System.out.println("  Param[" + paramIndex + "] (STORAGE_DATE <=): [" + storageDateTo.trim() + "]");
            paramIndex++;
        }
        
        // Ejecutar la consulta
        rs = ps.executeQuery();
        
        // Procesar los resultados
        int count = 0;
        while(rs.next()) {
            count++;
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
            img.setID(rs.getInt("ID"));
            
            resultados.add(img);
        }
        
 
    } catch(SQLException e) {
        System.err.println("ERROR EN BÚSQUEDA: " + e.getMessage());
    } finally {
        try {
            if(rs != null) rs.close();
            if(ps != null) ps.close();
        } catch(SQLException e) {
            System.err.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
    
    return resultados;
}

    public boolean eliminaImagen(int id)
    {
        String sql = "DELETE FROM IMAGE WHERE id = ?";  // La consulta con parámetro
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, id);

            int filasAfectadas = stmt.executeUpdate();

            return filasAfectadas > 0;  // Si se borró una fila, devuelve true
            
        } catch (SQLException e) {
            return false;  // Si ocurre un error, devuelve false
        }
    }
    
public Image retornaImagen(int id) {
    String query = "SELECT * FROM IMAGE WHERE id = ?";

    try (PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
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
                return img;
            } else {
                System.out.println("⚠️ No existe ninguna imagen con id=" + id);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return null;
    }

}