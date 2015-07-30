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
                    <a style="border-bottom: 3px solid #428bca;" href="${Constants.URL}admin/sections">Редактор розділів</a>
                </c:if>
                <c:if test="${user.role == 2}">
                    <a href="${Constants.URL}admin/users">Редактор користувачів</a>
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
        <form name="userAdd" method="POST" action="${Constants.URL}admin/addsection.do" id="addUser">
                
               <div class="row">
                                                    <div class="col-md-6">
                                                <label>Назва розділу:</label>
                                                <input type="text" name="sectionName" class="form-control" id="sectionName">
                                                <label class="displayNone text-danger" id="titleValidation">Неправильно заповнене поле</label>
                                              </div>
                                                    <div class="col-md-6" style="margin-top: 25px;">
                                                <select id="sectionParentId" name="sectionParentId" class="selectpicker">
                                                    <option value="0">Головний розділ</option>
                                                    <c:forEach items="${sections}" var="section">
                                                        <option value="${section.id}">${section.title}</option>
                                                    </c:forEach>
                                                </select>
                                              </div>
               </div>
                    <div>
                        <input onclick="validate()" class="btn btn-primary btn-mini margintop-button" value="Додати розділ" type="button">
                        <input class="btn btn-primary btn-mini margintop-button displayNone" id="sudmitData" value="Додати користувача" type="submit">
                                        </div>
            </form>
        
                <div style="display: none" class="deleteFrameBlock">
                    <div class="deleteSectionConfirm">
                        Ви впевнені, що бажаєте видалити розділ, всі підрозділи та файли, що в ньому знаходяться?<br>
                        <input onclick="hideDeleteBlock()" class="btn btn-success btn-mini sectionDeleteButton" id="sudmitData" value="Ні" type="submit">
                        <a href="${Constants.URL}admin/deleteSection/id" id="deleteButton">
                            <input class="btn btn-danger btn-mini sectionDeleteButton" id="sudmitData" value="Так" type="submit">
                        </a>
                    </div>
                </div>
        <div class="tableMainClass">
            <table class="table" id="table-pagination" data-height="400" data-pagination="true">
                    <thead>
                        <tr class="tableHeader">
                            <th>Ім’я</th>
                            <th>Головна категорія</th>
                            <th style="width:20px;"></th>
                            <th style="width:20px;"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${sections}" var="section">
                            <c:if test="${section.isDelete != 1}">
                                <tr class="display">
                                    <th>${section.title}</th>
                                    <th>
                                        <c:choose>
                                            <c:when test="${section.parentName == '0'}">
                                               Головний розділ
                                            </c:when>
                                            <c:otherwise>
                                               ${section.parentName}
                                            </c:otherwise>
                                        </c:choose>
                                    </th>
                                    <th style="width:20px;"><a href="${Constants.URL}admin/editSection/${section.id}"><img style="width: 20px;" src="${Constants.URL}/img/edit.png"></a></th>
                                    <th style="width:20px;"><a onclick="deleteRoute('${section.id}')" href="#"><img style="width: 20px;" src="${Constants.URL}/img/delete.png"></a></th>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </thead>
            </table>
        </div>
        <script>
            $( document ).ready(function() {
                $('.selectpicker').selectpicker();
                $('#table-pagination').DataTable();
                //$('.deleteFrameBlock').hide();
            });
            function deleteRoute(id){
                $('.deleteFrameBlock').fadeIn('fast');
                $('#deleteButton').attr('href','${Constants.URL}admin/deleteSection/'+id);
            }
            function hideDeleteBlock(){
                $('.deleteFrameBlock').fadeOut('fast');
            }
            function validate(){
                var submit = true;
                $('#titleValidation').addClass('displayNone');
                if($('#sectionName').val().length<5){
                    $('#titleValidation').removeClass('displayNone');
                    submit = false;
                }
                if(submit)
                    $('#sudmitData').click();
            }
        </script>
</t:mainHeader>
