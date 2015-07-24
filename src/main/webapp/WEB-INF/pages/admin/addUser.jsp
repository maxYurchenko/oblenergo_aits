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
            <div class="adminLinks">
                <a href="${Constants.URL}index">Список документів</a>
                <a href="${Constants.URL}admin">Редактор документів</a>
                <a href="${Constants.URL}admin/addSection">Редактор розділів</a>
                <c:if test="${user.role == 2}">
                    <a href="${Constants.URL}admin/addUser">Редактор користувачів</a>
                </c:if>
            </div>
        <form name="userAdd" method="POST" action="${Constants.URL}admin/adduser.do" id="addUser">
                
<input style="display:none;" type="text" name="somefakename" />
<input style="display:none;" type="password" name="anotherfakename" />
               <div class="row">
                                                    <div class="col-md-3">
                                                <label>Логін:</label>
                                                <input type="text" name="username" class="form-control" id="username">
                                                <div class="validation"></div>
                                              </div>
                                                    <div class="col-md-3">
                                                <label>Пароль:</label>
                                                <input type="password" name="password" class="form-control" id="password">
                                                <div class="validation"></div>
                                              </div>
                                                    <div class="col-md-3">
                                                <label>Примітки:</label>
                                                <input type="text" name="descr" class="form-control" id="descr">
                                                <div class="validation"></div>
                                              </div>
                                                    <div class="col-md-3" style="margin-top: 25px;">
                                                <select id="role" name="role" class="selectpicker">
                                                    <option value="0">Користувач</option>
                                                    <option value="1">Редактор</option>
                                                    <option value="2">Адміністратор</option>
                                                </select>
                                              </div>
               </div>
                    <div>
                        <input class="btn btn-primary btn-mini margintop-button" id="sudmitData" value="Додати користувача" type="submit">
                                        </div>
            </form>
        <div class="tableMainClass">
            <table class="table" id="table-pagination" data-height="400" data-pagination="true">
                    <thead>
                        <tr>
                            <th>Ім’я</th>
                            <th>Роль</th>
                            <th>Опис</th>
                            <th>Редагувати</th>
                            <th>Видалити</th>
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
                                <th style="width:20px;"><a href="${Constants.URL}admin/editUser/${user.id}">Редагувати</a></th>
                                <th onclick="deleteUser('${user.id}')" style="width:20px;"><a style="cursor: pointer">Видалити</a></th>
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
