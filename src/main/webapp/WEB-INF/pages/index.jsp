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
    <style>
        #expList .collapsed {
            background-image: url("${Constants.URL}/img/folder_closed.png");
            background-size: 15px 15px;
            background-position: 0px 0px; 
        }
        #expList .expanded {
            background-image: url("${Constants.URL}/img/folder_open.png");
            background-size: 15px 15px;
            background-position: 0px 0px; 
        }
        header{
            height: 75px;
        }
    </style>
	<body>
		<main>
                    <div class="docsList">
                        <div id="listContainer">
                            <div class="listControl">
                                <input onclick="changeButton()" class="btn btn-primary btn-mini margintop-button"
                                       id="expandList" value="Розгорнути" type="button">
                                <input onclick="changeButton()" class="btn btn-primary btn-mini margintop-button"
                                       id="collapseList" value="Згорнути" type="button">
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
    var tableId = null; 
	$('main').height(window.innerHeight-$('header').height()-$('footer').height());
	
	function showDocument(url, id){
                if(tableId!=null)
                    $('#tableTr'+tableId).css('background-color','white');
                tableId = id;
                $('#tableTr'+tableId).css('background-color','#d4d4d4');
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
                mimeType:"text/html; charset=UTF-8",
                data:'id='+value+"&userId=${sessionScope.user.id}&userRole=${sessionScope.user.role}&userGroup=${sessionScope.user.groupAccess}",
                success: function(response){
                    $('.docInfo').html("");
                    $('.docInfo').append(response);
                    $('#docInfoTable').DataTable();
                    var text = $('#docInfoTable_filter label').html();
                },
                error: function(response){ 
                    console.log(response);
                }
            });     
            $.ajax({
                type: "get",
                url: "${Constants.URL}makeBreadcrumbs/",
                cache: false, 
                mimeType:"text/html; charset=UTF-8",
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
        $('#indexPage').css('border-bottom','3px solid #428bca');
        $('.rightContainerMain').width(window.innerWidth).height(window.innerHeight-$('header').height()).split({orientation:'horizontal', limit:0, position:'60%'});
        $('main').width(window.innerWidth).height(window.innerHeight-$('header').height()).split({orientation:'vertical', limit:300, position:'30%'});
        
    });
</script>
</t:mainHeader>