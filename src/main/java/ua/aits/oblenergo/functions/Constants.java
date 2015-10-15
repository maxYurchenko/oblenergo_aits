/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.oblenergo.functions;


/**
 *
 * @author kiwi
 */
public class Constants
{
    public static final String home = "/home/skywalker/NetBeansProjects/oblenergo/src/main/webapp"; // change /home/project/Kiwi to your project folder path
    public static final String URL = "/oblenergo/";
    public static final String FILE_URL = home+"/files";
    
    public static final String DB_DRIVER = "com.mysql.jdbc.Driver";
    public static final String DB_CONNECTION_STRING = "jdbc:mysql://localhost:3306/oblenergo?useUnicode=true&characterEncoding=UTF-8";
    public static final String DB_USER = "root";
    public static final String DB_PASSWORD = "max13579";
    
    public String getURL()
    {
        return URL;
    }
    
    public String getFILE_URL()
    {
        return FILE_URL;
    }
    
    public String getDB_DRIVER()
    {
        return DB_DRIVER;
    }
    
    public String getDB_CONNECTION_STRING()
    {
        return DB_CONNECTION_STRING;
    }
    
    public String getDB_USER()
    {
        return DB_USER;
    }
    
    public String getDB_PASSWORD()
    {
        return DB_PASSWORD;
    }
    
}