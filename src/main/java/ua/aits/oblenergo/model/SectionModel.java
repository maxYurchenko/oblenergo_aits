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
        ResultSet result = DB.getResultSet("SELECT * FROM sections;");
        List<SectionModel> sections = new LinkedList<>();
        while (result.next()) { 
            SectionModel temp = new SectionModel();
            temp.setId(result.getInt("id"));
            temp.setParentId(result.getInt("parentId"));
            temp.setIsDelete(result.getInt("isDelete"));
            temp.setTitle(result.getString("title"));
            temp.setParentName(SectionModel.getSectionParent(temp.parentId.toString()));
            sections.add(temp);
        }
        DB.closeCon();
        return sections;
    }
    
    public List<SectionModel> getSectionRow(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = DB.getResultSet("select * from sections where parentId = "+id+";");
        List<SectionModel> menuList = new LinkedList<>();
        while (result.next()) { 
            SectionModel temp = new SectionModel();
            temp.setId(result.getInt("id"));
            temp.setParentId(result.getInt("parentId"));
            temp.setTitle(result.getString("title"));
            temp.setIsDelete(result.getInt("isDelete"));
            temp.setDocuments(Documents.getDocumentRow(temp.id.toString()));
            menuList.add(temp);
        } 
        DB.closeCon();
    return menuList;
    }
    
    public static String getParent(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = DB.getResultSet("select * from sections where id = "+id+";");
        result.first();
        String title = result.getString("title");
        DB.closeCon();
        return title;
    }
    
    public static String getSectionParent(String id) throws SQLException{
        ResultSet result = DB.getResultSet("select * from sections where id = "+id+";");
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
    
    public String addSection(String sectionName, String parentId) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
         DB.runQuery("INSERT INTO sections (title, parentId) values ('"+sectionName+"', '"+parentId+"');");
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
        temp.setParentName(SectionModel.getSectionParent(temp.parentId.toString()));
        DB.closeCon();
        return temp;
    }
    
    public SectionModel getSectionForBreadCrumbs(String id) throws SQLException{
        ResultSet result = DB.getResultSet("select * from sections where id = "+id+";");
        result.first();
        SectionModel temp = new SectionModel();
        temp.setId(result.getInt("id"));
        temp.setParentId(result.getInt("parentId"));
        temp.setIsDelete(result.getInt("isDelete"));
        temp.setTitle(result.getString("title"));
        temp.setParentName(SectionModel.getSectionParent(temp.parentId.toString()));
        DB.closeCon();
        return temp;
    }
    
    public String editSection(String id, String title, String parentId)  throws SQLException{ 
        DB.runQuery("UPDATE sections SET title='"+title+"', parentId='"+parentId+"' WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
    
    public String deleteSection(String id)  throws SQLException{ 
        DB.runQuery("UPDATE sections SET isDelete='1' WHERE id='"+id+"'");
        DB.closeCon();
        return "done";
    }
}
