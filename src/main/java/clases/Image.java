/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

/**
 *
 * @author alumne
 */
public class Image {
    
        private int ID; 
        private String title;
        private String description;
        private String keywords;
        private String author;
        private final String creator; // Usuario que inserta la foto
        private String captureDate;
        private String filename;
        private String storageDate; 
        
        public Image(String title, String description, String keywords, String author,
                String creator, String captureDate, String storageDate, String filename)
        {
            //this.ID = ID;
            this.title = title;
            this.description = description;
            this.keywords = keywords;
            this.author = author;
            this.creator = creator;
            this.captureDate = captureDate;
            this.filename = filename;
            this.storageDate = storageDate;
        }
        
        public int getID(){ return ID;}   
        public String getTitle(){ return title;}   
        public String getDescription(){ return description;}   
        public String getKeywords(){ return keywords;}    
        public String getAuthor(){ return author;}    
        public String getCreator(){ return creator;}  
        public String getCaptureDate(){ return captureDate;}
        public String getFilename(){ return filename;}
        public String getStorageDate(){ return storageDate;}

        
        public void setID(int ID){this.ID = ID;}
        public void setTitle(String title){ this.title=title;}   
        public void setDescription(String description){this.description=description;}   
        public void setKeywords(String keywords){ this.keywords=keywords;}    
        public void setAuthor(String author){ this.author=author;}    
        public void setCaptureDate(String captureDate){ this.captureDate=captureDate;}  
        public void setFilename(String filename){ this.filename=filename;}
        public void setStorageDate(String storageDate){ this.storageDate=storageDate;}
}
