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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/scripts.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/select/js/bootstrap-select.js"></script>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/css/bootstrap-select.min.css" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/js/bootstrap-select.min.js"></script>
        <link rel="stylesheet" href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css">
        <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
        

    </head>
</html>
    <body>
        <form action="${Constants.URL}login.do" method="POST" id="loginForm" name="auth">
            <div class="row">
                <div class="col-md-4">
                </div>
                <div class="col-md-4">
                    <div class="loginPass">
                        <label for="username">Username</label><br>
                        <input type="text" name="username" class="form-control" id="username">
                    </div>
                </div>
                <div class="col-md-4">
                </div>
            </div>
            <div class="row" style="margin-top:20px;">
                <div class="col-md-4">
                </div>
                <div class="col-md-4">
                    <div class="loginPass">
                        <label for="passwd">Password</label><br>
                        <input type="password" name="password" class="form-control" id="passwd">
                    </div>
                </div>
                <div class="col-md-4">
                </div>
                <div>
                    <div class="validation"></div>
                </div>
            </div>
            <div class="row" style="margin-top:20px; text-align: center;">
                    <div class="col-md-4">
                    </div>
                    <div class="col-md-4">
                        <button class="btn btn-login cncl btn-danger" type="reset" >Cancel</button>
                        <button class="btn btn-primary btn-login" id="log-button">Log In</button> 
                    </div>
                    <div class="col-md-4">
                    </div>
            </div>
        </form>
    </body>
</html>
<script>
    $( document ).ready(function() {
        
    $(".btn-login.cncl").click(function(){
        $("#username").val("");
        $("#passwd").val("");
    });
    $("#log-button").click(function(){
        $(".validation").html("");
        $.ajax({
         type: "get",
         url: "${Constants.URL}checkLoginPass/",
         cache: false,    
         data:'login='+ $("#username").val() +'&password='+$("#passwd").val(),
         success: function(response){
             console.log(response);
          if(response === "false"){
              $(".validation").html("<span style='color:red'>Bad login or password</span>");
          }
          else {
              $("#loginForm").submit();
          }
         },
         error: function(response){      
          console.log(response);
         }
        });
    });  
    });
</script>