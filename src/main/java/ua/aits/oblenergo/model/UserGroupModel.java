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
import ua.aits.oblenergo.functions.Helpers;

/**
 *
 * @author skywalker
 */
public class UserGroupModel {
    public Integer id;
    public String title;
    public String userId;
    public String users;

    public String getUsers() {
        return users;
    }

    public void setUsers(String users) {
        this.users = users;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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
    
    public String addUserGroups(String title, String access) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = null;
        Integer temp = null;
        try{
            DB.runQuery("INSERT INTO userGroups (title, userId) values ('"+title+"', '"+access+"');");
            result = DB.getResultSet("select * from userGroups where title = '" + title +"';");
            result.first();
            temp = result.getInt("id");
        }
        finally{
            result.close();
            DB.closeCon();
        }
        return temp.toString();
    }
    
    public List<UserGroupModel> getAllGroups()  throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException{ 
        List<UserGroupModel> groupList = null;
        ResultSet result = null;
        try{
            groupList = new LinkedList();
            result = DB.getResultSet("select * from userGroups order by title;");
            while (result.next()) { 
                UserGroupModel temp = new UserGroupModel();
                temp.setId(result.getInt("id"));
                temp.setTitle(result.getString("title"));
                temp.setUserId(result.getString("userId"));
                groupList.add(temp);
            } 
        }
        finally{
            result.close();
            DB.closeCon();
        }
        for(UserGroupModel temp : groupList){
            if(!temp.userId.equals("")){
                String[] temporary = temp.userId.split(",");
                String names = "";
                for(String str : temporary) {
                    names += UserModel.getUsersName(str) + ", ";
                }
                names = Helpers.removeComas(names);
                temp.setUsers(names);
            }
        }
        DB.closeCon();
        return groupList;
    }
    
    public String editGroup(String id, String title, String userId)  throws SQLException{ 
        DB.runQuery("UPDATE userGroups SET title='"+title+"', userId='"+userId+"' WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
    
    public Boolean checkAvailability(String title)  throws SQLException{ 
        ResultSet result = null;
        Boolean temp = null;
        try{
            result = DB.getResultSet("select * from userGroups where title = '" + title +"';");
            temp = result.isBeforeFirst();
        }
        finally{
            result.close();
            DB.closeCon();
        }
        return temp;
    }
    
    public String deleteGroup(String id)  throws SQLException{ 
        DB.runQuery("DELETE FROM `userGroups` WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
    
    public UserGroupModel getOneGroup(String id)  throws SQLException{ 
        ResultSet result = null;
        UserGroupModel temp = null;
        try{
            result = DB.getResultSet("SELECT * FROM `userGroups` WHERE id='"+id+"'");
            temp = new UserGroupModel();
            result.first();
            temp.setId(result.getInt("id"));
            temp.setTitle(result.getString("title"));
            temp.setUserId(result.getString("userId"));
            DB.closeCon();
            if(!temp.userId.equals("")){
                String[] temporary = temp.userId.split(",");
                String names = "";
                for(String str : temporary) {
                    names += UserModel.getUsersName(str) + ", ";
                }
                names = names.substring(0, names.length()-2);
                temp.setUsers(names);
            }
        }
        finally{
            result.close();
            DB.closeCon();
        }
        return temp;
    }
    
    public static String getGroupTitle(String id)  throws SQLException{ 
        ResultSet result = null;
        String name = "";
        try{
            result = DB.getResultSet("select * from userGroups WHERE id='"+id+"';");
            try{
                result.first();
                name = result.getString("title");
            }catch(Exception e){}
        }
        finally{
            result.close();
            DB.closeCon();
        }
        return name;
    }
}
