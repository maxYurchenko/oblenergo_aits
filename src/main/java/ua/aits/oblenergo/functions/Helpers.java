/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.aits.oblenergo.functions;

import java.sql.SQLException;
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
                html = html + "<li class='section' id='section"+temp.id+"' onclick='getChildDocuments("+temp.id.toString()+")'>"+temp.title;
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
        html = html + "</ul>";
        return html;
    }
}
