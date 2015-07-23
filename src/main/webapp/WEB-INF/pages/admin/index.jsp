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
            <div class="adminLinks">
                <a href="${Constants.URL}index">Documents list</a>
                <a href="${Constants.URL}admin">Add documents</a>
                <c:if test="${user.role == 2}">
                    <a href="${Constants.URL}admin/addUser">Add users</a>
                </c:if>
            </div>
        <form name="addDocument" method="POST" action="${Constants.URL}system/addDocument.do" id="addDocument">
            <div class="row">
                                                    <div class="col-md-4">
                                                <label for="tlt">ID:</label>
                                                <input type="text" name="documentId" class="form-control" id="documentId">
                                                <div class="validation"></div>
                                              </div>
                                                    <div class="col-md-4">
                                                <label for="tlt">Title:</label>
                                                <input type="text" name="title" class="form-control" id="title">
                                                <div class="validation"></div>
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
                                                <label for="tlt">Date:</label>
                                                <input type="text" name="date" class="form-control" id="date">
                                                <div class="validation"></div>
                                              </div>
                                                    <div>
                                                <input type="hidden" name="file" class="form-control" id="file">
                                                <div class="validation"></div>
                                              </div>
                <div  class="col-md-4" style="margin-top: 25px;">
                                                <select id="isValid" name="isValid" class="selectpicker">
                                                    <option value="1">Valid</option>
                                                    <option value="0">Invalid</option>
                                                </select>
                </div>
            </div>
                                                <input type="hidden" name="uploader" class="form-control" id="uploader">
            
                                    <div class="row add-row file">
                                        
						<div class="col-md-4">
                                                    <div>
                                                        <label for="img">Document file</label>
                                                    
                                                        <div id="route-upload-block">
                                                            <span class="btn btn-primary">
                                                                <input class="" id="fileInput" type="file" multiple/>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                    </div>
                        <div class="row">
                            <div class="col-md-4">
                                <input class="btn btn-primary btn-mini" style="margin-top: 20px;" id="sudmitData" value="Add document" type="submit">
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

        today = mm+'/'+dd+'/'+yyyy;
        $( "#date" ).val(today);
        $('.selectpicker').selectpicker();
    });
</script>