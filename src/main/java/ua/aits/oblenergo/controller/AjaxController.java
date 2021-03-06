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
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        List<UserGroupModel> userGroups = new LinkedList<>();
        userGroups = userGroup.getAllGroups();
        Boolean isAdmin = !request.getParameter("userRole").equals("0");
        HttpHeaders responseHeaders = new HttpHeaders(); 
        responseHeaders.add("Content-Type", "application/json; charset=utf-8");
        if(request.getParameter("id").equals("0")){
            List<DocumentModel> documentList = new LinkedList<>();
            documentList = document.getAllDocuments();
            String html = "<table id=\"table-pagination\" class=\"table table-bordered\">\n" +
    "                                <thead>"
                    + "<tr class=\"tableHeader\">\n" +
    "                                    <th style='width:160px'>Тип документа</th>		\n" +
    "                                    <th style='width:260px'>Назва документа</th>		\n" +
    "                                    <th style='width:160px'>Номер документа</th>\n" +
    "                                    <th class='tableDate' style='width:50px'>Дата</th>\n" +
    "                                    <th>Ключові слова</th>		\n" +
    "                                    <th style='width=\"width:20px\"'></th>		\n" +
    "                                </tr>\n"
                    +"</thead><tfoot>"
                    + "<tr><th data-column-index=\"0\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\">типу документа</th>"
                    + "<th data-column-index=\"1\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\">назві документа</th>"
                    + "<th data-column-index=\"2\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\">номеру документа</th>"
                    + "<th data-column-index=\"4\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" class='tableDate'>даті</th>"
                    + "<th data-column-index=\"5\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\">ключовим словам</th>"
                    + "<th data-column-index=\"6\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\"></th></tr>"
                    +"</tfoot><tbody>";
            for(DocumentModel tempDocs : documentList) {
                    String clas = "";
                    if(tempDocs.valid==0){
                        clas = "inValidDoc";
                    }
                    /*
                SectionModel currentSection = new SectionModel();
                currentSection = section.getOneSection(tempDocs.parentId.toString());
                String[] sectionAllowedUsers = currentSection.userAccess.split(",");
                String[] sectionAllowedGroups = currentSection.groupAccess.split(",");
                    */
                String[] accessList = tempDocs.access.split(",");
                //Boolean isUserAllowedForSection = false;
                //Boolean isGroupAllowedForSection = false;
                List<String> groupArray = new LinkedList<>();
                Boolean isAllowedByGroup = false;
                String[] acessGroupList = tempDocs.accessGroup.split(",");
                //isUserAllowedForSection = Arrays.asList(sectionAllowedUsers).contains(request.getParameter("userId"));
                for(UserGroupModel group : userGroups) {
                    String[] userIds = group.userId.split(",");
                    if(Arrays.asList(userIds).contains(request.getParameter("userId")))
                    {
                        groupArray.add(group.id.toString());
                        /*
                        if(!sectionAllowedGroups[0].equals(""))
                            for(String str : sectionAllowedGroups)
                                if(group.id==Integer.parseInt(str))
                                    isGroupAllowedForSection = true;
                        */
                    }
                }
                for(String temp : groupArray) {
                        if(Arrays.asList(acessGroupList).contains(temp))
                           isAllowedByGroup = true; 
                    }
                Boolean isAllowedByID = Arrays.asList(accessList).contains(request.getParameter("userId"));
                Boolean showDoc = isAllowedByID||isAdmin||isAllowedByGroup;
                //Boolean showDoc = isAllowedByID||isAdmin||isAllowedByGroup||isGroupAllowedForSection||isUserAllowedForSection;
                if(showDoc){
                    if(tempDocs.isDelete!=1){
                        html = html +
                                    "<tr id=\"tableTr"+tempDocs.id+"\" class=\"documentsTable display "+clas+"\">\n"+
                                        "<th data-column-index=\"0\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" onclick='showDocument(\""+tempDocs.path+"\",\""+tempDocs.id+"\")'>"+tempDocs.type+"</th>\n"+	
                                        "<th data-column-index=\"1\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" onclick='showDocument(\""+tempDocs.path+"\",\""+tempDocs.id+"\")'>"+tempDocs.title+"</th>\n"+
                                        "<th data-column-index=\"2\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" onclick='showDocument(\""+tempDocs.path+"\",\""+tempDocs.id+"\")'>"+tempDocs.clientId+"</th>\n"+
                                        "<th data-column-index=\"4\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" class='tableDate' onclick='showDocument(\""+tempDocs.path+","+tempDocs.id+"\")'>"+tempDocs.date.replace("/", ".")+"</th>\n"+
                                        "<th data-column-index=\"5\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" onclick='showDocument(\""+tempDocs.path+"\",\""+tempDocs.id+"\")'>"+tempDocs.tags+"</th>"+
                                        "<th data-column-index=\"6\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" class='downloadLink'><a target='_blank' download href='"+Constants.URL+tempDocs.path+"'><img style=\"width: 20px;\" src=\""+Constants.URL+"img/dl.png\"></a></th>\n"+
                                    "</tr>\n";
                    }
                }
            }
            html = html + "</tbody>";
            return new ResponseEntity<>(html, responseHeaders, HttpStatus.CREATED);
        }
        else{
            List<DocumentModel> documentList = new LinkedList<>();
            List<DocumentModel> alldocumentsList = new LinkedList<>();
            alldocumentsList = document.getAllDocuments();
            //documentList = document.getDocumentRow(request.getParameter("id"));
            for(DocumentModel tempDocs : alldocumentsList) {
                //if(Arrays.asList(tempDocs.parentId).toString().toLowerCase().contains(request.getParameter("id").toLowerCase()))
                if( Arrays.asList(tempDocs.parentId).toString().contains(request.getParameter("id").toLowerCase()))
                    documentList.add(tempDocs);
            }
            SectionModel currentSection = new SectionModel();
            currentSection = section.getOneSection(request.getParameter("id"));
            String[] sectionAllowedUsers = currentSection.userAccess.split(",");
            String[] sectionAllowedGroups = currentSection.groupAccess.split(",");
            //Boolean isUserAllowedForSection = false;
            //Boolean isGroupAllowedForSection = false;
            List<String> groupArray = new LinkedList<>();
            for(UserGroupModel group : userGroups) {
                String[] userIds = group.userId.split(",");
                if(Arrays.asList(userIds).contains(request.getParameter("userId")))
                {
                    groupArray.add(group.id.toString());
                    /*
                    if(!sectionAllowedGroups[0].equals(""))
                        for(String str : sectionAllowedGroups)
                            if(group.id==Integer.parseInt(str))
                                isGroupAllowedForSection = true;
                            */
                }
            }
            //isUserAllowedForSection = Arrays.asList(sectionAllowedUsers).contains(request.getParameter("userId"));
            String html = "<table id=\"table-pagination\" class=\"table table-striped table-bordered\">\n" +
    "                                <thead>"
                    + "<tr class=\"tableHeader\">\n" +
    "                                    <th style='width:160px'>Тип документа</th>		\n" +
    "                                    <th style='width:260px'>Назва документа</th>		\n" +
    "                                    <th style='width:160px'>Номер документа</th>\n" +
    "                                    <th class='tableDate' style='width:50px'>Дата</th>\n" +
    "                                    <th>Ключові слова</th>		\n" +
    "                                    <th style='width=\"width:20px\"'></th>		\n" +
    "                                </tr>\n"
                    +"</thead><tfoot>"
                    + "<tr><th data-column-index=\"0\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\">типу документа</th>"
                    + "<th data-column-index=\"1\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\">назві документа</th>"
                    + "<th data-column-index=\"2\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\">номеру документа</th>"
                    + "<th data-column-index=\"3\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" class='tableDate'>даті</th>"
                    + "<th data-column-index=\"4\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\">ключовим словам</th>"
                    + "<th data-column-index=\"5\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\"></th></tr>"
                    +"</tfoot><tbody>";
            //if(isGroupAllowedForSection||isAdmin||isUserAllowedForSection){
                for(DocumentModel tempDocs : documentList) {
                    String clas = "";
                    if(tempDocs.valid==0){
                        clas = "inValidDoc";
                    }
                    Boolean isAllowedByGroup = false;
                    String[] accessList = tempDocs.access.split(",");
                    String[] acessGroupList = tempDocs.accessGroup.split(",");
                    for(String temp : groupArray) {
                        if(Arrays.asList(acessGroupList).contains(temp))
                           isAllowedByGroup = true; 
                    }
                    Boolean isAllowedByID = Arrays.asList(accessList).contains(request.getParameter("userId"));
                    Boolean showDoc = false;
                    //showDoc = isAllowedByID||isAdmin||isAllowedByGroup||isGroupAllowedForSection||isUserAllowedForSection;
                    showDoc = isAllowedByID||isAdmin||isAllowedByGroup;
                    if(showDoc){
                        if(tempDocs.isDelete!=1){
                            html = html +
                                    "<tr id=\"tableTr"+tempDocs.id+"\" class=\"documentsTable "+clas+" display\">\n"+
                                        "<th data-column-index=\"0\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" onclick='showDocument(\""+tempDocs.path+"\",\""+tempDocs.id+"\")'>"+tempDocs.type+"</th>\n"+	
                                        "<th data-column-index=\"1\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" onclick='showDocument(\""+tempDocs.path+"\",\""+tempDocs.id+"\")'>"+tempDocs.title+"</th>\n"+
                                        "<th data-column-index=\"2\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" onclick='showDocument(\""+tempDocs.path+"\",\""+tempDocs.id+"\")'>"+tempDocs.clientId+"</th>\n"+
                                        "<th data-column-index=\"3\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" class='tableDate' onclick='showDocument(\""+tempDocs.path+","+tempDocs.id+"\")'>"+tempDocs.date.replace("/", ".")+"</th>\n"+
                                        "<th data-column-index=\"4\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" onclick='showDocument(\""+tempDocs.path+"\",\""+tempDocs.id+"\")'>"+tempDocs.tags+"</th>"+
                                        "<th data-column-index=\"5\" class=\"sorting\" tabindex=\"0\" aria-controls=\"table-pagination\" rowspan=\"1\" colspan=\"1\" class='downloadLink'><a target='_blank' download href='"+Constants.URL+tempDocs.path+"'><img style=\"width: 20px;\" src=\""+Constants.URL+"img/dl.png\"></a></th>\n"+
                                    "</tr>\n";
                        }
                    }
                }
            //}
            html = html + "</tbody></table>";
            DB.closeCon();
            return new ResponseEntity<>(html, responseHeaders, HttpStatus.CREATED);
        }
    }
        
    @RequestMapping(value = {"/makeBreadcrumbs/", "/makeBreadcrumbs"}, method = RequestMethod.GET)
        public @ResponseBody
        ResponseEntity<String> makeBreadcrumbs(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        HttpHeaders responseHeaders = new HttpHeaders(); 
        responseHeaders.add("Content-Type", "application/json; charset=utf-8");
        if(request.getParameter("id").equals("0"))
            return new ResponseEntity<>("<li class='activeBreadCrumb'>Всі документи</li>", responseHeaders, HttpStatus.CREATED);
        else{
            request.setCharacterEncoding("UTF-8");
            SectionModel temp = section.getOneSection(request.getParameter("id"));
            String html = "<li class='activeBreadCrumb' onclick='getChildDocuments("+temp.id.toString()+")'>"+temp.title+"</li>";
            while(temp.parentId!=0){
                temp = section.getOneSection(temp.parentId.toString());
                html = "<li onclick='getChildDocuments("+temp.id.toString()+")'>"+temp.title+"</li> > " + html;
            }
            DB.closeCon();
            return new ResponseEntity<>(html, responseHeaders, HttpStatus.CREATED);
        }
    }
        
    @RequestMapping(value = {"/checkLoginPass/", "/checkLoginPass"}, method = RequestMethod.GET)
    public @ResponseBody
    String checkLoginPass(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        UserModel user = new UserModel();
        if(user.isExistsUser(request.getParameter("login"), request.getParameter("password"))) {
            DB.closeCon();
            return "true";
        }
        else {
            DB.closeCon();
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
            DB.closeCon();
            return "true";
        }
        else {
            DB.closeCon();
            return "false";
        }
    }
        
    @RequestMapping(value = {"/checkUsernameEdit/", "/checkUsernameEdit"}, method = RequestMethod.GET)
    public @ResponseBody
    String checkUsernameEdit(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        UserModel user = new UserModel();
        return user.countUsersByName(request.getParameter("login"));
    }
        
    @RequestMapping(value = {"/nextAI"}, method = RequestMethod.GET)
    public @ResponseBody
    String nextAI(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        String temp = document.getNextAI().toString();
        DB.closeCon();
        return temp;
    }
        
    @RequestMapping(value = {"/checkGroupName/", "/checkGroupName"}, method = RequestMethod.GET)
    public @ResponseBody
    String checkGroupName(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        if(userGroup.checkAvailability(request.getParameter("title"))) {
            DB.closeCon();
            return "true";
        }
        else {
            DB.closeCon();
            return "false";
        }
    }
        
    @RequestMapping(value = {"/getSortedDocuments/", "/getSortedDocuments"}, method = RequestMethod.GET)
    public @ResponseBody
    ResponseEntity<String> getSortedDocuments(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpHeaders responseHeaders = new HttpHeaders(); 
        responseHeaders.add("Content-Type", "application/json; charset=utf-8");
        List<SectionModel> sortedSections = new LinkedList<>();
        sortedSections = section.getAllSectionsSorted(request.getParameter("sort"));
        String html = "";
        for(SectionModel currentSection : sortedSections){
            String[] sectionAllowedUsers = currentSection.userAccess.split(",");
            String[] sectionAllowedGroups = currentSection.groupAccess.split(",");
            Boolean isUserAllowedForSection = Arrays.asList(sectionAllowedUsers).contains(request.getParameter("userId"));
            Boolean isGroupAllowedForSection = false;
            Boolean isAdmin = !request.getParameter("userRole").equals("0");
            List<UserGroupModel> userGroups = new LinkedList<>();
            userGroups = userGroup.getAllGroups();
            for(UserGroupModel group : userGroups) {
                    String[] userIds = group.userId.split(",");
                    if(Arrays.asList(userIds).contains(request.getParameter("userId")))
                    {
                        if(!sectionAllowedGroups[0].equals(""))
                            for(String str : sectionAllowedGroups)
                                if(group.id==Integer.parseInt(str))
                                    isGroupAllowedForSection = true;
                    }
                }
            if(isGroupAllowedForSection||isUserAllowedForSection||isAdmin){
                html += "<li class=\"section collapsed\" value=\""+currentSection.id+"\" id=\""+currentSection.id+"\" "
                        + "onclick=\"getChildDocuments("+currentSection.id+")\">"+currentSection.title+"<ul style=\"display: none;\"></ul></li>\n";
            }
        }
        DB.closeCon();
        return new ResponseEntity<>(html, responseHeaders, HttpStatus.CREATED);
    }
        
}
