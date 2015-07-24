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
    
    @RequestMapping(value = {"/getDocuments/", "/getDocuments"}, method = RequestMethod.GET)
        public @ResponseBody
        String getDocuments(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        List<DocumentModel> documentList = new LinkedList<>();
        documentList = document.getDocumentRow(request.getParameter("id"));
        String html = "<table id=\"docInfoTable\" style=\"width:100%; \">\n" +
"                                <thead>"
                + "<tr>\n" +
"                                    <td>#</td>\n" +
"                                    <td>Title</td>		\n" +
"                                    <td>Section</td>	\n" +
"                                    <td>Date</td>\n" +
"                                </tr>\n"
                +"</thead><tbody>";
        for(DocumentModel tempDocs : documentList) {
            String clas = "";
            if(tempDocs.valid==0){
                clas = "inValidDoc";
            }
            if(tempDocs.isDelete!=1){
                html = html +
                        "<tr id=\""+tempDocs.id+"\" class=\"documentsTable "+clas+" display\">\n"+
                            "<td><a target='_blank' download href='"+Constants.URL+tempDocs.path+"'>"+tempDocs.clientId+"</a></td>\n"+
                            "<td onclick='showDocument(\""+tempDocs.path+"\")'>"+tempDocs.title+"</td>\n"+		
                            "<td onclick='showDocument(\""+tempDocs.path+"\")'>"+tempDocs.parentName+"</td>\n"+
                            "<td onclick='showDocument(\""+tempDocs.path+"\")'>"+tempDocs.date+"</td>\n"+
                        "</tr>\n";
            }
        }
        html = html + "</tbody></table>";
        DB.closeCon();
        HttpHeaders responseHeaders = new HttpHeaders(); 
        responseHeaders.add("Content-Type", "application/json; charset=utf-8");
        return html;
    }
        
    @RequestMapping(value = {"/makeBreadcrumbs/", "/makeBreadcrumbs"}, method = RequestMethod.GET)
        public @ResponseBody
        String makeBreadcrumbs(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        SectionModel temp = section.getOneSection(request.getParameter("id"));
        String html = "<li class='activeBreadCrumb' onclick='getChildDocuments("+temp.id.toString()+")'>"+temp.title+"</li>";
        while(temp.parentId!=0){
            temp = section.getOneSection(temp.parentId.toString());
            html = "<li onclick='getChildDocuments("+temp.id.toString()+")'>"+temp.title+"</li> > " + html;
        }
        return html;
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
        
}
