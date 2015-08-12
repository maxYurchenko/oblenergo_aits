<%-- 
    Document   : mainHeader
    Created on : Jul 23, 2015, 4:45:06 PM
    Author     : skywalker
--%>
<%@tag description="Index Page Template" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<jsp:useBean id="Constants" class="ua.aits.oblenergo.functions.Constants" scope="session"/>
<html>
    <head>
        <link rel="stylesheet" href="${Constants.URL}css/bootstrap-switch.css">
        <link rel="stylesheet" href="${Constants.URL}css/style.css">
        <script type="text/javascript" src="${Constants.URL}js/jquery-1.9.1.min.js"></script>
        <script src="${Constants.URL}js/jquery.min.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/scripts.js"></script>
        <link rel="stylesheet" href="${Constants.URL}css/bootstrap.min.css">
        <link rel="stylesheet" href="${Constants.URL}css/bootstrap-theme.min.css">
        <script src="${Constants.URL}js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/bootstrap-switch.js"></script>
        <link rel="stylesheet" href="${Constants.URL}css/bootstrap-select.min.css" />
        <script src="${Constants.URL}js/bootstrap-select.min.js"></script>
        <link rel="stylesheet" href="${Constants.URL}css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="${Constants.URL}css/bootstrap-datepicker.min.css">
        <script src="${Constants.URL}js/jquery.dataTables.min.js"></script>
        <script src="${Constants.URL}js/daterangefilter.js"></script>
        <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
        <script type="text/javascript" src="${Constants.URL}js/jquery.splitter-0.15.0.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/dataTables.colResize.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/date-de.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/dropzone.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="${Constants.URL}js/bootstrap-datepicker.min.js"></script>
        <link rel="stylesheet" href="${Constants.URL}css/jquery.splitter.css">
        <link href="${Constants.URL}img/icon.ico" rel="shortcut icon" type="image/x-icon" />
        <title>Бібліотека ПАТ «Закарпаттяобленерго»</title>
        <meta charset="UTF-8">
        <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
        

    </head>
    <c:if test="${sessionScope.user == null}">
        <script>window.location.href = "${Constants.URL}login";</script>
        
    </c:if>
		<header>
                    <div class="row">
                        <div class="col-md-12">
                    <div class="logout">
                              <div class="dropdown">
  <div class="userNameHeader" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    ${sessionScope.user.name}
    <span class="caret"></span>
  </div>
  <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
    <li><a href="${Constants.URL}logout"><span class="glyphicon glyphicon-off"></span>Вийти</a></li>
  </ul>
</div>
                       
                    </div>
			<div class="login">
            <div class="adminLinks">
                <a id="indexPage" href="${Constants.URL}index">Список документів</a>
                <c:if test="${sessionScope.user.role > 0}">
                    <a id="docsPage" href="${Constants.URL}admin">Редактор документів</a>
                    <c:if test="${sessionScope.user.role == 2}">
                        <a id="typesPage" href="${Constants.URL}admin/types">Редактор типів</a>
                    </c:if>
                    <a id="sectionsPage" href="${Constants.URL}admin/sections">Редактор розділів</a>
                </c:if>
                <c:if test="${sessionScope.user.role == 2}">
                    <a id="usersPage" href="${Constants.URL}admin/users">Редактор користувачів</a>
                    <a id="groupsPage" href="${Constants.URL}admin/userGroups">Редактор груп</a>
                </c:if>
            </div>
                        </div>
			</div>
                    </div>
                    <div class="row breadCrumbs">
                        <div class="col-md-12">
                    <div class="breadCrumbs">
                        <ul id="breadCrumbsUl">
                        </ul>
                    </div>
                        </div>
                    </div>
		</header>
        <jsp:doBody/> 
        <script>
            var tableId = null; 
            var isHiddenSearch = true;
            function hideSearch(){
                if(isHiddenSearch){
                    $('tfoot').hide('slow');
                    $('.hideSearch').text('Показати пошук по стовбцях');
                    isHiddenSearch = false;

                }else{
                    $('tfoot').show('slow');
                    $('.hideSearch').text('Приховати пошук по стовбцях');
                    isHiddenSearch = true;
                }
            }
            $( document ).ready(function() {
                $('th').click(function(){
                    //console.log($(this).text());
                });
            });
            
	function showDocument(url, id){
                if(tableId!=null)
                {
                    $('#tableTr'+tableId).css('background-color',color);
                }
                tableId = id;
                color = $('#tableTr'+tableId).css('background-color');
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
        </script>
</html>