/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.oblenergo.controller;

import java.util.LinkedList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import ua.aits.oblenergo.functions.Constants;
import ua.aits.oblenergo.functions.DB;
import ua.aits.oblenergo.model.DocumentModel;
import ua.aits.oblenergo.model.UserModel;

/**
 *
 * @author skywalker
 */
@Controller
public class AjaxController {
    @RequestMapping(value = {"/getDocuments/", "/getDocuments"}, method = RequestMethod.GET)
        public @ResponseBody
        String getDocuments(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        DocumentModel documents = new DocumentModel();
        List<DocumentModel> documentList = new LinkedList<>();
        documentList = documents.getDocumentRow(request.getParameter("id"));
        String html = "<table id=\"docInfoTable\" style=\"width:100%; \">\n" +
"                                <thead>"
                + "<tr>\n" +
"                                    <td>ID</td>\n" +
"                                    <td>Title</td>		\n" +
"                                    <td>Section</td>	\n" +
"                                    <td>Date</td>\n" +
"                                    <td>Donload</td>\n" +
"                                </tr>\n"
                +"</thead><tbody>";
        
        for(DocumentModel tempDocs : documentList) {
            String clas = "";
            if(tempDocs.valid==0){
                clas = "inValidDoc";
            }
            html = html +
                    "<tr id=\""+tempDocs.id+"\" class=\"documentsTable "+clas+" display\">\n"+
                        "<td onclick='showDocument(\""+tempDocs.path+"\")'>"+tempDocs.clientId+"</td>\n"+
                        "<td onclick='showDocument(\""+tempDocs.path+"\")'>"+tempDocs.title+"</td>\n"+		
                        "<td onclick='showDocument(\""+tempDocs.path+"\")'>"+tempDocs.parentName+"</td>\n"+
                        "<td onclick='showDocument(\""+tempDocs.path+"\")'>"+tempDocs.date+"</td>\n"+
                        "<td style='width: 20px;'><a href='"+Constants.URL+tempDocs.path+"' target=\"_blank\" download>\n"+
                        "<img style='width: 20px;margin-bottom: -3px;' src='"+Constants.URL+"img/dl.png'>"+
                        "</a></td>"+
                    "</tr>\n";
        }
        html = html + "</tbody></table>";
        DB.closeCon();
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
        DocumentModel document = new DocumentModel();
        document.publishDocument(request.getParameter("id"), request.getParameter("publish"));
        return "done";
    }
        
}
