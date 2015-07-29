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
public class UserGroupModel {
    public Integer id;
    public String title;
    public String users;

    public String getUsers() {
        return users;
    }

    public void setUsers(String users) {
        this.users = users;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    
    public String addUserGroups(String title) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DB.runQuery("INSERT INTO userGroups (title) values ('"+title+"');");
        ResultSet result = DB.getResultSet("select * from userGroups where title = '" + title +"';");
        result.first();
        Integer temp = result.getInt("id");
        return temp.toString();
    }
    
    public List<UserGroupModel> getAllGroups()  throws SQLException{ 
        List<UserGroupModel> groupList = new LinkedList();
        ResultSet result = DB.getResultSet("select * from userGroups;");
        while (result.next()) { 
            UserGroupModel temp = new UserGroupModel();
            temp.setId(result.getInt("id"));
            temp.setTitle(result.getString("title"));
            temp.setUsers(UserModel.getUsersForGroup(temp.id.toString()));
            groupList.add(temp);
        } 
        return groupList;
    }
    
    public Boolean checkAvailability(String title)  throws SQLException{ 
        ResultSet result = DB.getResultSet("select * from userGroups where title = '" + title +"';");
        return result.isBeforeFirst();
    }
    
    public String deleteGroup(String id)  throws SQLException{ 
        DB.runQuery("DELETE FROM `userGroups` WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
}
