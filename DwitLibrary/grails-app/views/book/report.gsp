<%--
  Created by IntelliJ IDEA.
  User: asimsangram
  Date: 11/5/15
  Time: 12:31 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>
            <g:each in="${booksWithBorrowCount}" var="bookWithBorrowCount">
                ${bookWithBorrowCount.key.name}
                ${bookWithBorrowCount.value}
                <br>
            </g:each>
</body>
</html>