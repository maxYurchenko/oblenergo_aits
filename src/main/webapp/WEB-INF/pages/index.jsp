<%-- 
    Document   : index
    Created on : Jul 20, 2015, 4:52:18 PM
    Author     : skywalker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<!DOCTYPE html>
<html>
	<head>
            <link rel="stylesheet" href="${Constants.URL}css/style.css">
            <script type="text/javascript" src="${Constants.URL}js/jquery-1.9.1.min.js"></script>
            <script type="text/javascript" src="${Constants.URL}js/scripts.js"></script>
	</head>
	<body>
		<header>
                    <div class="logo">
                        <form class="searchMenuSmall" action="${Constants.URL}search" method="GET" id="searchFormSmall">
                            <input type="text" name="find" id="searchBoxSmall">
                            <button type="button" id="searchButtonActiveSmall">
                                Search
                            </button>
                        </form>
                    </div>
			<div class="login">
				<a href="#">
					Alex
				</a>
			</div>
		</header>
		<main>
                    <div class="docsList">
                        <div id="listContainer">
                            <div class="listControl">
                                <a id="expandList">Expand All</a>
                                <a id="collapseList">Collapse All</a>
                            </div>
                            ${listHtml}
                        </div>
			</div>
			<div class="docInfo">
			</div>
			<div class="docPreview">
				<img id="imagePreview" class="displayNone" src="${Constants.URL}files/2.jpg">
				<object id="pdfPreview" class="displayNone" data="${Constants.URL}files/1.pdf" type="application/pdf" width="100%" height="100%">
				</object>
				<object id="txtPreview" class="displayNone" data="${Constants.URL}files/file.txt">
				</object>
			</div>
		</main>
		<footer>
		</footer>
	</body>
</html>
<script>
    var sectionId = null;
	$('main').height(window.innerHeight-$('header').height()-$('footer').height());
	
	function showDocument(url){
		$('#imagePreview').addClass('displayNone');
		$('#pdfPreview').addClass('displayNone');
		$('#txtPreview').addClass('displayNone');
                var checkType = url.split('.');
                switch (checkType[1]){
                    case 'pdf':
                        $('#pdfPreview').removeClass('displayNone');
                        $('#pdfPreview').attr("data", url);
                        break;
                    case 'jpg':
                        $('#imagePreview').removeClass('displayNone');
                        $('#imagePreview').attr("src", url);
                        break;
                    case 'txt':
                        $('#txtPreview').removeClass('displayNone');
                        $('#txtPreview').attr("data", url);
                        break;
                }
	}
        function getChildDocuments(value){
            if(sectionId!=null)
                $('#section'+sectionId).css('font-weight','100');
            sectionId = value;
            $('#section'+sectionId).css('font-weight','600');
            $.ajax({
                type: "get",
                url: "${Constants.URL}system/checkLoginPass/",
                cache: false, 
                data:'id='+value,
                success: function(response){
                    $('.docInfo').html("");
                    $('.docInfo').append(response);
                },
                error: function(response){ 
                    console.log(response);
                }
            });       
        }
</script>