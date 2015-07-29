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
                    <a href="${Constants.URL}admin/addUserGroup">Редактор груп</a>
                </c:if>
            </div>
        <form name="userAdd" method="POST" action="${Constants.URL}admin/addusergroup.do" id="addUser">
                
               <div class="row">
                                                    <div class="col-md-6">
                                                <label>Назва групи:</label>
                                                <input type="text" name="groupName" class="form-control" id="groupName">
                                                <label class="displayNone text-danger" id="titleValidation">Неправильно заповнене поле</label>
                                                <label class="displayNone text-danger" id="loginIsTaken">Така група вже існує</label>
                                              </div>
                                                    <div class="col-md-6" style="margin-top: 25px;">
                                                <input type="hidden" name="accessHidden" class="form-control" id="accessHidden">
                                                        
                    <dl class="usersList"> 

                        <dt>
                        <a href="#">
                          <span class="hida">Доступ</span>    
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
               </div>
                    <div>
                        <input onclick="validate()" class="btn btn-primary btn-mini margintop-button" value="Додати групу" type="button">
                        <input class="btn btn-primary btn-mini margintop-button displayNone" id="sudmitData" value="Додати користувача" type="submit">
                                        </div>
            </form>
        <div class="tableMainClass">
            <table class="table" id="table-pagination" data-height="400" data-pagination="true">
                    <thead>
                        <tr>
                            <th>Назва</th>
                            <th>Користувачі в цій групі</th>
                            <th>Видалити</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${groups}" var="group">
                                <tr class="display">
                                    <th>${group.title}</th>
                                    <th>${group.users}</th>
                                    <th><a href="${Constants.URL}admin/deleteUserGroup/${group.id}">Видалити</a></th>
                                </tr>
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
            function validate(){
                var submit = true;
                $('#titleValidation').addClass('displayNone');
                $('#loginIsTaken').addClass('displayNone');
                if($('#groupName').val().length<5){
                    $('#titleValidation').removeClass('displayNone');
                    submit = false;
                }
                $.ajax({
                    type: "get",
                    url: "${Constants.URL}checkGroupName/",
                    cache: false,    
                    data:'title='+ $("#groupName").val(),
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
            
            
        $(".usersList dt a").on('click', function () {
          $(".usersList dd ul").slideToggle('fast');
        });

        $(".usersList dd ul li a").on('click', function () {
            $(".usersList dd ul").hide();
        });

        function getSelectedValue(id) {
             return $("#" + id).find("dt a span.value").html();
        }

        $(document).bind('click', function (e) {
            var $clicked = $(e.target);
            if (!$clicked.parents().hasClass("usersList")) $(".usersList dd ul").hide();
        });


        $('.mutliSelect input[type="checkbox"]').on('click', function () {
            var title = $(this).closest('.mutliSelect').find('input[type="checkbox"]').val(),
                title = $(this).val() + ",";

            if ($(this).is(':checked')) {
                var html = '<span class="accessUsersList" title="' + title + '">' + title + '</span>';
                $('.multiSel').append(html);
                //$(".hida").hide();
            } 
            else {
                $('span[title="' + title + '"]').remove();
                var ret = $(".hida");
                $('.dropdown dt a').append(ret);

            }
            var accessUsersList = "";
            $('.accessUsersList').each(function(){
                accessUsersList+=$(this).html();
            });
            accessUsersList = accessUsersList.substring(0, accessUsersList.length - 1);
            $('#accessHidden').val(accessUsersList);
        });
        $('.mutliSelect ul').find('li').each(function() {
            if('${document.access}'.indexOf($(this).find('input').val())!=-1)
                $(this).find('input').click();
        });;
            
        </script>
</t:mainHeader>
