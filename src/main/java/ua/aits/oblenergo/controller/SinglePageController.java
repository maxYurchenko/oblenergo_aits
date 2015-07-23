/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.oblenergo.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import ua.aits.oblenergo.functions.Constants;
import ua.aits.oblenergo.functions.Helpers;
import ua.aits.oblenergo.model.SectionModel;
import ua.aits.oblenergo.model.UserModel;
import ua.aits.oblenergo.model.DocumentModel;

/**
 *
 * @author skywalker
 */
@Controller
@Scope("session")
public class SinglePageController {
    
    UserModel users = new UserModel();
    SectionModel sections = new SectionModel();
    Helpers helper = new Helpers();
    DocumentModel documents = new DocumentModel();
    
    @RequestMapping(value = {"/index", "/main", "/home"}, method = RequestMethod.GET)
    protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                 ModelAndView modelAndView = new ModelAndView("index");
                 modelAndView.addObject("listHtml", helper.getRowHtml("0"));
                 modelAndView.addObject("documents", documents.getAllDocuments());
                 return modelAndView;
	}
    
    @RequestMapping(value = {"/login","/login/","/oblenergo/login","/oblenergo/login/"})
    public ModelAndView login(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
        String redir = "http://88.81.239.23:59180/";
        if("/oblenergo/".equals(Constants.URL)) {
            redir = "/";
        }
	return new ModelAndView("redirect:" + redir+"login");
    }
    
    @RequestMapping(value = {"/login","/login/","/oblenergo/login","/oblenego/login/"})
    public ModelAndView loginMain(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                        System.out.println(request.getHeader("referer"));
                        
		ModelAndView model = new ModelAndView("login");
                model.addObject("result", request.getHeader("referer"));
		return model;
	}
    
    
    @RequestMapping(value = {"/login.do","/login.do/"}, method = RequestMethod.POST)
    public ModelAndView login(@RequestParam("username") String login, @RequestParam("password") String passwd, 
            HttpServletRequest request,
		HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
                UserModel user = users.getUser(login, passwd); 
                HttpSession session = request.getSession(true);
		session.setAttribute("user",  user);
                return new ModelAndView("redirect:" + "/index");
                
	}
}
