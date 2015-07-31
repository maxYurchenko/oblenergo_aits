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
        <div class="container">
            <c:if test="${sessionScope.user.role != 2}">
                <script>window.location.href = "${Constants.URL}login";</script>
            </c:if>
            <a href="${Constants.URL}admin/addUser" class="btn marginTop btn-primary btn-mini">Додати нового користувача</a>
        <div class="tableMainClass">
            <table class="table display" id="table-pagination" data-height="400" data-pagination="true">
                    <thead>
                        <tr class="tableHeader">
                            <th>Ім’я</th>
                            <th>Роль</th>
                            <th>Опис</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="user">
                            <tr class="display">
                                <th>${user.name}</th>
                                <th>
                                    <c:choose>
                                        <c:when test="${user.role == 2}">
                                           Адміністратор
                                        </c:when>
                                        <c:when test="${user.role == 1}">
                                            Редактор
                                        </c:when>
                                        <c:otherwise>
                                            Користувач
                                        </c:otherwise>
                                    </c:choose>
                                </th>
                                <th>${user.description}</th>
                                <th style="width:20px;"><a href="${Constants.URL}admin/editUser/${user.id}"><img style="width: 20px;" src="${Constants.URL}/img/edit.png"></a></th>
                                <th onclick="deleteUser('${user.id}')" style="width:20px;"><a style="cursor: pointer"><img style="width: 20px;" src="${Constants.URL}/img/delete.png"></a></th>
                            </tr>
                        </c:forEach>
                    </tbody>
                </thead>
            </table>
        </div>
        </div>
    </body>
    <script>
        $( document ).ready(function() {
            $('#usersPage').css('border-bottom','3px solid #428bca');
            $('.selectpicker').selectpicker();
            $('#table-pagination').DataTable();
        });
        function deleteUser(id){
            console.log(id);
            $.ajax({
                type: "get",
                url: "${Constants.URL}deleteUser/",
                cache: false, 
                data:'id='+id,
                success: function(response){
                    location.reload();
                },
                error: function(response){ 
                    console.log(response);
                }
            }); 
        }
    </script>
</t:mainHeader>
