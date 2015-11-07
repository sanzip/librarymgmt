<%--
  Created by IntelliJ IDEA.
  User: saneel
  Date: 11/3/15
  Time: 12:15 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>
    <ul>
        <g:link controller="member" action="history" params="[id: params.id]"><li>History</li></g:link>
        <sec:ifAllGranted roles="ROLE_LIBRARIAN">
            <a href="#"><li>Issue</li></a>

            <g:link action="returnBook" controller="book">Return book</g:link>
            <g:link action="report" controller="book">Report</g:link>
            <a href="#"><li>Configure</li></a>
            <g:link action="create" controller="book">Book</g:link>
            <g:link action="create" controller="member">User</g:link>

        </sec:ifAllGranted>
        <form name="logout" method="POST" action="${createLink(controller:'logout') }">
            <input type="submit" value="logout"></form>
    </ul>
    <input type="text" name="bookName" id="bookName"><g:submitButton name="submit" value="Submit"/>

    <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
        <div>Number of allowed : <input type="text" name="allowed" id="allowed" value="${count}" disabled></div>
    </sec:ifAnyGranted>

    <table border="1px">
        <thead>
            <tr>
                <th>S.No</th>
                <th>Name</th>
                <th>Author</th>
                <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                    <th>Total Quantity</th>
                </sec:ifAllGranted>
                <th>Available Quantity</th>
                <th>Issue</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${list}" var="booklist" status="i">
                <tr>
                    <td>${i+1}</td>
                    <td>${booklist.name}</td>
                    <td>${booklist.author}</td>
                    <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                        <td>${booklist.totalQuantity}</td>
                    </sec:ifAllGranted>
                    <td>${booklist.availableQuantity}</td>
                    <td><g:link controller="book" action="issueBook" params="[bookId: booklist.id]">Issue</g:link></td>
                </tr>
            </g:each>
        </tbody>
    </table>

</body>
</html>