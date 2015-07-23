/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.oblenergo.controller;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import ua.aits.oblenergo.model.DocumentModel;
import ua.aits.oblenergo.model.SectionModel;
import ua.aits.oblenergo.model.UserModel;

/**
 *
 * @author skywalker
 */
@Controller
public class AdminContontroller {
    UserModel user = new UserModel();
    DocumentModel document = new DocumentModel();
    @RequestMapping(value = {"/admin"}, method = RequestMethod.GET)
    protected ModelAndView admin(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                ModelAndView modelAndView = new ModelAndView("admin/index");
                List<SectionModel> sections = new LinkedList();
                SectionModel sectionClass = new SectionModel();
                sections = sectionClass.getAllSections();
                modelAndView.addObject("sections", sections);
                 return modelAndView;
	}
    @RequestMapping(value = {"/admin/addUser"}, method = RequestMethod.GET)
    protected ModelAndView addUser(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                 ModelAndView modelAndView = new ModelAndView("admin/addUser");
                 modelAndView.addObject("users", user.getAllUsers());
                 return modelAndView;
	}
    @RequestMapping(value = {"/admin/editUser/{id}"}, method = RequestMethod.GET)
    protected ModelAndView editUser(HttpServletRequest request, @PathVariable("id") String id,
			HttpServletResponse response) throws Exception {
                 ModelAndView modelAndView = new ModelAndView("admin/editUser");
                 modelAndView.addObject("user", user.getUser(id));
                 return modelAndView;
	}
    @RequestMapping(value = {"/admin/addDocument"}, method = RequestMethod.GET)
    protected ModelAndView addDocument(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                ModelAndView modelAndView = new ModelAndView("admin/addDocument");
                List<SectionModel> sections = new LinkedList();
                SectionModel sectionClass = new SectionModel();
                sections = sectionClass.getAllSections();
                modelAndView.addObject("sections", sections);
                return modelAndView;
	}
    @RequestMapping(value = "/system/adduser.do", method = RequestMethod.POST)
    public ModelAndView doAddUser(HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String descr = request.getParameter("descr");
        String role = request.getParameter("role");
        String result = user.addUser(username, password, role, descr);
         return new ModelAndView("redirect:" + "/admin/addUser");
    }
    @RequestMapping(value = "/system/edituser.do", method = RequestMethod.POST)
    public ModelAndView doEditUser(HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String descr = request.getParameter("descr");
        String role = request.getParameter("role");
        String result = user.editUser(id, username, descr, role, password);
         return new ModelAndView("redirect:" + "/admin/addUser");
    }
    @RequestMapping(value = "/system/addDocument.do", method = RequestMethod.POST)
    public ModelAndView doAddDocument(HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("documentId");
        String title = request.getParameter("title");
        String section = request.getParameter("section");
        String date = request.getParameter("date");
        String file = request.getParameter("file");
        String isValid = request.getParameter("isValid");
        String uploader = request.getParameter("uploader");
        String result = document.addDocument(id, title, section, date, file, isValid, uploader);
         return new ModelAndView("redirect:" + "/admin");
    }
}
