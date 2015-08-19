<%-- 
    Document   : addUser
    Created on : Jul 23, 2015, 2:00:47 PM
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
            <c:if test="${sessionScope.user.role != 2}">
                <script>window.location.href = "${Constants.URL}login";</script>
            </c:if>
                <div class="row">
                    <div class="col-md-12">
            <a href="${Constants.URL}admin/addUserGroup" class="btn marginTop btn-success btn-mini">Додати нову групу</a>
                    </div>
                </div>
        <div class="tableMainClass">
            <table class="table table-striped table-bordered" id="table-pagination" data-height="400" data-pagination="true">
                    <thead>
                        <tr class="tableHeader">
                            <th>Назва</th>
                            <th>Користувачі в цій групі</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr class="tableHeader">
                            <th data-column-index="0" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">назві групи</th>
                            <th data-column-index="1" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">користувачам в цій групі</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <c:forEach items="${groups}" var="group">
                                <tr class="display">
                                    <th data-column-index="0" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">${group.title}</th>
                                    <th data-column-index="1" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">${group.users}</th>
                                    <th style="width:25px"><a href="${Constants.URL}admin/editUserGroup/${group.id}"><img style="width: 20px;" src="${Constants.URL}/img/edit.png"></a></th>
                                    <th style="width:25px"><a href="${Constants.URL}admin/deleteUserGroup/${group.id}"><img style="width: 20px;" src="${Constants.URL}/img/delete.png"></a></th>
                                </tr>
                        </c:forEach>
                    </tbody>
                </thead>
            </table>
        </div>
        <script>
            $( document ).ready(function() {
                $('#groupsPage').css('background','#14A86B');
                $('.selectpicker').selectpicker();
        // Setup - add a text input to each footer cell
    $('#table-pagination tfoot th').each( function () {
        if(($(this).text()!="")&&($(this).text()!="Видалити")&&($(this).text()!="Дійсний")){
            var title = $('#table-pagination tfoot th').eq( $(this).index() ).text();
            $(this).html( '<input title="Пошук по '+title+'" class="form-control tableSearch individualSearch" type="text" placeholder="Пошук по '+title+'" />' );
        }
    } );
 
    // DataTable
    var table = $('#table-pagination').DataTable({
                        "dom": 'Zlfrtip'});
 
    // Apply the search
    table.columns().every( function () {
        var that = this;
 
        $( 'input', this.footer() ).on( 'keyup change', function () {
            that
                .search( this.value )
                .draw();
        } );
    } );
                    $('#table-pagination_length').append("&nbsp;<div class='hideSearch' onclick='hideSearch()'>Показати<br>пошук</div>");
        $('#showMainSearch').click(function(){
            $('#showMainSearch').hide(0);
            $('#mainSearch').removeClass('displayNone');
            $('#mainSearch').hide(0);
            $('#mainSearch').show('slow');
        });
                //$('.deleteFrameBlock').hide();
        $('tfoot').hide(0);
        isHiddenSearch = false;
            });
            
        </script>
</t:mainHeader>
