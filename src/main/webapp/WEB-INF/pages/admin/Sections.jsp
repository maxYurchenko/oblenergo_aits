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
            <a href="${Constants.URL}admin/addSection" class="btn marginTop btn-primary btn-mini">Додати новий розділ</a>
        
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
            <table class="table display" id="table-pagination" data-height="400" data-pagination="true">
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
                                    <th style="width:20px;"><a onclick="deleteSection('${section.id}')" href="#"><img style="width: 20px;" src="${Constants.URL}/img/delete.png"></a></th>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </thead>
            </table>
        </div>
        <script>
            $( document ).ready(function() {
                $('#sectionsPage').css('border-bottom','3px solid #428bca');
                $('.selectpicker').selectpicker();
                $('#table-pagination').DataTable({
                    "bSort" : false
                });
                //$('.deleteFrameBlock').hide();
            });
            function deleteSection(id){
                $('.deleteFrameBlock').fadeIn('fast');
                $('#deleteButton').attr('href','${Constants.URL}admin/deleteSection/'+id);
            }
            function hideDeleteBlock(){
                $('.deleteFrameBlock').fadeOut('fast');
            }
        </script>
</t:mainHeader>
