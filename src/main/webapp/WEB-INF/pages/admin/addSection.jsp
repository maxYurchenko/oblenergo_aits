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
        <form name="userAdd" method="POST" action="${Constants.URL}admin/addsection.do" id="addUser">
                
               <div class="row">
                                                    <div class="col-md-6">
                                                <label>Назва розділу:</label>
                                                <input type="text" name="sectionName" class="form-control" id="sectionName">
                                                <label class="displayNone text-danger" id="titleValidation">Неправильно заповнене поле</label>
                                              </div>
                                                    <div class="col-md-6" style="margin-top: 25px;">
                                                <select id="sectionParentId" name="sectionParentId" class="selectpicker">
                                                    <option value="0">Головний розділ</option>
                                                    <c:forEach items="${sections}" var="section">
                                                        <option value="${section.id}">${section.title}</option>
                                                    </c:forEach>
                                                </select>
                                              </div>
               </div>
                    <div>
                        <input onclick="validate()" class="btn btn-primary btn-mini margintop-button" value="Додати розділ" type="button">
                        <input class="btn btn-primary btn-mini margintop-button displayNone" id="sudmitData" value="Додати користувача" type="submit">
                                        </div>
            </form>
        </div>
    </body>
    <script>
        $( document ).ready(function() {
            $('#sectionsPage').css('background','#14A86B');
            $('.selectpicker').selectpicker();
        });
            function validate(){
                var submit = true;
                $('#titleValidation').addClass('displayNone');
                if($('#sectionName').val().length<5){
                    $('#titleValidation').removeClass('displayNone');
                    submit = false;
                }
                if(submit)
                    $('#sudmitData').click();
            }
    </script>
</t:mainHeader>