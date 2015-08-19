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
        <div class="containerSplit">
        <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
            <a href="${Constants.URL}admin/addDocument" class="btn marginTop btn-success btn-mini addButton">Додати новий документ</a>
                    </div>
                </div>
            
                <div class="tableMainClass">
                    <table style="visibility: hidden" class="table table-striped table-bordered" id="table-pagination" data-height="400" data-pagination="true">
                            <thead>
                                <tr class="tableHeader">
                                    <th>Номер документа</th>
                                    <th>Назва документа</th>
                                    <th>Розділ документа</th>
                                    <th style="width: 50px;">Дата</th>
                                    <th>Ключові слова</th>
                                    <th></th>
                                    <th style="width: 20px;"></th>
                                    <c:if test="${user.role == 2}">
                                        <th class="text-center vcenter" style="width: 90px;">Відображати</th>
                                    </c:if>
                                        <th class="text-center vcenter" style="width: 90px;">Дійсний</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr class="tableHeader">
                                    <th data-column-index="0" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">номеру документа</th>
                                    <th data-column-index="1" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">назві документа</th>
                                    <th data-column-index="2" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">розділу документа</th>
                                    <th data-column-index="3" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1" style="width: 50px;">даті</th>
                                    <th data-column-index="4" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">ключовим словам</th>
                                    <th style="width: 25px;"></th>
                                    <th style="width: 20px;"></th>
                                    <c:if test="${user.role == 2}">
                                        <th style="width: 70px;"></th>
                                    </c:if>
                                    <th></th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <c:forEach items="${documents}" var="document">
                                    <c:if test="${document.isDelete==0 || user.role==2}">
                                        <tr id="tableTr${document.id}" <c:if test="${document.valid==0}">class="inValidDoc display"</c:if>>
                                            <th data-column-index="0" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1" onclick="showDocument('${document.path}','${document.id}')">
                                                <span>${document.clientId}</span>
                                            </th>
                                            <th data-column-index="1" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1" onclick="showDocument('${document.path}','${document.id}')">${document.title}</th>
                                            <th data-column-index="2" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1" onclick="showDocument('${document.path}','${document.id}')">${document.parentName}</th>
                                            <th data-column-index="3" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1" onclick="showDocument('${document.path}','${document.id}')">${document.date}</th>
                                            <th data-column-index="4" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1" onclick="showDocument('${document.path}','${document.id}')">${document.tags}</th>
                                            <th><a target='_blank' download href="${Constants.URL}${document.path}"><img style="width: 20px;" src="${Constants.URL}img/dl.png"></a></th>
                                            <th><a href="${Constants.URL}admin/editDocument/${document.id}"><img style="width: 20px;" src="${Constants.URL}/img/edit.png"></a></th>
                                            <c:if test="${user.role == 2}">
                                                <th class="publishCheckboxBlock vcenter text-center invisibleText" id="publishCheckboxBlock${document.id}" 
                                                    value="${document.id}">${document.isDelete}
                                                    <c:choose>
                                                        <c:when test="${document.isDelete == 1}">
                                                            <input type="checkbox" name="my-checkbox" id="deleteCheckBox${document.id}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="checkbox" name="my-checkbox" checked
                                                                                         id="deleteCheckBox${document.id}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </th>
                                            </c:if>
                                            <c:if test="${user.role == 2}">
                                                <th class="validCheckboxBlock vcenter invisibleText text-center" id="validCheckboxBlock${document.id}" 
                                                    value="${document.id}">${document.valid}
                                                    <c:choose>
                                                        <c:when test="${document.valid == 0}">
                                                            <input type="checkbox" name="my-checkbox" id="validCheckBox${document.id}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="checkbox" name="my-checkbox" checked
                                                                                         id="validCheckBox${document.id}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </th>
                                            </c:if>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </thead>
                    </table>
                </div>
            </div>
        <div class="container-fluid">
                                    <div class="row maxHeight">
                                        <div class="col-md-12 maxHeight">
                                            
			<div class="docPreview maxHeight">
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
                                    </div>
        </div>
        </div>
    </body>
</t:mainHeader>
<script>
    var table;
    var dateCounter = 3;
    $( document ).ready(function() {
        $('table').css('visibility','visible');
        $('.cutLink').each(function(){
            $(this).text($(this).text().substring(6, $(this).text().length));
        });
        $('#docsPage').css('background','#14A86B');
        $("[name='my-checkbox']").bootstrapSwitch();
        $('.selectpicker').selectpicker();
        // Setup - add a text input to each footer cell
    jQuery(function($) {
        $('.containerSplit').height(window.innerHeight-$('header').height()).split({orientation:'horizontal', limit:0, position:'85%'});
    });
    $('#table-pagination tfoot th').each( function () {
        if($(this).text()!=""){
            var title = $('#table-pagination tfoot th').eq( $(this).index() ).text();
            if(title=="даті"){
                $(this).html( '<input id="rowDate" title="Пошук по '+title+'" class="form-control tableSearch individualSearch" type="text" placeholder="Пошук по '+$(this).text()+'" />' );
            }else{
                $(this).html( '<input title="Пошук по '+title+'" class="form-control tableSearch individualSearch" type="text" placeholder="Пошук по '+$(this).text()+'" />' );   
            }
        }
    } );
 
    // DataTable
    table = $('#table-pagination').DataTable({
                        columnDefs: [
                            { type: 'date-eu', targets: 3 }
                        ],
                        "dom": 'Zlfrtip'
                    });
 
    // Apply the search
    table.columns().every( function () {
        var that = this;
 
        $( 'input', this.footer() ).on( 'keyup change', function () {
            that
                .search( this.value )
                .draw();
        } );
    } );
                    $('#table-pagination_length').append("&nbsp;<div class='hideSearch btn btn-primary btn-mini' onclick='hideSearch()'>Показати<br>пошук</div>");
        $('#showMainSearch').click(function(){
            $('#showMainSearch').hide(0);
            $('#mainSearch').removeClass('displayNone');
            $('#mainSearch').hide(0);
            $('#mainSearch').show('slow');
        });
        $('#table-pagination_paginate').click(function(){
            $("[name='my-checkbox']").bootstrapSwitch();
        });
        $('#table-pagination').click(function(){
            $("[name='my-checkbox']").bootstrapSwitch();
        });
        $('.dataTables_wrapper').change(function() {
            $("[name='my-checkbox']").bootstrapSwitch();
        });
        $('.dataTables_filter').on('input', function() {
            $("[name='my-checkbox']").bootstrapSwitch();
        });
        $('.publishCheckboxBlock').on('switchChange.bootstrapSwitch', function(event, state) {
            var isDelete = 0;
            if(state) {
                isDelete = 0;
            }else{
                isDelete = 1;
            }
            var id = $(this).attr("value");
            $.ajax({
                type: "get",
                url: "${Constants.URL}deleteDoc/",
                cache: false, 
                data:'id='+id+'&publish='+isDelete,
                success: function(response){
                    console.log(response);
                },
                error: function(response){ 
                    console.log(response);
                }
            }); 
        });
        $('.validCheckboxBlock').on('switchChange.bootstrapSwitch', function(event, state) {
            var valid = 0;
            if(state) {
                valid = 1;
            }else{
                valid = 0;
            }
            var id = $(this).attr("value");
            $.ajax({
                type: "get",
                url: "${Constants.URL}isValidDocument/",
                cache: false, 
                data:'id='+id+'&valid='+valid,
                success: function(response){
                    console.log(response);
                },
                error: function(response){ 
                    console.log(response);
                }
            }); 
        });
        var dateSearch = '<div class="rangeBigContainer"><div class="rangeTitle">Пошук за датою</div>'+
                    '<div class="input-daterange input-group" id="datepicker">'+
                    '<span class="input-group-addon">від</span>'+
                    '<input id="min" type="text" class="form-control" name="start" />'+
                    '<span class="input-group-addon">до</span>'+
                    '<input id="max" type="text" class="form-control" name="end" />'+
                '</div></div>';
        $('#table-pagination_filter').after(dateSearch);
        $('tfoot').hide(0);
        isHiddenSearch = false;
        $('.input-daterange').datepicker({
            format: "dd.mm.yyyy",
            weekStart: 1
        });
        $('#rowDate').datepicker({
            format: "dd.mm.yyyy",
            weekStart: 1
        });
        $('#datepicker').change(function(){
            $('.datepicker').hide();
            table.draw();
        });
        $('#rowDate').change(function(){
            $('.datepicker').hide();
            table.draw();
        });
        $('#table-pagination_filter').append('<div class="resetSearch btn btn-primary" onclick="resetSearch()">Очистити пошук</div>');
    });
</script>
