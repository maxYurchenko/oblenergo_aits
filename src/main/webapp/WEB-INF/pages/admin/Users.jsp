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
            <a href="${Constants.URL}admin/addUser" class="btn marginTop btn-success btn-mini">Додати нового користувача</a>
                    </div>
                </div>
        <div class="tableMainClass">
            <table class="table table-striped table-bordered" id="table-pagination" data-height="400" data-pagination="true">
                    <thead>
                        <tr class="tableHeader">
                            <th>Ім’я</th>
                            <th>Роль</th>
                            <th>Опис</th>
                            <th>ПІБ</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr class="tableHeader">
                            <th data-column-index="0" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">імені</th>
                            <th data-column-index="1" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">ролі</th>
                            <th data-column-index="2" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">опису</th>
                            <th data-column-index="3" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">ПІБу</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <c:forEach items="${users}" var="user">
                            <tr class="display">
                                <th data-column-index="0" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">${user.name}</th>
                                <th data-column-index="1" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">
                                    <c:choose>
                                        <c:when test="${user.role == 2}">
                                           Адміністратор
                                        </c:when>
                                        <c:when test="${user.role == 1}">
                                            Редактор
                                        </c:when>
                                        <c:otherwise>
                                            Користувач
                                        </c:otherwise>
                                    </c:choose>
                                </th>
                                <th data-column-index="2" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">${user.description}</th>
                                <th data-column-index="3" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">${user.fullName}</th>
                                <th style="width:20px;"><a href="${Constants.URL}admin/editUser/${user.id}"><img style="width: 20px;" src="${Constants.URL}/img/edit.png"></a></th>
                                <th onclick="deleteUser('${user.id}')" style="width:20px;"><a style="cursor: pointer"><img style="width: 20px;" src="${Constants.URL}/img/delete.png"></a></th>
                            </tr>
                        </c:forEach>
                    </tbody>
                </thead>
            </table>
        </div>
        </div>
    </body>
    <script>
        $( document ).ready(function() {
            $('#usersPage').css('background','#14A86B');
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
                    $('#table-pagination_length').append("&nbsp;<div class='hideSearch btn btn-primary btn-mini' onclick='hideSearch()'>Показати<br>пошук</div>");
        $('#showMainSearch').click(function(){
            $('#showMainSearch').hide(0);
            $('#mainSearch').removeClass('displayNone');
            $('#mainSearch').hide(0);
            $('#mainSearch').show('slow');
        });
        $('tfoot').hide(0);
        isHiddenSearch = false;
        $('#table-pagination_filter').append('<div class="resetSearch btn btn-primary" onclick="resetSearch()">Очистити пошук</div>');
        });
        function deleteUser(id){
            console.log(id);
            $.ajax({
                type: "get",
                url: "${Constants.URL}deleteUser/",
                cache: false, 
                data:'id='+id,
                success: function(response){
                    location.reload();
                },
                error: function(response){ 
                    console.log(response);
                }
            }); 
        }
    </script>
</t:mainHeader>
