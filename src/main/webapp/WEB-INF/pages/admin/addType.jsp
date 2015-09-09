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
                    <h4>Редагування типу</h4>
                </div>
            </div>
            <hr>
        <form name="userAdd" method="POST" action="${Constants.URL}admin/addType.do" id="addUser">
                
               <div class="row">
                                                    <div class="col-md-4">
                                                        <label class="greenText">Назва типу:<span class="red-star">*</span></label>
                                                <input type="text" name="title" class="form-control" id="title">
                                                <label class="displayNone text-danger" id="titleValidation">Неправильно заповнене поле</label>
                                              </div>
               </div>
            <hr>
                    <div class="row">
                        <div class="col-md-2">
                        <input onclick="validate()" class="btn btn-success btn-mini margintop-button addButton" value="Додати тип" type="button">
                        <input class="btn btn-primary btn-mini margintop-button displayNone" id="sudmitData" value="Додати користувача" type="submit">
                        </div>
                            <div class="col-md-2">
                        <a class="btn btn-danger btn-mini badButton" href="${Constants.URL}admin/types">Повернутись до списку</a>
                            </div>
                    </div>
            </form>
        </div>
    </body>
    <script>
        $( document ).ready(function() {
            $('#typesPage').css('background','#418a84');
            $('.selectpicker').selectpicker();
        });
            function validate(){
                var submit = true;
                $('#titleValidation').addClass('displayNone');
                if($('#title').val().length<1){
                    $('#titleValidation').removeClass('displayNone');
                    submit = false;
                }
                if(submit)
                    $('#sudmitData').click();
            }
    </script>
</t:mainHeader>