<%-- 
    Document   : mainHeader
    Created on : Jul 23, 2015, 4:45:06 PM
    Author     : skywalker
--%>
<jsp:useBean id="Constants" class="ua.aits.oblenergo.functions.Constants" scope="session"/>
<html>
    <head>
        <link rel="stylesheet" href="${Constants.URL}css/style.css">
        <script type="text/javascript" src="${Constants.URL}js/jquery-1.9.1.min.js"></script>
        <script src="${Constants.URL}js/jquery.min.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/scripts.js"></script>
        <link rel="stylesheet" href="${Constants.URL}css/bootstrap.min.css">
        <link rel="stylesheet" href="${Constants.URL}css/bootstrap-theme.min.css">
        <script src="${Constants.URL}js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="${Constants.URL}css/bootstrap-select.min.css" />
        <link href="${Constants.URL}img/fav.png" rel="shortcut icon" type="image/x-icon" />
        <title>Бібліотека ПАТ «Закарпаттяобленерго»</title>
    </head>
    <style>
        html{
            overflow-y: hidden;
        }
        body{
            background-image: url(${Constants.URL}img/bgNew.jpg);
            background-size: cover;
            background-position: center;
        }
        
    </style>
</html>
    <body>
        <form action="${Constants.URL}login.do" method="POST" id="loginForm" name="auth">
            <div class="displayTable">
                <div class="loginPassBlock">
                        <div class="loginPass">
                            <label id="loginLabel" for="username">Ім’я користувача</label><br>
                            <input type="text" name="username" class="form-control" id="username">
                        </div>
                        <div class="loginPass">
                            <label for="passwd">Пароль</label><br>
                            <input type="password" name="password" class="form-control" id="passwd">
                        </div>
                            <button onclick="trySubmit()" class="btn btn-primary btn-login" id="check-button" type="button">Вхід</button> 
                            <button class="btn btn-primary btn-login displayNone" id="logInButton" type="submit">Вхід</button> 
                        <div class="validation"></div>
                </div>
            </div>
        </form>
                        <a class="developedLink" href="http://www.aits.ua" target="_blank">Developed by AITS</a>
    </body>
</html>
<script>
    $( document ).ready(function() {
        $(".btn-login.cncl").click(function(){
            $("#username").val("");
            $("#passwd").val("");
        }); 
        $("#loginLabel").click();
        $('.displayTable').height(window.innerHeight-35);
    
        $('input').on("keypress", function(e) {
            if (e.keyCode == 13) {
                var inputs = $(this).parents("form").eq(0).find(":input");
                var idx = inputs.index(this);
                if (idx == inputs.length - 1) {
                    inputs[0].select()
                } else {
                    try{
                        inputs[idx + 1].focus();
                        inputs[idx + 1].select();
                    }catch(err){
                        trySubmit();
                    }
                }
                return false;
            }
        });
    });
    function trySubmit(){
        
            $(".validation").html("");
            $.ajax({
             type: "get",
             url: "${Constants.URL}checkLoginPass/",
             cache: false,    
             data:'login='+ $("#username").val() +'&password='+$("#passwd").val(),
             success: function(response){
                 console.log(response);
              if(response === "false"){
                  $(".validation").html("<span style='color:red'>Невірне ім’я користувача або пароль</span>");
              }
              else {
                  $("#loginForm").submit();
              }
             },
             error: function(response){      
              console.log(response);
             }
            });
    }
</script>