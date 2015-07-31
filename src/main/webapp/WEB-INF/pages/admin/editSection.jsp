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
            <div class="row">
                <div class="col-md-12 marginTop greenText">
                    <h4>Редагування розділу</h4>
                </div>
            </div>
            <hr>
            <c:if test="${sessionScope.user.role != 2}">
                <script>window.location.href = "${Constants.URL}login";</script>
            </c:if>
        <form name="userAdd" method="POST" action="${Constants.URL}admin/editsection.do" id="addUser">
                
               <div class="row">
                                                    <div class="col-md-4">
                                                        <label class="greenText">Назва розділу:<span class="red-star">*</span></label>
                                                <input type="text" name="sectionName" class="form-control" id="sectionName" value="${section.title}">
                                                <input type="hidden" name="sectionId" class="form-control" id="sectionId" value="${section.id}">
                                                <label class="displayNone text-danger" id="titleValidation">Неправильно заповнене поле</label>
                                              </div>
               </div>
            <hr>
               <div class="row">
                                                    <div class="col-md-4">
                                                        <label class="greenText">Головний розділ:<span class="red-star">*</span></label>
                                                <select id="sectionParentId" name="sectionParentId" class="selectpicker">
                                                    <option value="0">Головний розділ</option>
                                                    <c:forEach items="${sections}" var="section">
                                                        <option value="${section.id}">${section.title}</option>
                                                    </c:forEach>
                                                </select>
                                              </div>
               </div>
               <div class="row">
                    <div class="col-md-6 text-danger"><strong>При переносі всі підрозділи та файли буде також перенесено</strong></div>
               </div>
            <hr>
               <div class="row">
                        <div class="col-md-2">
                        <input onclick="validate()" class="btn btn-success btn-mini" value="Редагувати розділ" type="button">
                        <input class="btn btn-primary btn-mini margintop-button displayNone" id="sudmitData" value="Додати користувача" type="submit">
                                        </div>
                            <div class="col-md-2">
                        <a class="btn btn-danger btn-mini" href="${Constants.URL}admin/sections">Повернутись до списку</a>
                            </div>
               </div>
        </div>
            </form>
        <script>
            $( document ).ready(function() {
                $('#sectionsPage').css('background','#14A86B');
                $('.selectpicker').selectpicker();
                $("span:contains('${section.parentName}')").click();
            });
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
