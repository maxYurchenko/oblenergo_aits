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
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import ua.aits.oblenergo.functions.Helpers;
import ua.aits.oblenergo.model.DocumentModel;
import ua.aits.oblenergo.model.SectionModel;
import ua.aits.oblenergo.model.UserGroupModel;
import ua.aits.oblenergo.model.UserModel;

/**
 *
 * @author skywalker
 */
@Controller
public class AdminContontroller {
    UserModel user = new UserModel();
    DocumentModel document = new DocumentModel();
    SectionModel section = new SectionModel();
    UserGroupModel userGroup = new UserGroupModel();
    Helpers helper = new Helpers();
    @RequestMapping(value = {"/admin"}, method = RequestMethod.GET)
    protected ModelAndView admin(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                request.setCharacterEncoding("UTF-8");
                ModelAndView modelAndView = new ModelAndView("admin/Documents");
                modelAndView.addObject("sections", helper.getSortedSections("0"));
                modelAndView.addObject("documents", document.getAllDocuments());
                modelAndView.addObject("users", user.getAllUsers());
                modelAndView.addObject("groups", userGroup.getAllGroups());
                 return modelAndView;
	}
    @RequestMapping(value = {"/admin/addDocument"}, method = RequestMethod.GET)
    protected ModelAndView addDocument(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                request.setCharacterEncoding("UTF-8");
                ModelAndView modelAndView = new ModelAndView("admin/addDocument");
                modelAndView.addObject("sections", helper.getSortedSections("0"));
                modelAndView.addObject("documents", document.getAllDocuments());
                modelAndView.addObject("users", user.getAllUsers());
                modelAndView.addObject("groups", userGroup.getAllGroups());
                 return modelAndView;
	}
    @RequestMapping(value = {"/admin/users"}, method = RequestMethod.GET)
    protected ModelAndView users(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                request.setCharacterEncoding("UTF-8");
                ModelAndView modelAndView = new ModelAndView("admin/Users");
                modelAndView.addObject("users", user.getAllUsers());
                return modelAndView;
	}
    @RequestMapping(value = {"/admin/addUser"}, method = RequestMethod.GET)
    protected ModelAndView addUser(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                request.setCharacterEncoding("UTF-8");
                ModelAndView modelAndView = new ModelAndView("admin/addUser");
                modelAndView.addObject("users", user.getAllUsers());
                return modelAndView;
	}
    @RequestMapping(value = {"/admin/editUser/{id}"}, method = RequestMethod.GET)
    protected ModelAndView editUser(HttpServletRequest request, @PathVariable("id") String id,
			HttpServletResponse response) throws Exception {
                request.setCharacterEncoding("UTF-8");
                ModelAndView modelAndView = new ModelAndView("admin/editUser");
                modelAndView.addObject("user", user.getUser(id));
                return modelAndView;
	}
    @RequestMapping(value = "/admin/adduser.do", method = RequestMethod.POST)
    public ModelAndView doAddUser(HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String descr = request.getParameter("descr");
        String role = request.getParameter("role");
        String result = user.addUser(username, password, role, descr);
         return new ModelAndView("redirect:" + "/admin/users");
    }
    @RequestMapping(value = "/admin/edituser.do", method = RequestMethod.POST)
    public ModelAndView doEditUser(HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String descr = request.getParameter("descr");
        String role = request.getParameter("role");
        String result = user.editUser(id, username, descr, role, password);
         return new ModelAndView("redirect:" + "/admin/users");
    }
    @RequestMapping(value = "/admin/addDocument.do", method = RequestMethod.POST)
    public ModelAndView doAddDocument(HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("documentId");
        String title = request.getParameter("title");
        String section = request.getParameter("section");
        String date = request.getParameter("date");
        String file = request.getParameter("file");
        String isValid = request.getParameter("isValid");
        String uploader = request.getParameter("uploader");
        String access = request.getParameter("accessHidden");
        String accessGroup = request.getParameter("accessGroupHidden");
        String result = document.addDocument(id, title, section, date, file, isValid, uploader, access, accessGroup);
        return new ModelAndView("redirect:" + "/admin");
    }
    @RequestMapping(value = "/admin/editDocument.do", method = RequestMethod.POST)
    public ModelAndView doEditDocument(HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String clientId = request.getParameter("documentId");
        String id = request.getParameter("hiddenId");
        String title = request.getParameter("title");
        String section = request.getParameter("section");
        String date = request.getParameter("date");
        String file = request.getParameter("file");
        String isValid = request.getParameter("isValid");
        String uploader = request.getParameter("uploader");
        String access = request.getParameter("accessHidden");
        String groups = request.getParameter("accessGroupHidden");
        String result = document.editDocument(id, clientId, title, section, date, file, isValid, uploader, access, groups);
        return new ModelAndView("redirect:" + "/admin");
    }
    @RequestMapping(value = {"/admin/sections"}, method = RequestMethod.GET)
    protected ModelAndView sections(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                request.setCharacterEncoding("UTF-8");
                ModelAndView modelAndView = new ModelAndView("admin/Sections");
                modelAndView.addObject("sections", helper.getSortedSections("0"));
                return modelAndView;
	}
    @RequestMapping(value = {"/admin/addSection"}, method = RequestMethod.GET)
    protected ModelAndView addSection(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                request.setCharacterEncoding("UTF-8");
                ModelAndView modelAndView = new ModelAndView("admin/addSection");
                modelAndView.addObject("sections", helper.getSortedSections("0"));
                return modelAndView;
	}
    @RequestMapping(value = {"/admin/editSection/{id}"}, method = RequestMethod.GET)
    protected ModelAndView editSection(HttpServletRequest request, @PathVariable("id") String id,
			HttpServletResponse response) throws Exception {
                request.setCharacterEncoding("UTF-8");
                ModelAndView modelAndView = new ModelAndView("admin/editSection");
                modelAndView.addObject("section", section.getOneSection(id));
                modelAndView.addObject("sections", helper.getSortedSections("0"));
                return modelAndView;
	}
    @RequestMapping(value = {"/admin/editDocument/{id}"}, method = RequestMethod.GET)
    protected ModelAndView editDocument(HttpServletRequest request, @PathVariable("id") String id,
			HttpServletResponse response) throws Exception {
                request.setCharacterEncoding("UTF-8");
                ModelAndView modelAndView = new ModelAndView("admin/editDocument");
                modelAndView.addObject("users", user.getAllUsers());
                modelAndView.addObject("sections", helper.getSortedSections("0"));
                modelAndView.addObject("document", document.getOneDocument(id));
                modelAndView.addObject("groups", userGroup.getAllGroups());
                return modelAndView;
	}
    @RequestMapping(value = {"/admin/deleteSection/{id}"}, method = RequestMethod.GET)
    protected ModelAndView deleteSection(HttpServletRequest request, @PathVariable("id") String id,
			HttpServletResponse response) throws Exception {
                ModelAndView modelAndView = new ModelAndView("admin/deleteSection");
                String result = section.deleteSection(id);
                return new ModelAndView("redirect:" + "/admin/sections");
	}
    @RequestMapping(value = "/admin/addsection.do", method = RequestMethod.POST)
    public ModelAndView doAddSection(HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String title = request.getParameter("sectionName");
        String parentId = request.getParameter("sectionParentId");
        String result = section.addSection(title, parentId);
         return new ModelAndView("redirect:" + "/admin/sections");
    }
    @RequestMapping(value = "/admin/editsection.do", method = RequestMethod.POST)
    public ModelAndView doEditSection(HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("sectionId");
        String title = request.getParameter("sectionName");
        String parentId = request.getParameter("sectionParentId");
        String result = section.editSection(id, title, parentId);
        return new ModelAndView("redirect:" + "/admin/sections");
    }
    @RequestMapping(value = {"/admin/userGroups"}, method = RequestMethod.GET)
    protected ModelAndView userGroup(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                request.setCharacterEncoding("UTF-8");
                ModelAndView modelAndView = new ModelAndView("admin/UserGroups");
                List<UserModel> users = new LinkedList();
                users = user.getAllUsers();
                List<UserGroupModel> groupsList = new LinkedList();
                groupsList = userGroup.getAllGroups();
                modelAndView.addObject("groups", groupsList);
                modelAndView.addObject("users", users);
                return modelAndView;
	}
    @RequestMapping(value = {"/admin/addUserGroup"}, method = RequestMethod.GET)
    protected ModelAndView addUserGroup(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                request.setCharacterEncoding("UTF-8");
                ModelAndView modelAndView = new ModelAndView("admin/addUserGroup");
                List<UserModel> users = new LinkedList();
                users = user.getAllUsers();
                List<UserGroupModel> groupsList = new LinkedList();
                groupsList = userGroup.getAllGroups();
                modelAndView.addObject("groups", groupsList);
                modelAndView.addObject("users", users);
                return modelAndView;
	}
    
    @RequestMapping(value = "/admin/addusergroup.do", method = RequestMethod.POST)
    public ModelAndView doAddUserGroup(HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String title = request.getParameter("groupName");
        String groupId = userGroup.addUserGroups(title);
        String[] access = request.getParameter("accessHidden").split(",");
        for(String userId : access) {
            user.addUserGroup(userId, groupId);
        }
        return new ModelAndView("redirect:" + "/admin/userGroups");
    }
    @RequestMapping(value = {"/admin/deleteUserGroup/{id}"}, method = RequestMethod.GET)
    protected ModelAndView deleteUserGroup(HttpServletRequest request, @PathVariable("id") String id,
			HttpServletResponse response) throws Exception {
                ModelAndView modelAndView = new ModelAndView("admin/deleteSection");
                userGroup.deleteGroup(id);
                user.groupDeleted(id);
                return new ModelAndView("redirect:" + "/admin/userGroups");
	}
    
    @RequestMapping(value = {"/logout","/logout/"})
    public ModelAndView logout(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                
                return new ModelAndView("redirect:" + "/login");
	}
}
