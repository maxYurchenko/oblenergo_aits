<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="Constants" class="ua.aits.oblenergo.functions.Constants" scope="session"/>
<%
    String redirectURL = Constants.URL+"login";
    response.sendRedirect(redirectURL);
%>