<%-- 
    Document   : addUser
    Created on : Jul 23, 2015, 2:00:47 PM
    Author     : skywalker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:mainHeader>
    <body>
        <div class="container-fluid">
            <c:if test="${sessionScope.user.role != 2}">
                <script>window.location.href = "${Constants.URL}login";</script>
            </c:if>
                <div class="row">
                    <div class="col-md-12">
            <a href="${Constants.URL}admin/addUserGroup" class="btn marginTop btn-success btn-mini">Додати нову групу</a>
                    </div>
                </div>
        <div class="tableMainClass">
            <table class="table display" id="table-pagination" data-height="400" data-pagination="true">
                    <thead>
                        <tr class="tableHeader">
                            <th>Назва</th>
                            <th>Користувачі в цій групі</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${groups}" var="group">
                                <tr class="display">
                                    <th>${group.title}</th>
                                    <th>${group.users}</th>
                                    <th style="width:25px"><a href="${Constants.URL}admin/editUserGroup/${group.id}"><img style="width: 20px;" src="${Constants.URL}/img/edit.png"></a></th>
                                    <th style="width:25px"><a href="${Constants.URL}admin/deleteUserGroup/${group.id}"><img style="width: 20px;" src="${Constants.URL}/img/delete.png"></a></th>
                                </tr>
                        </c:forEach>
                    </tbody>
                </thead>
            </table>
        </div>
        <script>
            $( document ).ready(function() {
                $('#groupsPage').css('background','#14A86B');
                $('.selectpicker').selectpicker();
                $('#table-pagination').DataTable();
                //$('.deleteFrameBlock').hide();
            });
            
        </script>
</t:mainHeader>
