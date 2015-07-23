<%-- 
    Document   : mainHeader
    Created on : Jul 23, 2015, 4:45:06 PM
    Author     : skywalker
--%>
<%@tag description="Index Page Template" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<jsp:useBean id="Constants" class="ua.aits.oblenergo.functions.Constants" scope="session"/>
<html>
    <head>
        <link rel="stylesheet" href="${Constants.URL}css/style.css">
        <script type="text/javascript" src="${Constants.URL}js/jquery-1.9.1.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/scripts.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/select/js/bootstrap-select.js"></script>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/css/bootstrap-select.min.css" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/js/bootstrap-select.min.js"></script>
        <link rel="stylesheet" href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css">
        <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
        

    </head>
    <c:if test="${sessionScope.user == null}">
        <script>window.location.href = "${Constants.URL}login";</script>
    </c:if>
        <jsp:doBody/> 
</html>