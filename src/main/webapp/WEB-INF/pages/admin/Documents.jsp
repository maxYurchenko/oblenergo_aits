<%-- 
    Document   : addDocument
    Created on : Jul 23, 2015, 2:12:03 PM
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
            <a href="${Constants.URL}admin/addDocument" class="btn marginTop btn-primary btn-mini">Додати новий документ</a>
            
                <div class="tableMainClass">
                    <table style="visibility: hidden" class="table display" id="table-pagination" data-height="400" data-pagination="true">
                            <thead>
                                <tr class="tableHeader">
                                    <th>Номер</th>
                                    <th>Назва</th>
                                    <th>Розділ</th>
                                    <th style="width: 50px;">Дата</th>
                                    <th>Завантажити</th>
                                    <th></th>
                                    <c:if test="${user.role == 2}">
                                        <th style="width: 58px;">Видалити</th>
                                    </c:if>
                                    <th>Дійсний</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${documents}" var="document">
                                    <c:if test="${document.isDelete==0 || user.role==2}">
                                        <tr <c:if test="${document.valid==0}">class="inValidDoc display"</c:if>>
                                            <th>${document.clientId}</th>
                                            <th>${document.title}</th>
                                            <th>${document.parentName}</th>
                                            <th>${document.date}</th>
                                            <th><a class="cutLink" target='_blank' download href="${Constants.URL}${document.path}">${document.path}</a></th>
                                            <th><a href="${Constants.URL}admin/editDocument/${document.id}"><img style="width: 20px;" src="${Constants.URL}/img/edit.png"></a></th>
                                            <c:if test="${user.role == 2}">
                                                <th class="publishCheckboxBlock" id="publishCheckboxBlock${document.id}" 
                                                    style="width: 58px;" value="${document.id}">
                                                    <c:choose>
                                                        <c:when test="${document.isDelete == 1}">
                                                            <input type="checkbox" name="my-checkbox" id="deleteCheckBox${document.id}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="checkbox" name="my-checkbox" checked
                                                                                         id="deleteCheckBox${document.id}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </th>
                                            </c:if>
                                            <c:if test="${user.role == 2}">
                                                <th class="validCheckboxBlock" id="validCheckboxBlock${document.id}" 
                                                    style="width: 58px;" value="${document.id}">
                                                    <c:choose>
                                                        <c:when test="${document.valid == 0}">
                                                            <input type="checkbox" name="my-checkbox" id="validCheckBox${document.id}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="checkbox" name="my-checkbox" checked
                                                                                         id="validCheckBox${document.id}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </th>
                                            </c:if>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </thead>
                    </table>
                </div>
            
            </div>
    </body>
</t:mainHeader>
<script>
    $( document ).ready(function() {
        $('table').css('visibility','visible');
        $('.cutLink').each(function(){
            $(this).text($(this).text().substring(6, $(this).text().length));
        });
        $('#docsPage').css('border-bottom','3px solid #428bca');
        $("[name='my-checkbox']").bootstrapSwitch();
        $('.selectpicker').selectpicker();
        $('#table-pagination').DataTable({
            "bSort" : false
        });
        $('#table-pagination_paginate').click(function(){
            $("[name='my-checkbox']").bootstrapSwitch();
        });
        $('#table-pagination').click(function(){
            $("[name='my-checkbox']").bootstrapSwitch();
        });
        $('.dataTables_wrapper').change(function() {
            $("[name='my-checkbox']").bootstrapSwitch();
        });
        $('.dataTables_filter').on('input', function() {
            $("[name='my-checkbox']").bootstrapSwitch();
        });
        $('.publishCheckboxBlock').on('switchChange.bootstrapSwitch', function(event, state) {
            var isDelete = 0;
            if(state) {
                isDelete = 0;
            }else{
                isDelete = 1;
            }
            var id = $(this).attr("value");
            $.ajax({
                type: "get",
                url: "${Constants.URL}deleteDoc/",
                cache: false, 
                data:'id='+id+'&publish='+isDelete,
                success: function(response){
                    console.log(response);
                },
                error: function(response){ 
                    console.log(response);
                }
            }); 
        });
        $('.validCheckboxBlock').on('switchChange.bootstrapSwitch', function(event, state) {
            var valid = 0;
            if(state) {
                valid = 1;
            }else{
                valid = 0;
            }
            var id = $(this).attr("value");
            $.ajax({
                type: "get",
                url: "${Constants.URL}isValidDocument/",
                cache: false, 
                data:'id='+id+'&valid='+valid,
                success: function(response){
                    console.log(response);
                },
                error: function(response){ 
                    console.log(response);
                }
            }); 
        });
    });
</script>