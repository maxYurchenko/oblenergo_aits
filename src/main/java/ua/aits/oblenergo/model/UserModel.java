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
    public Integer groupAccess;
    public String fullName;

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Integer getGroupAccess() {
        return groupAccess;
    }

    public void setGroupAccess(Integer groupAccess) {
        this.groupAccess = groupAccess;
    }

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
            temp.setId(result.getInt("id"));
            temp.setPass(result.getString("pass"));
            temp.setRole(result.getInt("role"));
            temp.setGroupAccess(result.getInt("groupId"));
            temp.setDescription(result.getString("description"));
            temp.setFullName(result.getString("fullName"));
        }
        DB.closeCon();
        return temp;
    }
    
    public UserModel getUser(String id)  throws SQLException{ 
        ResultSet result = DB.getResultSet("select * from users where id = '" + id +"';");
        UserModel temp = new UserModel();
        while (result.next()) { 
            temp.setName(result.getString("name"));
            temp.setPass(result.getString("pass"));
            temp.setRole(result.getInt("role"));
            temp.setGroupAccess(result.getInt("groupId"));
            temp.setDescription(result.getString("description"));
            temp.setFullName(result.getString("fullName"));
            temp.setId(Integer.parseInt(id));
        }
        DB.closeCon();
        return temp;
    }
    
    public Boolean isExistsUser(String login, String password) throws SQLException{
        ResultSet result = DB.getResultSet("select * from users where name = '" + login +"' and pass = '" + password + "';");
        //DB.closeCon();
        return result.isBeforeFirst();
    }
    
    public Boolean isExistsUser(String login) throws SQLException{
        ResultSet result = DB.getResultSet("select * from users where name = '" + login +"';");
        //DB.closeCon();
        return result.isBeforeFirst();
    }
    
    public String addUser(String username, String password, String role, String descr, String fullName) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
         DB.runQuery("INSERT INTO users (name, pass, description, role, fullName) values ('"+username+"', '"+password+"', '"+descr+"', "+role+", '"+fullName+"');");
        DB.closeCon();
         return "done";
    }
    
    public List<UserModel> getAllUsers()  throws SQLException{ 
        List<UserModel> usersList = new LinkedList();
        ResultSet result = DB.getResultSet("select * from users order by name;");
        while (result.next()) { 
            UserModel temp = new UserModel();
            temp.setId(result.getInt("id"));
            temp.setName(result.getString("name"));
            temp.setRole(result.getInt("role"));
            temp.setGroupAccess(result.getInt("groupId"));
            temp.setDescription(result.getString("description"));
            temp.setFullName(result.getString("fullName"));
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
    
    public String editUser(String id, String name, String description, String role, String pass, String fullName)  throws SQLException{ 
        DB.runQuery("UPDATE users SET name='"+name+"', pass='"+pass+"', description = '"+description+"', role = '"+role+"', fullName = '"+fullName+"' WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
    
    public String addUserGroup(String id, String groupId)  throws SQLException{ 
        DB.runQuery("UPDATE users SET groupId='"+groupId+"' WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
    
    public static String getUsersForGroup(String groupId)  throws SQLException{ 
        ResultSet result = DB.getResultSet("select * from users WHERE groupId='"+groupId+"';");
        String names = "";
        while (result.next()) { 
            names = names + result.getString("name") + ", ";
        }
        if(names.length()>2)
            names = names.substring(0, names.length()-2);
        DB.closeCon();
        return names;
    }
    
    public static String getUsersName(String id)  throws SQLException{ 
        ResultSet result = DB.getResultSet("select * from users WHERE id='"+id+"';");
        String name = "";
        try{
            result.first();
            name = result.getString("name");
        }catch (Exception e){
        }
        DB.closeCon();
        return name;
    }
    
    public String groupDeleted(String groupId) throws SQLException{ 
        DB.runQuery("UPDATE users SET groupId='0' WHERE groupId='"+groupId+"'");
        DB.closeCon();
        return "done";
    }
    
    public String countUsersByName(String name) throws SQLException{
        Integer counter = 0;
        ResultSet result = DB.getResultSet("select * from users where name = '" + name +"';");
        while (result.next()) { 
            counter++;
        }
        DB.closeCon();
        if(counter>1){
            return "false";
        }else{
            return "true";
        }
    }
} 
