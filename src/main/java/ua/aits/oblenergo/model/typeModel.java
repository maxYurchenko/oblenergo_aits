/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.oblenergo.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import ua.aits.oblenergo.functions.DB;

/**
 *
 * @author skywalker
 */
public class typeModel {
    String title;
    Integer id;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    
    public String addType(String title) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DB.runQuery("INSERT INTO types (title) values ('"+title+"');");
        DB.closeCon();
        return "done";
    }
    
    public String editType(String id, String title) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DB.runQuery("UPDATE types SET title='"+title+"' WHERE id='"+id+"';");
        DB.closeCon();
        return "done";
    }
    
    public String deleteType(String id)  throws SQLException{ 
        DB.runQuery("DELETE FROM `types` WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
    
    public List<typeModel> getAllTypes() throws SQLException{
        List<typeModel> types = new LinkedList<>();
        ResultSet result = null;
        try{
            result = DB.getResultSet("select * from types;");
            while (result.next()) { 
                typeModel temp = new typeModel();
                temp.setId(result.getInt("id"));
                temp.setTitle(result.getString("title"));
                types.add(temp);
            }
        }
        finally{
            result.close();
            DB.closeCon();
        }
        return types;
    }
    
    public typeModel getOneType(String id) throws SQLException{
        ResultSet result = null;
        typeModel type = null;
        try{
            result = DB.getResultSet("select * from types WHERE id='"+id+"';");
            result.first();
            type = new typeModel();
            type.setTitle(result.getString("title"));
            type.setId(result.getInt("id"));
        }
        finally{
            result.close();
            DB.closeCon();
        }
        return type;
    }
}
