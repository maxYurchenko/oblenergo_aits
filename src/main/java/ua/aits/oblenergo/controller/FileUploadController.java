/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.oblenergo.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import ua.aits.oblenergo.functions.Constants;
import ua.aits.oblenergo.model.DocumentModel;

/**
 *
 * @author skywalker
 */
@Controller
public class FileUploadController {
    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    public @ResponseBody
    String uploadFileHandler(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        String name = file.getOriginalFilename();
        String[] nameArr = name.split("\\.");
        if (!file.isEmpty()) {
            try {
                DocumentModel document = new DocumentModel();
                Integer ai = document.getNextAI();
                name = ai.toString() + "." + nameArr[1];
                byte[] bytes = file.getBytes();
                File dir = new File(Constants.FILE_URL);
                
                File serverFile = new File(dir.getAbsolutePath()
                        + File.separator + name);
                try (BufferedOutputStream stream = new BufferedOutputStream(
                        new FileOutputStream(serverFile))) {
                    stream.write(bytes);
                }
                return name;
            } catch (Exception e) {
                return "You failed to upload " + name + " => " + e.getMessage();
            }
        } else {
            return "You failed to upload " + name
                    + " because the file was empty.";
        }
    }
    
    @RequestMapping(value = "/editFile", method = RequestMethod.POST)
    public @ResponseBody
    String editFileHandler(@RequestParam("file") MultipartFile file,@RequestParam("path") String path, HttpServletRequest request) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        String tempName = file.getOriginalFilename();
        String[] nameArr = tempName.split("\\.");
        String name = path+"."+nameArr[1];
        if (!file.isEmpty()) {
            try {
                byte[] bytes = file.getBytes();
                File dir = new File(Constants.FILE_URL);
                
                File serverFile = new File(dir.getAbsolutePath()
                        + File.separator + name);
                try (BufferedOutputStream stream = new BufferedOutputStream(
                        new FileOutputStream(serverFile))) {
                    stream.write(bytes);
                }
                return name;
            } catch (Exception e) {
                return "You failed to upload " + name + " => " + e.getMessage();
            }
        } else {
            return "You failed to upload " + name
                    + " because the file was empty.";
        }
    }
}
