/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.oblenergo.controller;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import ua.aits.oblenergo.functions.Constants;
import ua.aits.oblenergo.functions.DB;
import ua.aits.oblenergo.model.DocumentModel;
import ua.aits.oblenergo.model.SectionModel;
import ua.aits.oblenergo.model.UserGroupModel;
import ua.aits.oblenergo.model.UserModel;

/**
 *
 * @author skywalker
 */
@Controller
public class AjaxController {
    private Object session;
    DocumentModel document = new DocumentModel();
    SectionModel section = new SectionModel();
    UserGroupModel userGroup = new UserGroupModel();
    
    @RequestMapping(value = {"/getDocuments/", "/getDocuments"}, method = RequestMethod.GET)
        public @ResponseBody
        ResponseEntity<String> getDocuments(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        List<DocumentModel> documentList = new LinkedList<>();
        documentList = document.getDocumentRow(request.getParameter("id"));
        List<UserGroupModel> userGroups = new LinkedList<>();
        userGroups = userGroup.getAllGroups();
        List<String> groupArray = new LinkedList<>();
        for(UserGroupModel group : userGroups) {
            String[] userIds = group.userId.split(",");
            if(Arrays.asList(userIds).contains(request.getParameter("userId")))
                groupArray.add(group.id.toString());
        }
        String html = "<table id=\"table-pagination\" class=\"table table-striped table-bordered\" style=\"width:100%; \">\n" +
"                                <thead>"
                + "<tr class=\"tableHeader\">\n" +
"                                    <td style='width=\"width:130px\"'>Номер документа</td>\n" +
"                                    <td>Назва документа</td>		\n" +
"                                    <td>Тип документа</td>		\n" +
"                                    <td class='tableDate' style='width=\"width:50px\"'>Дата</td>\n" +
"                                    <td style='width=\"width:100px\"'>Завантажити</td>		\n" +
"                                </tr>\n"
                +"</thead><tfoot>"
                + "<tr><th style='width=\"width:130px\"'>Номер документа</td><th>Назва документа</td><th>Тип документа</td><th class='tableDate' style='width=\"width:50px\"'>Дата</td><th style='width=\"width:100px\"'></td></tr>"
                +"</tfoot><tbody>";
        for(DocumentModel tempDocs : documentList) {
            String clas = "";
            if(tempDocs.valid==0){
                clas = "inValidDoc";
            }
            Boolean c = false;
            String[] accessList = tempDocs.access.split(",");
            String[] acessGroupList = tempDocs.accessGroup.split(",");
            for(String temp : groupArray) {
                if(Arrays.asList(acessGroupList).contains(temp))
                   c = true; 
            }
            Boolean a = Arrays.asList(accessList).contains(request.getParameter("userId"));
            Boolean b = !request.getParameter("userRole").equals("0");
            if(a||b||c){
                if(tempDocs.isDelete!=1){
                    html = html +
                            "<tr id=\"tableTr"+tempDocs.id+"\" class=\"documentsTable "+clas+" display\">\n"+
                                "<td onclick='showDocument(\""+tempDocs.path+"\",\""+tempDocs.id+"\")'>"+tempDocs.clientId+"</td>\n"+
                                "<td onclick='showDocument(\""+tempDocs.path+"\",\""+tempDocs.id+"\")'>"+tempDocs.title+"</td>\n"+
                                "<td onclick='showDocument(\""+tempDocs.path+"\",\""+tempDocs.id+"\")'>"+tempDocs.type+"</td>\n"+	
                                "<td class='tableDate' onclick='showDocument(\""+tempDocs.path+","+tempDocs.id+"\")'>"+tempDocs.date.replace("/", ".")+"</td>\n"+
                                "<td class='downloadLink'><a target='_blank' download href='"+Constants.URL+tempDocs.path+"'>"+tempDocs.path.substring(6, tempDocs.path.length())+"</a></td>\n"+
                            "</tr>\n";
                }
            }
        }
        html = html + "</tbody></table>";
        DB.closeCon();
        response.setCharacterEncoding("UTF-8");
        HttpHeaders responseHeaders = new HttpHeaders(); 
        responseHeaders.add("Content-Type", "application/json; charset=utf-8");
        return new ResponseEntity<>(html, responseHeaders, HttpStatus.CREATED);
    }
        
    @RequestMapping(value = {"/makeBreadcrumbs/", "/makeBreadcrumbs"}, method = RequestMethod.GET)
        public @ResponseBody
        ResponseEntity<String> makeBreadcrumbs(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        SectionModel temp = section.getOneSection(request.getParameter("id"));
        String html = "<li class='activeBreadCrumb' onclick='getChildDocuments("+temp.id.toString()+")'>"+temp.title+"</li>";
        while(temp.parentId!=0){
            temp = section.getOneSection(temp.parentId.toString());
            html = "<li onclick='getChildDocuments("+temp.id.toString()+")'>"+temp.title+"</li> > " + html;
        }
        DB.closeCon();
        response.setCharacterEncoding("UTF-8");
        HttpHeaders responseHeaders = new HttpHeaders(); 
        responseHeaders.add("Content-Type", "application/json; charset=utf-8");
        return new ResponseEntity<>(html, responseHeaders, HttpStatus.CREATED);
    }
        
    @RequestMapping(value = {"/checkLoginPass/", "/checkLoginPass"}, method = RequestMethod.GET)
    public @ResponseBody
    String checkLoginPass(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        UserModel user = new UserModel();
        if(user.isExistsUser(request.getParameter("login"), request.getParameter("password"))) {
            return "true";
        }
        else {
            return "false";
        }
    }
    
    @RequestMapping(value = {"/deleteUser/", "/deleteUser"}, method = RequestMethod.GET)
    public @ResponseBody
    String deleteUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        UserModel user = new UserModel();
        user.deleteUser(request.getParameter("id"));
        return "done";
    }
    
    @RequestMapping(value = {"/deleteDoc/", "/deleteDoc"}, method = RequestMethod.GET)
    public @ResponseBody
    String deleteDoc(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        document.publishDocument(request.getParameter("id"), request.getParameter("publish"));
        return "done";
    }
    
    @RequestMapping(value = {"/isValidDocument/", "/isValidDocument"}, method = RequestMethod.GET)
    public @ResponseBody
    String isValidDocument(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        document.isValidDocument(request.getParameter("id"), request.getParameter("valid"));
        return "done";
    }
        
    @RequestMapping(value = {"/checkUsername/", "/checkUsername"}, method = RequestMethod.GET)
    public @ResponseBody
    String checkUsername(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        UserModel user = new UserModel();
        if(user.isExistsUser(request.getParameter("login"))) {
            //if (user.isExistsUser(request.getParameter("login")))
            return "true";
        }
        else {
            return "false";
        }
    }
        
    @RequestMapping(value = {"/checkGroupName/", "/checkGroupName"}, method = RequestMethod.GET)
    public @ResponseBody
    String checkGroupName(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        if(userGroup.checkAvailability(request.getParameter("title"))) {
            return "true";
        }
        else {
            return "false";
        }
    }
        
}
