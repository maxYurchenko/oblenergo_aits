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
    public String parentId;
    public Integer size;
    public Integer viewNum;
    public String type;
    public String keywords;
    public String parentName;
    public String access;
    public Integer isDelete;
    public String accessGroup;
    public String tags;
    public String users;

    public String getUsers() {
        return users;
    }

    public void setUsers(String users) {
        this.users = users;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getAccessGroup() {
        return accessGroup;
    }

    public void setAccessGroup(String accessGroup) {
        this.accessGroup = accessGroup;
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

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
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

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
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

    public String getAccess() {
        return access;
    }

    public void setAccess(String access) {
        this.access = access;
    }
    
    public List<DocumentModel> getDocumentRow(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = null;
        List<DocumentModel> documentList = null;
        try{
            result = DB.getResultSet("select * from docs where parentId = "+id+";");
            documentList = new LinkedList<>();
            while (result.next()) { 
                DocumentModel temp = new DocumentModel();
                temp.setId(result.getInt("id"));
                temp.setParentId(result.getString("parentId"));
                temp.setTitle(result.getString("title"));
                temp.setPath(result.getString("path"));
                temp.setClientId(result.getString("clientId"));
                temp.setValid(result.getInt("valid"));
                //temp.setParentName(SectionModel.getParent(temp.parentId.toString()));
                temp.setIsDelete(result.getInt("isDelete"));
                temp.setDate(result.getString("date").replace(",","."));
                temp.setDate(temp.date.replace("/", "."));
                temp.setAccess(result.getString("access"));
                temp.setAccessGroup(result.getString("groups"));
                temp.setUploader(result.getString("uploader"));
                temp.setType(result.getString("type").replace(",",", "));
                temp.setTags(result.getString("tags").replace(",",", "));
                documentList.add(temp);
            } 
        }
        finally{
            result.close();
            DB.closeCon();
        }
    return documentList;
    }
    
    
    public List<DocumentModel> getAllDocuments() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = null;
        List<DocumentModel> documentList = null;
        try{
            result = DB.getResultSet("select * from docs;");
            documentList = new LinkedList<>();
            while (result.next()) { 
                DocumentModel temp = new DocumentModel();
                temp.setId(result.getInt("id"));
                temp.setParentId(result.getString("parentId"));
                temp.setClientId(result.getString("clientId"));
                temp.setDate(result.getString("date"));
                temp.setTitle(result.getString("title"));
                temp.setPath(result.getString("path"));
                temp.setValid(result.getInt("valid"));
                temp.setDate(result.getString("date").replace(",","."));
                temp.setDate(temp.date.replace("/", "."));
                temp.setIsDelete(result.getInt("isDelete"));
                //temp.setParentName(SectionModel.getParent(temp.parentId.toString()));
                temp.setAccess(result.getString("access"));
                temp.setAccessGroup(result.getString("groups"));
                temp.setUploader(result.getString("uploader"));
                temp.setType(result.getString("type").replace(",",", "));
                temp.setTags(result.getString("tags").replace(",",", "));
                documentList.add(temp);
            } 
        }
        finally{
            result.close();
            DB.closeCon();
        }
    return documentList;
    }
    
    
    public DocumentModel getOneDocument(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = null;
        DocumentModel temp = null;
        try{
            result = DB.getResultSet("select * from docs where id='"+id+"';");
            result.first();
            temp = new DocumentModel();
            temp.setId(result.getInt("id"));
            temp.setParentId(result.getString("parentId"));
            temp.setClientId(result.getString("clientId"));
            temp.setDate(result.getString("date"));
            temp.setTitle(result.getString("title"));
            temp.setPath(result.getString("path"));
            temp.setValid(result.getInt("valid"));
            temp.setIsDelete(result.getInt("isDelete"));
            temp.setDate(result.getString("date").replace(",","."));
            temp.setDate(temp.date.replace("/", "."));
            //temp.setParentName(SectionModel.getParent(temp.parentId.toString()));
            temp.setAccess(result.getString("access"));
            temp.setAccessGroup(result.getString("groups"));
            temp.setUploader(result.getString("uploader"));
            temp.setType(result.getString("type").replace(",",", "));
            temp.setTags(result.getString("tags").replace(",",", "));
        }
        finally{
            result.close();
            DB.closeCon();
        }
    return temp;
    }
    
    public String addDocument(String id, String title, String section, String date, String file, String isValid, String uploader, String access, String groups, String type, String tags) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DB.runQuery("INSERT INTO docs (clientId, title, parentId, date, path, valid, uploader, access, groups, type, tags) "
                + "values ('"+id+"', '"+title+"', '"+section+"', '"+date+"', '"+file+"', '"+isValid+"', '"+uploader+"', '"+access+"', '"+groups+"', '"+type+"', '"+tags+"');");
        DB.closeCon();
        return "done";
    }
    
    public String editDocument(String id, String clientId, String title, String section, String date, String file, String isValid, String uploader, String access, String groups, String type, String tags) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DB.runQuery("UPDATE docs SET clientId='"+clientId+"', title='"+title+"', parentId='"+section+"', date='"+date+"', "
                + "path='"+file+"', valid='"+isValid+"', uploader='"+uploader+"', access='"+access+"'"
                + ", groups='"+groups+"', type='"+type+"', tags='"+tags+"' WHERE id='"+id+"';");
        DB.closeCon();
        return "done";
    }
    
    public String publishDocument(String id, String publish) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DB.runQuery("UPDATE docs SET isDelete='"+publish+"' WHERE id='"+id+"';");
        DB.closeCon();
        return "done";
    }
    
    public String isValidDocument(String id, String valid) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DB.runQuery("UPDATE docs SET valid='"+valid+"' WHERE id='"+id+"';");
        DB.closeCon();
        return "done";
    }
    
    public Integer getNextAI() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        ResultSet result = null;
        Integer ai = null;
        try{
            result = DB.getResultSet("SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA =  \"oblenergo\" AND TABLE_NAME =  \"docs\";");
            result.first();
            ai = result.getInt("AUTO_INCREMENT");
        }
        finally{
            result.close();
            DB.closeCon();
        }
        return ai;
    }
}
