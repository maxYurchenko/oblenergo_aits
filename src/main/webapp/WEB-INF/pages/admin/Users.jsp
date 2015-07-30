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
        
		<header>
                    <div class="logout">
                        ${sessionScope.user.name}
                        <a href="${Constants.URL}logout"><img src="${Constants.URL}img/shutdown.png"></a>
                    </div>
			<div class="login">
            <div class="adminLinks">
                <a href="${Constants.URL}index">Список документів</a>
                <c:if test="${user.role > 0}">
                    <a href="${Constants.URL}admin">Редактор документів</a>
                    <a href="${Constants.URL}admin/sections">Редактор розділів</a>
                </c:if>
                <c:if test="${user.role == 2}">
                    <a style="border-bottom: 3px solid #428bca;" href="${Constants.URL}admin/users">Редактор користувачів</a>
                    <a href="${Constants.URL}admin/userGroups">Редактор груп</a>
                </c:if>
            </div>
			</div>
                    <div class="breadCrumbs">
                        <ul id="breadCrumbsUl">
                        </ul>
                    </div>
		</header>
        <div class="container">
            <c:if test="${sessionScope.user.role != 2}">
                <script>window.location.href = "${Constants.URL}login";</script>
            </c:if>
        <form name="userAdd" method="POST" action="${Constants.URL}admin/adduser.do" id="addUser">
                
<input style="display:none;" type="text" name="somefakename" />
<input style="display:none;" type="password" name="anotherfakename" />
               <div class="row">
                                                    <div class="col-md-3">
                                                <label>Логін:</label>
                                                <input type="text" name="username" class="form-control" id="username">
                                                <label class="displayNone text-danger" id="loginValidation">Неправильно заповнене поле</label>
                                                <label class="displayNone text-danger" id="loginIsTaken">Користувач з таким іменем вже існує</label>
                                              </div>
                                                    <div class="col-md-3">
                                                <label>Пароль:</label>
                                                <input type="password" name="password" class="form-control" id="password">
                                                <label class="displayNone text-danger" id="passValidation">Неправильно заповнене поле</label>
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
                        <input onclick="validate()" class="btn btn-primary btn-mini margintop-button" value="Додати користувача" type="button">
                        <input class="btn btn-primary btn-mini margintop-button displayNone" id="sudmitData" value="Додати користувача" type="submit">
                                        </div>
            </form>
        <div class="tableMainClass">
            <table class="table" id="table-pagination" data-height="400" data-pagination="true">
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
        function validate(){
            var submit = true;
            $('#passValidation').addClass('displayNone');
            $('#loginValidation').addClass('displayNone');
            $('#loginIsTaken').addClass('displayNone');
            if($('#username').val().length<5){
                $('#loginValidation').removeClass('displayNone');
                submit = false;
            }
            if($('#password').val().length<5){
                $('#passValidation').removeClass('displayNone');
                submit = false;
            }
            $.ajax({
                type: "get",
                url: "${Constants.URL}checkUsername/",
                cache: false,    
                data:'login='+ $("#username").val(),
                success: function(response){
                    console.log(response);
                    if(response === "false"){
                        if(submit)
                            $('#sudmitData').click();
                    }
                    else {
                        submit = false;
                        $('#loginIsTaken').removeClass('displayNone');
                    }
                },
                error: function(response){      
                    console.log(response);
                }
           });
        }
    </script>
</t:mainHeader>
