/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.oblenergo.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import ua.aits.oblenergo.functions.DB;

/**
 *
 * @author skywalker
 */
public class UserModel {
    public Integer id;
    public String name;
    public String pass;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }
    
    public UserModel getUser(int id) throws SQLException{
        ResultSet result = DB.getResultSet("SELECT * FROM users WHERE id = "+id+";");
        result.first();
        UserModel temp = new UserModel();
        temp.setId(result.getInt("id"));
        temp.setName(result.getString("name"));
        temp.setPass(result.getString("pass"));
        return temp;
    }
    
}
