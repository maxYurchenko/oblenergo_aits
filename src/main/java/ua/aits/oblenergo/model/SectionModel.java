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
import ua.aits.oblenergo.model.SectionModel;
import ua.aits.oblenergo.model.UserModel;

/**
 *
 * @author skywalker
 */
public class SectionModel {
    public Integer id;
    public String title;
    public List<DocumentModel> documents;
    public String parentName;
    public Integer parentId;
    public Integer isDelete;
    public String userAccess;
    public String groupAccess;
    public String users;
    public String groups;

    public String getGroups() {
        return groups;
    }

    public void setGroups(String groups) {
        this.groups = groups;
    }

    public String getUsers() {
        return users;
    }

    public void setUsers(String users) {
        this.users = users;
    }

    public String getUserAccess() {
        return userAccess;
    }

    public void setUserAccess(String userAccess) {
        this.userAccess = userAccess;
    }

    public String getGroupAccess() {
        return groupAccess;
    }

    public void setGroupAccess(String groupAccess) {
        this.groupAccess = groupAccess;
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
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

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }
    public List<DocumentModel> getDocuments() {
        return documents;
    }
    public void setDocuments(List<DocumentModel> documents) {
        this.documents = documents;
    }
    public DocumentModel Documents = new DocumentModel();
    
    public List<SectionModel> getAllSections() throws SQLException{
        ResultSet result = DB.getResultSet("SELECT * FROM sections WHERE isDelete<>1;");
        List<SectionModel> sections = new LinkedList<>();
        while (result.next()) { 
            SectionModel temp = new SectionModel();
            temp.setId(result.getInt("id"));
            temp.setParentId(result.getInt("parentId"));
            temp.setIsDelete(result.getInt("isDelete"));
            temp.setTitle(result.getString("title"));
            temp.setUserAccess(result.getString("userAccess"));
            temp.setGroupAccess(result.getString("groupAccess"));
            temp.setParentName(SectionModel.getSectionParent(temp.parentId.toString()));
            if(!temp.userAccess.equals("")){
                String[] temporary = temp.userAccess.split(",");
                String names = "";
                for(String str : temporary) {
                    try{
                        names += UserModel.getUsersName(str) + ", ";
                    }catch(Exception e){}
                }
                try{
                    names = names.substring(0, names.length()-2);
                }catch(Exception e){}
                names = names.replace(", ,", ", ");
                temp.setUsers(names);
            }
            if(!temp.groupAccess.equals("")){
                String[] temporary = temp.groupAccess.split(",");
                String title = "";
                for(String str : temporary) {
                    try{
                        title += UserGroupModel.getGroupTitle(str) + ", ";
                    }catch(Exception e){}
                }
                try{
                    title = title.substring(0, title.length()-2);
                }catch(Exception e){}
                title = title.replace(", ,", ", ");
                temp.setGroups(title);
            }
            sections.add(temp);
        }
        DB.closeCon();
        return sections;
    }
    
    public List<SectionModel> getSectionRow(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = DB.getResultSet("select * from sections where (parentId = "+id+") AND (isDelete<>1);");
        List<SectionModel> menuList = new LinkedList<>();
        while (result.next()) { 
            SectionModel temp = new SectionModel();
            temp.setId(result.getInt("id"));
            temp.setParentId(result.getInt("parentId"));
            temp.setTitle(result.getString("title"));
            temp.setIsDelete(result.getInt("isDelete"));
            temp.setUserAccess(result.getString("userAccess"));
            temp.setGroupAccess(result.getString("groupAccess"));
            temp.setDocuments(Documents.getDocumentRow(temp.id.toString()));
            menuList.add(temp);
        } 
        DB.closeCon();
    return menuList;
    }
    
    public static String getParent(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = DB.getResultSet("select * from sections where id = "+id+" AND (isDelete<>1);");
        result.first();
        String title = result.getString("title");
        DB.closeCon();
        return title;
    }
    
    public static String getSectionParent(String id) throws SQLException{
        ResultSet result = DB.getResultSet("select * from sections where id = "+id+" AND (isDelete<>1);");
        String title = "";
        if(id.equals("0")){
            title = "0";
        }else{
            result.first();
            title = result.getString("title");
        }
        DB.closeCon();
        return title;
    }
    
    public String addSection(String sectionName, String parentId, String users, String groups) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
         DB.runQuery("INSERT INTO sections (title, parentId, userAccess, groupAccess) values "
                 + "('"+sectionName+"', '"+parentId+"', '"+users+"', '"+groups+"');");
         DB.closeCon();
         return "done";
    }
    
    public SectionModel getOneSection(String id) throws SQLException{
        ResultSet result = DB.getResultSet("select * from sections where id = "+id+";");
        result.first();
        SectionModel temp = new SectionModel();
        temp.setId(result.getInt("id"));
        temp.setParentId(result.getInt("parentId"));
        temp.setIsDelete(result.getInt("isDelete"));
        temp.setTitle(result.getString("title"));
        temp.setUserAccess(result.getString("userAccess"));
        temp.setGroupAccess(result.getString("groupAccess"));
        temp.setParentName(SectionModel.getSectionParent(temp.parentId.toString()));
        DB.closeCon();
        return temp;
    }
    
    public SectionModel getSectionForBreadCrumbs(String id) throws SQLException{
        ResultSet result = DB.getResultSet("select * from sections where id = "+id+" AND (isDelete<>1);");
        result.first();
        SectionModel temp = new SectionModel();
        temp.setId(result.getInt("id"));
        temp.setParentId(result.getInt("parentId"));
        temp.setIsDelete(result.getInt("isDelete"));
        temp.setTitle(result.getString("title"));
        temp.setUserAccess(result.getString("userAccess"));
        temp.setGroupAccess(result.getString("groupAccess"));
        temp.setParentName(SectionModel.getSectionParent(temp.parentId.toString()));
        DB.closeCon();
        return temp;
    }
    
    public String editSection(String id, String title, String parentId, String users, String groups)  throws SQLException{ 
        DB.runQuery("UPDATE sections SET title='"+title+"', parentId='"+parentId+"', userAccess='"+users+"', groupAccess='"+groups+"' WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
    
    public String deleteSection(String id)  throws SQLException{ 
        DB.runQuery("UPDATE sections SET isDelete='1' WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
}
