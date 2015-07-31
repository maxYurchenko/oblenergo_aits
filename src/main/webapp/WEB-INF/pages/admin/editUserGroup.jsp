<%-- 
    Document   : addDocument
    Created on : Jul 29, 2015, 6:23:52 PM
    Author     : skywalker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<!DOCTYPE html>
<t:mainHeader>
    <body>
        <div class="container">
            
        <form name="userAdd" method="POST" action="${Constants.URL}admin/editusergroup.do" id="addUser">
                
               <div class="row">
                                                    <div class="col-md-6">
                                                <label>Назва групи:</label>
                                                <input type="hidden" name="id" class="form-control" id="id" value="${group.id}">
                                                <input type="text" name="groupName" class="form-control" id="groupName" value="${group.title}">
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
                        <input onclick="validate()" class="btn btn-primary btn-mini margintop-button" value="Рендагувати групу" type="button">
                        <input class="btn btn-primary btn-mini margintop-button displayNone" id="sudmitData" value="Додати користувача" type="submit">
                                        </div>
            </form>
        </div>
    </body>
    <script>
        $( document ).ready(function() {
            $('#groupsPage').css('border-bottom','3px solid #428bca');
            $('.selectpicker').selectpicker();
            console.log("${userNames}");
            $('li').each(function(){
                if("${group.users}".indexOf($(this).text())!=-1){
                    $(this).find('input').click();
                }
            });
        });
            function validate(){
                var submit = true;
                $('#titleValidation').addClass('displayNone');
                $('#loginIsTaken').addClass('displayNone');
                if($('#groupName').val().length<5){
                    $('#titleValidation').removeClass('displayNone');
                    submit = false;
                }
                /*$.ajax({
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
                });*/
                if(submit)
                    $('#sudmitData').click();
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
        });
    </script>
</t:mainHeader>