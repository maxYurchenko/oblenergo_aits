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
        <form name="addDocument" method="POST" action="${Constants.URL}system/addDocument.do" id="addDocument">
                
               
						<div class="col-lg-2 field">
                                                    <div class="form-group">
                                                <label for="tlt">ID:</label>
                                                <input type="text" name="documentId" class="form-control" id="documentId">
                                                <div class="validation"></div>
                                              </div>
						</div>
                                                <div class="col-lg-2 field">
                                                    <div class="form-group">
                                                <label for="tlt">Title:</label>
                                                <input type="text" name="title" class="form-control" id="title">
                                                <div class="validation"></div>
                                              </div>
						</div>
                                                <div class="col-lg-2 field">
                                                    <div class="form-group">
                                                <label for="tlt">Section:</label>
                                                <input type="text" name="section" class="form-control" id="section">
                                                <div class="validation"></div>
                                              </div>
						</div>
                                                <div class="col-lg-2 field">
                                                    <div class="form-group">
                                                <label for="tlt">Date:</label>
                                                <input type="text" name="date" class="form-control" id="date">
                                                <div class="validation"></div>
                                              </div>
						</div>
                                                <div class="col-lg-2 field">
                                                    <div class="form-group">
                                                <input type="hidden" name="file" class="form-control" id="file">
                                                <div class="validation"></div>
                                              </div>
						</div>
            
                                    <div class="row add-row route-file">
                                        
						<div class="col-lg-10 field">
                                                    <div class="form-group">
                                                        <label for="img">Route file</label>
                                                    
                                                        <div id="route-upload-block">
                                                            <span class="btn btn-primary btn-file">
                                                                Browse file<input class="" id="route-input" type="file" multiple/>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="load-route"><img src="${Constants.URL}img/loader.gif"/></div>
                                                </div>
                                    </div>
                    <div class="col-lg-2">
                        <input class="btn btn-primary btn-mini margintop-button" id="sudmitData" value="Add document" type="submit">
                                        </div>
            </form>
    </body>
</t:mainHeader>
<script>
$('.route-file').on('change', '#route-input', function() {
        $(".load-route").show();
        var data = new FormData();
        data.append('upload', jQuery('#route-input')[0].files[0]);
        jQuery.ajax({
                    url: '${Constants.URL}uploadFile',
                    data: data,
                    cache: false,
                    contentType: false,
                    processData: false,
                    type: 'POST',
                    success: function(data){
                        $(".load-route").hide();
                        $("#fullname-route").val(data);
                        $("<span class='upload-success'><img src='"+"${Constants.URL}"+"img/symbol_check.png'/> Uploaded! <span class='route-name'>("+data+")</span> </span>").appendTo("#route-upload-block");
                        $("#route-upload-block .btn-file").hide();
                        $('#file').val('files/'+data);
                    }
                    });
});
</script>