<%--
  Created by IntelliJ IDEA.
  User: asimsangram
  Date: 11/13/15
  Time: 6:55 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Issue Log</title>
    <meta name="layout" content="main_page">
</head>

<body>
    <table class="ui sortable celled table" style="margin: 0px auto;width: 95%">
        <thead>
        <tr>
            <th>S.N.</th>
            <th>Issued By</th>
            <th>Book Name</th>
            <th>Book Number</th>
            <th>Issued To</th>
            <th>Issued Date</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${issueLogs}" var="issueLog" status="i">
            <tr>
                <td>${i + 1}</td>
                <td>${issueLog.by.fullName}</td>
                <td>${issueLog.borrow.bookInfo.book.name}</td>
                <td>${issueLog.borrow.bookInfo.bookNumber}</td>
                <td>${issueLog.to.fullName}</td>
                <td>${issueLog.borrow.borrowedDate}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</body>
</html>