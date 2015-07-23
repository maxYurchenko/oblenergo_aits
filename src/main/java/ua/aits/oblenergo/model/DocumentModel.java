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
public class DocumentModel {
    public Integer id;
    public String title;
    public String path;
    public Integer valid;
    public String date;
    public String clientId;
    public String uploader;
    public Integer parentId;
    public Integer size;
    public Integer viewNum;
    public String type;
    public String keywords;
    public String parentName;

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

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Integer getValid() {
        return valid;
    }

    public void setValid(Integer valid) {
        this.valid = valid;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getUploader() {
        return uploader;
    }

    public void setUploader(String uploader) {
        this.uploader = uploader;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public Integer getViewNum() {
        return viewNum;
    }

    public void setViewNum(Integer viewNum) {
        this.viewNum = viewNum;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }
    
    public List<DocumentModel> getDocumentRow(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = DB.getResultSet("select * from docs where parentId = "+id+";");
        List<DocumentModel> documentList = new LinkedList<>();
        while (result.next()) { 
            DocumentModel temp = new DocumentModel();
            temp.setId(result.getInt("id"));
            temp.setParentId(result.getInt("parentId"));
            temp.setTitle(result.getString("title"));
            temp.setPath(result.getString("path"));
            temp.setClientId(result.getString("clientId"));
            temp.setValid(result.getInt("valid"));
            temp.setParentName(SectionModel.getParent(temp.parentId.toString()));
            temp.setDate(result.getString("date"));
            documentList.add(temp);
        } 
        DB.closeCon();
    return documentList;
    }
    
    
    public List<DocumentModel> getAllDocuments() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = DB.getResultSet("select * from docs;");
        List<DocumentModel> documentList = new LinkedList<>();
        while (result.next()) { 
            DocumentModel temp = new DocumentModel();
            temp.setId(result.getInt("id"));
            temp.setParentId(result.getInt("parentId"));
            temp.setClientId(result.getString("clientId"));
            temp.setDate(result.getString("date"));
            temp.setTitle(result.getString("title"));
            temp.setPath(result.getString("path"));
            temp.setValid(result.getInt("valid"));
            temp.setParentName(SectionModel.getParent(temp.parentId.toString()));
            documentList.add(temp);
        } 
        DB.closeCon();
    return documentList;
    }
    
    public String addDocument(String id, String title, String section, String date, String file, String isValid, String uploader) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DB.runQuery("INSERT INTO docs (clientId, title, parentId, date, path, valid, uploader) "
                + "values ('"+id+"', '"+title+"', '"+section+"', '"+date+"', '"+file+"', '"+isValid+"', '"+uploader+"');");
        return "done";
    }
}
