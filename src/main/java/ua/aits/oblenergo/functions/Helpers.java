/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.oblenergo.functions;

import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import ua.aits.oblenergo.model.DocumentModel;
import ua.aits.oblenergo.model.SectionModel;

/**
 *
 * @author skywalker
 */
public class Helpers {
    SectionModel section = new SectionModel();
    public String getRowHtml(String id) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        List<SectionModel> tempSection = section.getSectionRow(id);
        String tempId = "";
        if("0".equals(id)){
            tempId = "id=expList";
        }
        String html = "<ul "+tempId+">\n";
            for(SectionModel temp : tempSection) {
                if(temp.isDelete!=1){
                    html = html + "<li class='section' value='"+temp.id+"' id='section"+temp.id+"' onclick='getChildDocuments("+temp.id.toString()+")'>"
                            +temp.title+" ("+temp.documents.size()+")";
                    html = html + this.getRowHtml(temp.id.toString());
                    /*
                    if(temp.documents.size()>0){html=html+"<ul>\n";}
                    for(DocumentModel tempDocs : temp.documents) {
                        html = html + "<li onclick='showDocument(\""+tempDocs.path+"\")'>" + tempDocs.title + "</li>";
                    }
                    if(temp.documents.size()>0){html=html+"</ul>\n";}
                    */
                    html = html + "</li>";
                }
            }
        html = html + "</ul>";
        return html;
    }
    public List<SectionModel> getSortedSections(String id)throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        List<SectionModel> sectionList = section.getSectionRow(id);
        List<SectionModel> tempSection = new LinkedList<>();
        for(SectionModel temp : sectionList) {
            tempSection.add(temp);
            tempSection.addAll(getSortedSections(temp.id.toString()));
        }
        return tempSection;
    }
}
