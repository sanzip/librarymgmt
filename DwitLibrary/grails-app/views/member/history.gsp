<%--
  Created by IntelliJ IDEA.
  User: asimsangram
  Date: 11/4/15
  Time: 10:51 AM
--%>

<%@ page import="np.edu.dwit.TimeStamp; np.edu.dwit.Borrow; np.edu.dwit.Fine" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main_page">
    <title> History</title>
</head>

<body>
    <br>
    <table class="ui sortable celled table" style="margin: 0px auto;width: 95%">
        <thead>
            <tr>
                <th>S.N.</th>
                <th>Book Name</th>
                <th>Author</th>
                <th>Borrowed Date</th>
                <th>Returned Date</th>
                <th>Deadline</th>
                <th>Fine Paid</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${history}" var="item" status="i">
                <g:set var="fine" value="${Fine.findByBorrow((Borrow)item.key)}"/>
                <tr>
                    <td>${i + 1}</td>
                    <td>${item.key.bookInfo.book.name}</td>
                    <td>${item.key.bookInfo.book.author}</td>
                    <td>${item.key.borrowedDate.format("yyyy/MM/dd")}</td>
                    <td>${item.key.returnedDate ?: '-'}</td>
                    <td style = "color:red">${TimeStamp.findByBorrow((Borrow) item.key).deadline}</td>
                    <td>${item.value?item.value:0.0}</td>
                </tr>
            </g:each>
        </tbody>
    </table>
</body>
</html>