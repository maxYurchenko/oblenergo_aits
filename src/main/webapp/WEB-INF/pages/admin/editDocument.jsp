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
        <form name="addDocument" method="POST" action="${Constants.URL}admin/editDocument.do" id="addDocument">
            <div class="row">
                                                    <div class="col-md-2">
                                                <label for="tlt">Номер:</label>
                                                <input type="text" name="documentId" class="form-control" id="documentId" value="${document.clientId}">
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
                                                <input type="text" name="title" class="form-control" id="title" value="${document.title}">
                                                <input type="hidden" name="hiddenId" class="form-control" id="hiddenId" value="${document.id}">
                                                <label class="displayNone text-danger" id="titleValidation">Неправильно заповнене поле</label>
                                              </div>
                                                    <div class="col-md-4" style="margin-top: 25px;">
                                                <select id="section" name="section" class="selectpicker">
                                                    <c:forEach items="${sections}" var="section">
                                                        <option value="${section.id}">${section.title}</option>
                                                    </c:forEach>
                                                </select>
                                              </div>
                </div>
            <div class="row">
                                                    <div class="col-md-4">
                                                <label for="tlt">Дата:</label>
                                                <input type="text" name="date" class="form-control" id="date" value="${document.date}">
                                                <label class="displayNone text-danger" id="dateValidation">Неправильно заповнене поле</label>
                                              </div>
                                                <input type="hidden" name="accessHidden" class="form-control" id="accessHidden">
                                                <input type="hidden" name="accessGroupHidden" class="form-control" id="accessGroupHidden">
                                                <input type="hidden" name="documentType" class="form-control" id="documentType">
                                                    <div>
                                                        <input type="hidden" name="file" class="form-control" id="file" value="${document.path}">
                                                <div class="validation"></div>
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
            
                <div  class="col-md-12">
                    <hr>
                    <div class="row">
                        <div  class="col-md-12">
                            Тип документа
                        </div>
                    </div>
                    <div class="row">
                        <div  class="col-md-4">
                            <div class="checkbox typeCheckbox">
                                <label>
                                    <input type="checkbox" value="Правило"> Правило
                                </label>
                            </div>
                            <div class="checkbox typeCheckbox">
                                <label>
                                    <input type="checkbox" value="Наказ"> Наказ
                                </label>
                            </div>
                            <div class="checkbox typeCheckbox">
                                <label>
                                    <input type="checkbox" value="Типовий договір"> Типовий договір
                                </label>
                            </div>
                        </div>
                        <div  class="col-md-4">
                            <div class="checkbox typeCheckbox">
                                <label>
                                    <input type="checkbox" value="Закон"> Закон
                                </label>
                            </div>
                            <div class="checkbox typeCheckbox">
                                <label>
                                    <input type="checkbox" value="Розпорядження"> Розпорядження
                                </label>
                            </div>
                            <div class="checkbox typeCheckbox">
                                <label>
                                    <input type="checkbox" value="Додаток"> Додаток
                                </label>
                            </div>
                        </div>
                        <div  class="col-md-4">
                            <div class="checkbox typeCheckbox">
                                <label>
                                    <input type="checkbox" value="Службова записка"> Службова записка
                                </label>
                            </div>
                            <div class="checkbox typeCheckbox">
                                <label>
                                    <input type="checkbox" value="Роз’яснення"> Роз’яснення
                                </label>
                            </div>
                        </div>
                    </div>
                    <hr>
                </div>
            </div>
                                                <input type="hidden" name="uploader" class="form-control" id="uploader" value="${document.uploader}">
            
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
                        <input onclick="validate()" class="btn marginTop btn-primary btn-mini" value="Редагувати документ" type="button">
                        <input class="btn btn-primary btn-mini displayNone" id="sudmitData" value="Додати користувача" type="submit">
                            </div>
                        </div>
            </form>
            
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
        var type = "";
        $('.typeCheckbox').each(function(){
            console.log();
            if("${document.type}".indexOf($(this).find('input').val())!=-1)
            {
                type += $(this).find('input').val() + ',';
                $(this).find('input').prop('checked', true);
            }
        });
        type = type.substring(0, type.length - 1);
        $('#documentType').val(type);
        
        $('#docsPage').css('background','#14A86B');
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

        today = dd+'/'+mm+'/'+yyyy;
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
        $('.groupsList .mutliSelect ul').find('li').each(function() {
            if("${document.accessGroup}".indexOf($(this).find('input').val())!=-1)
                $(this).find('input').click();
        });
        $('.usersList .mutliSelect ul').find('li').each(function() {
            if('${document.access}'.indexOf($(this).find('input').val())!=-1)
                $(this).find('input').click();
        });
    });
    
            function validate(){
                var type = "";
                $('.typeCheckbox').each(function(){
                    if($(this).find('input').prop('checked'))
                        type += $(this).find('input').val() + ',';
                });
                type = type.substring(0, type.length - 1);
                $('#documentType').val(type);
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
                    submit = false;
                }
                if(submit)
                    $('#sudmitData').click();
            }
</script>