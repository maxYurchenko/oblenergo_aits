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
import static javax.swing.text.StyleConstants.Size;
import ua.aits.oblenergo.functions.DB;

/**
 *
 * @author skywalker
 */
public class UserModel {
    public Integer id;
    public String name;
    public String pass;
    public String description;
    public Integer role;

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
    
    public UserModel getUser(String login, String password)  throws SQLException{ 
        ResultSet result = DB.getResultSet("select * from users where name = '" + login +"' and pass = '" + password + "';");
        UserModel temp = new UserModel();
        while (result.next()) { 
            temp.setName(result.getString("name"));
            temp.setPass(result.getString("pass"));
            temp.setRole(result.getInt("role"));
            temp.setDescription(result.getString("description"));
        }
        return temp;
    }
    
    public UserModel getUser(String id)  throws SQLException{ 
        ResultSet result = DB.getResultSet("select * from users where id = '" + id +"';");
        UserModel temp = new UserModel();
        while (result.next()) { 
            temp.setName(result.getString("name"));
            temp.setPass(result.getString("pass"));
            temp.setRole(result.getInt("role"));
            temp.setDescription(result.getString("description"));
            temp.setId(Integer.parseInt(id));
        }
        return temp;
    }
    
    public Boolean isExistsUser(String login, String password) throws SQLException{
        ResultSet result = DB.getResultSet("select * from users where name = '" + login +"' and pass = '" + password + "';");
        return result.isBeforeFirst();
    }
    
    public String addUser(String username, String password, String role, String descr) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
         DB.runQuery("INSERT INTO users (name, pass, description, role) values ('"+username+"', '"+password+"', '"+descr+"', "+role+");");
         return "done";
    }
    
    public List<UserModel> getAllUsers()  throws SQLException{ 
        List<UserModel> usersList = new LinkedList();
        ResultSet result = DB.getResultSet("select * from users;");
        while (result.next()) { 
            UserModel temp = new UserModel();
            temp.setId(result.getInt("id"));
            temp.setName(result.getString("name"));
            temp.setRole(result.getInt("role"));
            temp.setDescription(result.getString("description"));
            usersList.add(temp);
        } 
        DB.closeCon();
        return usersList;
    }
    
    public String deleteUser(String id)  throws SQLException{ 
        DB.runQuery("DELETE FROM `users` WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
    
    public String editUser(String id, String name, String description, String role, String pass)  throws SQLException{ 
        DB.runQuery("UPDATE users SET name='"+name+"', pass='"+pass+"', description = '"+description+"', role = '"+role+"' WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
    
}
