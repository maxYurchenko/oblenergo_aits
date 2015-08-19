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
        <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
            <a href="${Constants.URL}admin/addType" class="btn marginTop btn-success btn-mini addButton">Додати новий тип</a>
                    </div>
                </div>
            
                <div class="tableMainClass">
                    <table class="table table-striped table-bordered" id="table-pagination" data-height="400" data-pagination="true">
                            <thead>
                                <tr class="tableHeader">
                                    <th>Назва</th>
                                    <th style="width: 20px;"></th>
                                    <th style="width: 20px;"></th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr class="tableHeader">
                                    <th>назві</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <c:forEach items="${types}" var="type">
                                        <tr>
                                            <th>${type.title}</th>
                                            <th><a href="${Constants.URL}admin/editType/${type.id}"><img style="width: 20px;" src="${Constants.URL}/img/edit.png"></a></th>
                                            <th class="text-center"><a href="${Constants.URL}admin/deleteType/${type.id}"><img style="width: 20px;" src="${Constants.URL}/img/delete.png"></a></th>
                                        </tr>
                                </c:forEach>
                            </tbody>
                        </thead>
                    </table>
                </div>
            
            </div>
    </body>
</t:mainHeader>
<script>
    $( document ).ready(function() {
        $('.cutLink').each(function(){
            $(this).text($(this).text().substring(6, $(this).text().length));
        });
        $('#typesPage').css('background','#14A86B');
        $("[name='my-checkbox']").bootstrapSwitch();
        $('.selectpicker').selectpicker();
        // Setup - add a text input to each footer cell
    $('#table-pagination tfoot th').each( function () {
        if($(this).text()!=""){
            var title = $('#table-pagination tfoot th').eq( $(this).index() ).text();
            $(this).html( '<input class="form-control tableSearch individualSearch" type="text" placeholder="Пошук по '+title+'" />' );
        }
    } );
 
    // DataTable
    var table = $('#table-pagination').DataTable();
 
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
        $('tfoot').hide(0);
       isHiddenSearch = false;
    });
</script>