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
		<header>
                    <div class="logout">
                        ${sessionScope.user.name}
                        <a href="${Constants.URL}logout"><img src="${Constants.URL}img/shutdown.png"></a>
                    </div>
			<div class="login">
            <div class="adminLinks">
                <a href="${Constants.URL}index">Список документів</a>
                <c:if test="${user.role > 0}">
                    <a style="border-bottom: 3px solid #428bca;" href="${Constants.URL}admin">Редактор документів</a>
                    <a href="${Constants.URL}admin/sections">Редактор розділів</a>
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
        <form name="addDocument" method="POST" action="${Constants.URL}admin/addDocument.do" id="addDocument">
            <div class="row">
                                                    <div class="col-md-2">
                                                <label for="tlt">Номер:</label>
                                                <input type="text" name="documentId" class="form-control" id="documentId">
                                                <label class="displayNone text-danger" id="documentIdValidation">Неправильно заповнене поле</label>
                                              </div>
                
                <div  class="col-md-2" style="margin-top: 25px;">
                                                <select id="isValid" name="isValid" class="selectpicker">
                                                    <option value="1">Дійсний</option>
                                                    <option value="0">Не дійсний</option>
                                                </select>
                </div>
                                                    <div class="col-md-4">
                                                <label for="tlt">Назва:</label>
                                                <input type="text" name="title" class="form-control" id="title">
                                                <label class="displayNone text-danger" id="titleValidation">Неправильно заповнене поле</label>
                                              </div>
                                                    <div class="col-md-4" style="margin-top: 25px;">
                                                <select id="section" name="section" class="selectpicker">
                                                    <c:forEach items="${sections}" var="section">
                                                        <option value="${section.id}">${section.title}</option>
                                                    </c:forEach>
                                                </select>
                                              </div>
                                                    <div class="col-md-4">
                                                <label for="tlt">Дата:</label>
                                                <input type="text" name="date" class="form-control" id="date">
                                                <label class="displayNone text-danger" id="dateValidation">Неправильно заповнене поле</label>
                                              </div>
                                                <input type="hidden" name="accessHidden" class="form-control" id="accessHidden">
                                                <input type="hidden" name="accessGroupHidden" class="form-control" id="accessGroupHidden">
                                                    <div>
                                                <input type="hidden" name="file" class="form-control" id="file">
                                              </div>
                
            
                <div  class="col-md-4 z-index" style="margin-top: 25px;">
                    <dl class="usersList"> 

                        <dt>
                        <a href="#">
                          <span class="hida">Доступ користувачів</span>    
                          <p class="multiSel"></p>  
                        </a>
                        </dt>

                        <dd>
                            <div class="mutliSelect">
                                <ul>
                                    <c:forEach items="${users}" var="user">
                                        <c:if test="${user.role != 2}">
                                            <li><input type="checkbox" value="${user.id}" />${user.name}</li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                        </dd>
                    </dl>
                </div>
            
                <div  class="col-md-4 z-index" style="margin-top: 25px;">
                    <dl class="groupsList"> 

                        <dt>
                        <a href="#">
                          <span class="hida">Доступ груп</span>    
                          <p class="multiSel"></p>  
                        </a>
                        </dt>

                        <dd>
                            <div class="mutliSelect">
                                <ul>
                                    <c:forEach items="${groups}" var="group">
                                        <li><input type="checkbox" value="${group.id}" />${group.title}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </dd>
                    </dl>
                </div>
            </div>
                                                <input type="hidden" name="uploader" class="form-control" id="uploader">
            
                                    <div class="row add-row file">
                                        
						<div class="col-md-4">
                                                    <div>
                                                        <label for="img">Файл документа</label>
                                                    
                                                        <div id="route-upload-block">
                                                            <span class="btn btn-primary">
                                                                <input class="" id="fileInput" type="file" multiple/>
                                                            </span>
                                                        </div>
                                                <label class="displayNone text-danger" id="fileInputValidation">Файл не додано</label>
                                                    </div>
                                                </div>
                                    </div>
                        <div class="row">
                            <div class="col-md-4">
                        <input onclick="validate()" class="btn marginTop btn-primary btn-mini" value="Додати документ" type="button">
                        <input class="btn btn-primary btn-mini displayNone" id="sudmitData" value="Додати користувача" type="submit">
                            </div>
                        </div>
            </form>
            
                <div class="tableMainClass">
                    <table class="table" id="table-pagination" data-height="400" data-pagination="true">
                            <thead>
                                <tr class="tableHeader">
                                    <th>Номер</th>
                                    <th>Назва</th>
                                    <th>Розділ</th>
                                    <th style="width: 50px;">Дата</th>
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
                                            <th>${document.title}</th>
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
$('.file').on('change', '#fileInput', function() {
        $(".load-route").show();
        $('#uploader').val("${user.name}");
        var data = new FormData();
        data.append('upload', jQuery('#fileInput')[0].files[0]);
        jQuery.ajax({
                    url: '${Constants.URL}uploadFile',
                    data: data,
                    cache: false,
                    contentType: false,
                    processData: false,
                    type: 'POST',
                    success: function(data){
                        $("#fullname-route").val(data);
                        $("<span class='upload-success'>Uploaded! <span class='route-name'>("+data+")</span> </span>").appendTo("#route-upload-block");
                        $("#route-upload-block .btn-file").hide();
                        $('#file').val('files/'+data);
                    }
                    });
});
    $( document ).ready(function() {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();

        if(dd<10) {
            dd='0'+dd
        } 

        if(mm<10) {
            mm='0'+mm
        } 

        today = dd+'.'+mm+'.'+yyyy;
        $( "#date" ).val(today);
        $("[name='my-checkbox']").bootstrapSwitch();
        $('.selectpicker').selectpicker();
        $('#table-pagination').DataTable();
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
        $(".usersList dt a").on('click', function () {
          $(".usersList dd ul").slideToggle('fast');
        });

        $(".usersList dd ul li a").on('click', function () {
            $(".usersList dd ul").hide();
        });

        function getSelectedValue(id) {
             return $("#" + id).find(".usersList dt a span.value").html();
        }

        $(document).bind('click', function (e) {
            var $clicked = $(e.target);
            if (!$clicked.parents().hasClass("usersList")) $(".usersList dd ul").hide();
        });


        $('.usersList .mutliSelect input[type="checkbox"]').on('click', function () {
            var title = $(this).closest('.usersList .mutliSelect').find('.usersList input[type="checkbox"]').val(),
                title = $(this).val() + ",";

            if ($(this).is(':checked')) {
                var html = '<span class="accessUsersList" title="' + title + '">' + title + '</span>';
                $('.multiSel').append(html);
                //$(".hida").hide();
            } 
            else {
                $('.usersList span[title="' + title + '"]').remove();
                var ret = $(".hida");
                $('.usersList .dropdown dt a').append(ret);

            }
            var accessUsersList = "";
            $('.accessUsersList').each(function(){
                accessUsersList+=$(this).html();
            });
            accessUsersList = accessUsersList.substring(0, accessUsersList.length - 1);
            $('#accessHidden').val(accessUsersList);
            console.log(accessUsersList);
        });
        $(".groupsList dt a").on('click', function () {
          $(".groupsList dd ul").slideToggle('fast');
        });

        $(".groupsList dd ul li a").on('click', function () {
            $(".groupsList dd ul").hide();
        });

        function getSelectedValue(id) {
             return $("#" + id).find(".groupsList dt a span.value").html();
        }

        $(document).bind('click', function (e) {
            var $clicked = $(e.target);
            if (!$clicked.parents().hasClass("groupsList")) $(".groupsList dd ul").hide();
        });


        $('.groupsList .mutliSelect input[type="checkbox"]').on('click', function () {
            var title = $(this).closest('.groupsList .mutliSelect').find('.groupsList input[type="checkbox"]').val(),
                title = $(this).val() + ",";

            if ($(this).is(':checked')) {
                var html = '<span class="accessGroupsList" title="' + title + '">' + title + '</span>';
                $('.groupsList .multiSel').append(html);
                //$(".hida").hide();
            } 
            else {
                $('.groupsList span[title="' + title + '"]').remove();
                var ret = $(".hida");
                $('.groupsList .dropdown dt a').append(ret);

            }
            var accessGroupsList = "";
            $('.accessGroupsList').each(function(){
                accessGroupsList+=$(this).html();
            });
            accessGroupsList = accessGroupsList.substring(0, accessGroupsList.length - 1);
            $('#accessGroupHidden').val(accessGroupsList);
        });
    });
            function validate(){
                var submit = true;
                $('#documentIdValidation').addClass('displayNone');
                $('#titleValidation').addClass('displayNone');
                $('#dateValidation').addClass('displayNone');
                $('#fileInputValidation').addClass('displayNone');
                if($('#title').val().length<5){
                    $('#titleValidation').removeClass('displayNone');
                    submit = false;
                }
                if($('#documentId').val().length<1){
                    $('#documentIdValidation').removeClass('displayNone');
                    submit = false;
                }
                if($('#file').val().length<3){
                    $('#fileInputValidation').removeClass('displayNone');
                    submit = false;
                }
                if($('#date').val().length<3){
                    $('#dateValidation').removeClass('displayNone');
                    console.log($('#date').val());
                    submit = false;
                }
                if(submit)
                    $('#sudmitData').click();
            }
</script>