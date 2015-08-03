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
            <div class="row">
                <div class="col-md-12 marginTop greenText">
                    <h4>Додавання користувача</h4>
                </div>
            </div>
            <hr>
            
        <form name="userAdd" method="POST" action="${Constants.URL}admin/adduser.do" id="addUser">
                
<input style="display:none;" type="text" name="somefakename" />
<input style="display:none;" type="password" name="anotherfakename" />
               <div class="row marginTop">
                                                    <div class="col-md-3">
                                                        <label class="greenText">Логін:<span class="red-star">*</span></label>
                                                <input type="text" name="username" class="form-control" id="username">
                                                <label class="displayNone text-danger" id="loginValidation">Неправильно заповнене поле</label>
                                                <label class="displayNone text-danger" id="loginIsTaken">Користувач з таким іменем вже існує</label>
                                              </div>
                                                    <div class="col-md-3">
                                                <label class="greenText">Пароль:<span class="red-star">*</span></label>
                                                <input type="password" name="password" class="form-control" id="password">
                                                <label class="displayNone text-danger" id="passValidation">Неправильно заповнене поле</label>
                                              </div>
                                                <input type="hidden" name="role" class="form-control" id="role">
               </div>
<hr>
               <div class="row marginTop">
                                                    <div class="col-md-6">
                                                <label class="greenText">Примітки про користувача</label>
                                                <input type="text" name="descr" class="form-control" id="descr">
                                                <div class="validation"></div>
                                              </div>
               </div>
<hr>
               <div class="row marginTop">
                                                    <div class="col-md-4">
                                                        <label class="greenText">Роль користувача:<span class="red-star">*</span></label><br>
                                                
    <label class="radio-inline">
      <input id="defaultRole" type="radio" value="0" name="optradio">Користувач
    </label>
    <label class="radio-inline">
      <input type="radio" value="1" name="optradio">Редактор
    </label>
    <label class="radio-inline">
        <input type="radio" value="2" name="optradio">Адміністратор
    </label>
                                              </div>
               </div>
<hr>
               <div class="row marginTop">
                        <div class="col-md-2">
                        <input onclick="validate()" class="btn btn-success btn-mini" value="Додати користувача" type="button">
                        </div>
                            <div class="col-md-2">
                        <a class="btn btn-danger btn-mini" href="${Constants.URL}admin/users">Повернутись до списку</a>
                            </div>
                        </div>
                </div>
            </form>
    </body>
    <script>
        $( document ).ready(function() {
            $('#usersPage').css('background','#14A86B');
            $('.selectpicker').selectpicker();
            setTimeout(function(){
                $('#defaultRole').click();
            }, 100);
            $('.radio-inline').click(function(){
                $('#role').val($(this).find('input').val());
            });
        });
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
                            $('#addUser').submit();
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