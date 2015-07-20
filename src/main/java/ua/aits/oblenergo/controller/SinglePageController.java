/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.oblenergo.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import ua.aits.oblenergo.model.UserModel;

/**
 *
 * @author skywalker
 */
@Controller
@Scope("session")
public class SinglePageController {
    
    UserModel users = new UserModel();
    
    @RequestMapping(value = {"/index", "/main", "/home"}, method = RequestMethod.GET)
    protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
                 ModelAndView modelAndView = new ModelAndView("index");
                 modelAndView.addObject("user",users.getUser(1));
                 return modelAndView;
	}
}
