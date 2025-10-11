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
    
        private String title;
        private String description;
        private String keywords;
        private String author;
        private String creator;
        private String captureDate;
        private String filename;
        private String storageDate; 
        
        public Image(String title, String description, String keywords, String author,
                String creator, String captureDate, String filename, String storageDate)
        {
            this.title = title;
            this.description = description;
            this.keywords = keywords;
            this.author = author;
            this.creator = creator;
            this.captureDate = captureDate;
        }
    
}
