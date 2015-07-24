<%-- 
    Document   : index
    Created on : Jul 20, 2015, 4:52:18 PM
    Author     : skywalker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:mainHeader>
	<body>
		<header>
                    <div class="logout">
                        <a href="${Constants.URL}logout">Вийти</a>
                    </div>
			<div class="login">
                                <c:if test="${user.role > 0}">
                                    <a href="${Constants.URL}admin">
					Сторінка адміністратора
                                    </a>
                                </c:if>
			</div>
                    <div class="breadCrumbs">
                        <ul id="breadCrumbsUl">
                        </ul>
                    </div>
		</header>
		<main>
                    <div class="docsList">
                        <div id="listContainer">
                            <div class="listControl">
                                <a id="expandList">Розгорнути всі</a>
                                <a id="collapseList">Приховати всі</a>
                            </div>
                            ${listHtml}
                        </div>
                    </div>
                    <div class="rightContainerMain">
			<div class="docInfo">
			</div>
			<div class="docPreview">
				<img id="imagePreview" class="displayNone" src="${Constants.URL}files/2.jpg">
				<object id="pdfPreview" class="displayNone" data="${Constants.URL}files/1.pdf" type="application/pdf" width="100%" height="100%">
				</object>
				<object id="txtPreview" class="displayNone" data="${Constants.URL}files/file.txt">
				</object>
                                <div class="previewNotAvailableBlock displayNone">
                                    <div class="previewNotAvailable">
                                        Попередній перегляд недоступний<br>
                                        <a id="previewNotAvailableLink" href="" download target="_blank">Завантажити документ</a>
                                    </div>
                                </div>
			</div>
                    </div>
                    <div class="clear"></div>
		</main>
		<footer>
		</footer>
	</body>
<script charset="UTF-8">
    var sectionId = null;
	$('main').height(window.innerHeight-$('header').height()-$('footer').height());
	
	function showDocument(url){
		$('#imagePreview').addClass('displayNone');
		$('#pdfPreview').addClass('displayNone');
		$('#txtPreview').addClass('displayNone');
		$('.previewNotAvailableBlock').addClass('displayNone');
                var checkType = url.split('.');
                switch (checkType[1]){
                    case 'pdf':
                    case 'PDF':
                        $('#pdfPreview').removeClass('displayNone');
                        $('#pdfPreview').attr("data", url);
                        break;
                    case 'jpg':
                    case 'JPG':
                    case 'jpeg':
                    case 'JPEG':
                    case 'png':
                    case 'PNG':
                        $('#imagePreview').removeClass('displayNone');
                        $('#imagePreview').attr("src", url);
                        break;
                    case 'txt':
                    case 'TXT':
                        $('#txtPreview').removeClass('displayNone');
                        $('#txtPreview').attr("data", url);
                        break;
                    case 'doc':
                    case 'DOC':
                    case 'docx':
                    case 'DOCX':
                    case 'xls':
                    case 'XLS':
                    case 'XLSX':
                    case 'xlsx':
                    case 'tiff':
                    case 'TIFF':
                        $('.previewNotAvailableBlock').removeClass('displayNone');
                        $('#previewNotAvailableLink').attr("href", url);
                        break;
                    default:
                        $('.previewNotAvailableBlock').removeClass('displayNone');
                        $('#previewNotAvailableLink').attr("href", url);
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
                url: "${Constants.URL}getDocuments/",
                cache: false, 
                data:'id='+value,
                success: function(response){
                    $('.docInfo').html("");
                    $('.docInfo').append(response);
                    $('#docInfoTable').DataTable();
                },
                error: function(response){ 
                    console.log(response);
                }
            });     
            $.ajax({
                type: "get",
                url: "${Constants.URL}makeBreadcrumbs/",
                cache: false, 
                data:'id='+value,
                success: function(response){
                    $('#breadCrumbsUl').html("");
                    $('#breadCrumbsUl').append(response);
                },
                error: function(response){ 
                    console.log(response);
                }
            });
        }
    jQuery(function($) {
        $('.rightContainerMain').width(window.innerWidth).height(window.innerHeight-$('header').height()).split({orientation:'horizontal', limit:50, position:'50%'});
        $('main').width(window.innerWidth).height(window.innerHeight-$('header').height()).split({orientation:'vertical', limit:300, position:'10%'});
        
    });
</script>
</t:mainHeader>