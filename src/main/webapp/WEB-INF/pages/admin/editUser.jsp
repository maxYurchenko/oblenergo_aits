<%-- 
    Document   : addUser
    Created on : Jul 23, 2015, 2:00:47 PM
    Author     : skywalker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <form name="userEdit" method="POST" action="${Constants.URL}system/edituser.do" id="editUser">
                
               <div class="row">
                                                    <div class="col-md-3">
                                                <label>Username:</label>
                                                <input type="text" name="username" class="form-control" id="username" value="${user.name}">
                                                <div class="validation"></div>
                                              </div>
                                                    <div class="col-md-3">
                                                <label>Password:</label>
                                                <input type="text" name="password" class="form-control" id="password" value="${user.pass}">
                                                <div class="validation"></div>
                                              </div>
                                                    <div class="col-md-3">
                                                <label>Description:</label>
                                                <input type="text" name="descr" class="form-control" id="descr" value="${user.description}">
                                                <input type="hidden" name="id" class="form-control" id="id" value="${user.id}">
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
                        <input class="btn btn-primary btn-mini margintop-button" id="sudmitData" value="Edit user" type="submit">
                                        </div>
            </form>
        </div>
    </body>
    <script>
        $( document ).ready(function() {
            $('.selectpicker').selectpicker();
        });
        console.log("${user.id}");
    </script>
</t:mainHeader>
