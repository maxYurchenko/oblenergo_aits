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
        </div>
    </body>
    <script>
        $( document ).ready(function() {
            $('#usersPage').css('border-bottom','3px solid #428bca');
            $('.selectpicker').selectpicker();
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