<%-- 
    Document   : addUser
    Created on : Jul 23, 2015, 2:00:47 PM
    Author     : skywalker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:mainHeader>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-12 marginTop greenText">
                    <h4>Редагувати користувача</h4>
                </div>
            </div>
            <hr>
        <form name="userEdit" method="POST" action="${Constants.URL}admin/edituser.do" id="editUser">
                
               <div class="row marginTop">
                                                    <div class="col-md-3">
                                                <label class="greenText">Логін:<span class="red-star">*</span></label>
                                                <input type="text" name="username" class="form-control" id="username" value="${user.name}">
                                                <label class="displayNone text-danger" id="loginValidation">Неправильно заповнене поле</label>
                                                <label class="displayNone text-danger" id="loginIsTaken">Користувач з таким іменем вже існує</label>
                                              </div>
                                                    <div class="col-md-3">
                                                <label class="greenText">Пароль:<span class="red-star">*</span></label>
                                                <input type="text" name="password" class="form-control" id="password" value="${user.pass}">
                                                <label class="displayNone text-danger" id="passValidation">Неправильно заповнене поле</label>
                                              </div>
                                                <input type="hidden" name="role" class="form-control" id="role">
               </div>
<hr>
               <div class="row marginTop">
                                                    <div class="col-md-3">
                                                <label class="greenText">Примітки про користувача</label>
                                                <input type="text" name="descr" class="form-control" id="descr" value="${user.description}">
                                                <input type="hidden" name="id" class="form-control" id="id" value="${user.id}">
                                                <div class="validation"></div>
                                              </div>
                                                    <div class="col-md-3">
                                                <label class="greenText">ПІБ</label>
                                                <input type="text" name="fullName" class="form-control" id="fullName" value="${user.fullName}">
                                                <div class="validation"></div>
                                              </div>
               </div>
<hr>
               <div class="row marginTop">
                                                    <div class="col-md-12">
                                                        <label class="greenText">Роль користувача:<span class="red-star">*</span></label><br>
                                                
    <label class="radio-inline">
      <input id="role0" type="radio" value="0" name="optradio">Користувач
    </label>
    <label class="radio-inline">
      <input id="role1" type="radio" value="1" name="optradio">Редактор
    </label>
    <label class="radio-inline">
        <input id="role2" type="radio" value="2" name="optradio">Адміністратор
    </label>
                                              </div>
               </div>
<hr>
               <div class="row marginTop">
                        <div class="col-md-3">
                        <input onclick="validate()" class="btn btn-success btn-mini addButton" value="Редагувати користувача" type="button">
                        <input class="btn btn-primary btn-mini margintop-button displayNone" id="sudmitData" value="Додати користувача" type="submit">
                                        </div>
                            <div class="col-md-2">
                        <a class="btn btn-danger btn-mini badButton" href="${Constants.URL}admin/users">Повернутись до списку</a>
                            </div>
            </form>
               </div>
        </div>
    </body>
    <script>
        $( document ).ready(function() {
            $('#usersPage').css('background','#418a84');
            $('.selectpicker').selectpicker();
            setTimeout(function(){
                $('#role${user.role}').click();
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
            if($('#username').val().length<1){
                $('#loginValidation').removeClass('displayNone');
                submit = false;
            }
            if($('#password').val().length<1){
                $('#passValidation').removeClass('displayNone');
                submit = false;
            }
            
            $.ajax({
                type: "get",
                url: "${Constants.URL}checkUsernameEdit/",
                cache: false,    
                data:'login='+ $("#username").val(),
                success: function(response){
                    console.log(response);
                    if(response === "true"){
                        if(submit)
                            $('#editUser').submit();
                    }
                    else {
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
