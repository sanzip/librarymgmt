<%--
  Created by IntelliJ IDEA.
  User: asimsangram
  Date: 11/13/15
  Time: 6:55 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Return Log</title>
    <meta name="layout" content="main_page">
</head>

<body>
<br>

    <table class="ui sortable celled table" style="margin: 0px auto;width: 95%">
        <thead>
        <tr>
            <th>S.N.</th>
            <th>Returned By</th>
            <th>Book Name</th>
            <th>Book Number</th>
            <th>Returned To</th>
            <th>Returned Date</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${returnLogs}" var="returnLog" status="i">
            <tr>
                <td>${i + 1}</td>
                <td>${returnLog.by.fullName}</td>
                <td>${returnLog.borrow.bookInfo.book.name}</td>
                <td>${returnLog.borrow.bookInfo.bookNumber}</td>
                <td>${returnLog.to.fullName}</td>
                <td>${returnLog.borrow.returnedDate}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</body>
</html>