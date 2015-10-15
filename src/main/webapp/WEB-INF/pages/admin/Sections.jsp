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
    <style>
        .dataTables_wrapper .dataTables_filter{
            margin-left: 32px;
        }
    </style>
    <body>
        <div class="container-fluid">
            <c:if test="${sessionScope.user.role != 2}">
                <script>window.location.href = "${Constants.URL}login";</script>
            </c:if>
                <div class="row">
                    <div class="col-md-12">
            <a href="${Constants.URL}admin/addSection" class="btn marginTop btn-success btn-mini addButton">Додати новий розділ</a>
                    </div>
                </div>
        
                <div style="display: none" class="deleteFrameBlock">
                    <div class="deleteSectionConfirm">
                        Ви впевнені, що бажаєте видалити розділ, всі підрозділи та файли, що в ньому знаходяться?<br>
                        <input onclick="hideDeleteBlock()" class="btn btn-success btn-mini sectionDeleteButton" id="sudmitData" value="Ні" type="submit">
                        <a href="${Constants.URL}admin/deleteSection/id" id="deleteButton">
                            <input class="btn btn-danger btn-mini sectionDeleteButton" id="sudmitData" value="Так" type="submit">
                        </a>
                    </div>
                </div>
        <div class="tableMainClass">
            <table class="table table-bordered" id="table-pagination" data-height="400" data-pagination="true">
                    <thead>
                        <tr class="tableHeader">
                            <th>Ім’я</th>
                            <th>Головна категорія</th>
                            <!--
                            <th>Доступ користувачам</th>
                            <th>Доступ групам</th>
                            -->
                            <th style="width:20px;"></th>
                            <th style="width:20px;"></th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr class="tableHeader">
                            <th data-column-index="0" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">імені</th>
                            <th data-column-index="1" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">головній категорії</th>
                            <!--
                            <th data-column-index="2" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">доступу користувачам</th>
                            <th data-column-index="3" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">доступу групам</th>
                            -->
                            <th style="width:20px;"></th>
                            <th style="width:20px;"></th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <c:forEach items="${sections}" var="section">
                            <c:if test="${section.isDelete != 1}">
                                <tr class="display">
                                    <th data-column-index="0" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">${section.title}</th>
                                    <th data-column-index="1" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">
                                        <c:choose>
                                            <c:when test="${section.parentName == '0'}">
                                               Головний розділ
                                            </c:when>
                                            <c:otherwise>
                                               ${section.parentName}
                                            </c:otherwise>
                                        </c:choose>
                                    </th>
                                    <!--
                                    <th data-column-index="2" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">${section.users}</th>
                                    <th data-column-index="3" class="sorting" tabindex="0" aria-controls="table-pagination" rowspan="1" colspan="1">${section.groups}</th>
                                    -->
                                    <th style="width:20px;"><a href="${Constants.URL}admin/editSection/${section.id}"><img style="width: 20px;" src="${Constants.URL}img/edit.png"></a></th>
                                    <th style="width:20px;"><a onclick="deleteSection('${section.id}')" href="#"><img style="width: 20px;" src="${Constants.URL}img/delete.png"></a></th>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </thead>
            </table>
        </div>
        <script>
            $( document ).ready(function() {
                $('#sectionsPage').css('background','#418a84');
                $('.selectpicker').selectpicker();
        $('#table-pagination tfoot th').each( function () {
            if($(this).text()!=""){
                var title = $('#table-pagination tfoot th').eq( $(this).index() ).text();
                $(this).html( '<input title="Пошук по '+title+'" class="form-control tableSearch individualSearch" type="text" placeholder="Пошук по '+title+'" />' );
            }
        } );
        var table = $('#table-pagination').DataTable({
                        "dom": 'Zlfrtip'});
        table.columns().every( function () {
            var that = this;

            $( 'input', this.footer() ).on( 'keyup change', function () {
                that
                    .search( this.value )
                    .draw();
            } );
        } );
                    //$('#table-pagination_length').append("&nbsp;<div class='hideSearch btn btn-primary btn-mini' onclick='hideSearch()'>Показати<br>пошук</div>");
        $('#showMainSearch').click(function(){
            $('#showMainSearch').hide(0);
            $('#mainSearch').removeClass('displayNone');
            $('#mainSearch').hide(0);
            $('#mainSearch').show('slow');
        });
        $('tfoot').hide(0);
        isHiddenSearch = false;
        $('#table-pagination_filter').append('<div class="mainSearchTitle">Загальний пошук</div>');
        $('#table-pagination_filter').after('<div class="resetSearch btn btn-primary" onclick="resetSearch()">Очистити</div>');
        $('#table-pagination_filter').after("&nbsp;<div class='hideSearch btn btn-primary btn-mini' onclick='hideSearch()'>Показати</div>");
            });
            function deleteSection(id){
                $('.deleteFrameBlock').fadeIn('fast');
                $('#deleteButton').attr('href','${Constants.URL}admin/deleteSection/'+id);
            }
            function hideDeleteBlock(){
                $('.deleteFrameBlock').fadeOut('fast');
            }
        </script>
</t:mainHeader>
