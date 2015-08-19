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
    </style>
	<body>
		<main>
                    <div class="docsList">
                        <div id="listContainer">
                            <div class="listControl">
                                <input class="btn btn-primary btn-mini margintop-button"
                                       id="expandList" value="Згорнути / Розгорнути" type="button">
                                <!--<input onclick="changeButton()" class="btn btn-primary btn-mini margintop-button"
                                       id="collapseList" value="Згорнути" type="button">-->
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
    var dateCounter = 4;
    var table;
        var dateSearch = '<div class="rangeBigContainer"><span>Пошук за датою</span>'+
                    '<div class="input-daterange input-group" id="datepicker">'+
                    '<span class="input-group-addon">від</span>'+
                    '<input id="min" type="text" class="form-control" name="start" />'+
                    '<span class="input-group-addon">до</span>'+
                    '<input id="max" type="text" class="form-control" name="end" />'+
                '</div></div>';
	$('main').height(window.innerHeight-$('header').height()-$('footer').height());
	
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
                    $('header').height(105);
                    var text = $('#docInfoTable_filter label').html();
                    $('#table-pagination tfoot th').each( function () {
                        if($(this).text()!=""){
                            var title = $('#table-pagination thead th').eq( $(this).index() ).text();
                            if(title=="Дата"){
                                $(this).html( '<input id="rowDate" title="Пошук по '+title+'" class="form-control tableSearch individualSearch" type="text" placeholder="Пошук по '+$(this).text()+'" />' );
                            }else{
                                $(this).html( '<input title="Пошук по '+title+'" class="form-control tableSearch individualSearch" type="text" placeholder="Пошук по '+$(this).text()+'" />' );   
                            }
                        }
                    } );
                    if(value!='0'){
                        table = $('#table-pagination').DataTable({
                                columnDefs: [
                                    { type: 'date-eu', targets: 3 }
                                ],
                                "dom": 'Zlfrtip'
                            });
                    }else{
                        table = $('#table-pagination').DataTable({
                                columnDefs: [
                                    { type: 'date-eu', targets: 4 }
                                ],
                                "dom": 'Zlfrtip'
                            });
                    }
                    table.columns().every( function () {
                        var that = this;
                        $( 'input', this.footer() ).on( 'keyup change', function () {
                            that
                                .search( this.value )
                                .draw();
                        } );
                    } );
                    $('#table-pagination_length').append("&nbsp;<div class='hideSearch btn btn-primary btn-mini' onclick='hideSearch()'>Показати<br>пошук</div>");
                        $('tfoot').hide(0);
                        isHiddenSearch = false;
                        $('#table-pagination_filter').after(dateSearch);
                        $('.input-daterange').datepicker({
                            format: "dd.mm.yyyy",
                            weekStart: 1
                        });
                        $('#rowDate').datepicker({
                            format: "dd.mm.yyyy",
                            weekStart: 1
                        });
        $('#datepicker').change(function(){
            table.draw();
        });
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
        $('#indexPage').css('background','#14A86B');
        $('.rightContainerMain').width(window.innerWidth).height(window.innerHeight-$('header').height()-65).split({orientation:'horizontal', limit:0, position:'60%'});
        $('main').width(window.innerWidth).height(window.innerHeight-$('header').height()-60).split({orientation:'vertical', limit:220, position:'30%'});
        $('.hsplitter').append('<img src="${Constants.URL}/img/verticalResize.png">');
        $('.vsplitter').append('<img src="${Constants.URL}/img/horizontalResize.png">');
        //$('.verticalResize').position($('.splitterMask').position());
    });
</script>
</t:mainHeader>