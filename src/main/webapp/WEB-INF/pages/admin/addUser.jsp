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
        <div class="container">
            <div class="adminLinks">
                <a href="${Constants.URL}index">Documents list</a>
                <a href="${Constants.URL}admin">Add documents</a>
                <c:if test="${user.role == 2}">
                    <a href="${Constants.URL}admin/addUser">Add users</a>
                </c:if>
            </div>
        <form name="userAdd" method="POST" action="${Constants.URL}system/adduser.do" id="addUser">
                
               <div class="row">
                                                    <div class="col-md-3">
                                                <label>Username:</label>
                                                <input type="text" name="username" class="form-control" id="username">
                                                <div class="validation"></div>
                                              </div>
                                                    <div class="col-md-3">
                                                <label>Password:</label>
                                                <input type="password" name="password" class="form-control" id="password">
                                                <div class="validation"></div>
                                              </div>
                                                    <div class="col-md-3">
                                                <label>Description:</label>
                                                <input type="text" name="descr" class="form-control" id="descr">
                                                <div class="validation"></div>
                                              </div>
                                                    <div class="col-md-3" style="margin-top: 25px;">
                                                <select id="role" name="role" class="selectpicker">
                                                    <option value="0">User</option>
                                                    <option value="1">Editor</option>
                                                    <option value="2">Admin</option>
                                                </select>
                                              </div>
               </div>
                    <div>
                        <input class="btn btn-primary btn-mini margintop-button" id="sudmitData" value="Add user" type="submit">
                                        </div>
            </form>
        <div class="tableMainClass">
            <table class="table" id="table-pagination" data-height="400" data-pagination="true">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Role</th>
                            <th>Description</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="user">
                            <tr class="display">
                                <th>${user.id}</th>
                                <th>${user.name}</th>
                                <th>
                                    <c:choose>
                                        <c:when test="${user.role == 2}">
                                           Admin
                                        </c:when>
                                        <c:when test="${user.role == 1}">
                                            Editor
                                        </c:when>
                                        <c:otherwise>
                                            User
                                        </c:otherwise>
                                    </c:choose>
                                </th>
                                <th>${user.description}</th>
                                <th style="width:20px;"><a href="${Constants.URL}admin/editUser/${user.id}">Edit</a></th>
                                <th onclick="deleteUser('${user.id}')" style="width:20px;"><a style="cursor: pointer">Delete</a></th>
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
            $('.selectpicker').selectpicker();
            $('#table-pagination').DataTable();
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
