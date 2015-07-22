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
    
    public Integer parentId;
    public DocumentModel Documents = new DocumentModel();
    
    public List<SectionModel> getAllSections() throws SQLException{
        ResultSet result = DB.getResultSet("SELECT * FROM sections;");
        List<SectionModel> sections = new LinkedList<>();
        while (result.next()) { 
            SectionModel temp = new SectionModel();
            temp.setId(result.getInt("id"));
            temp.setParentId(result.getInt("parentId"));
            temp.setTitle(result.getString("title"));
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
    
}
