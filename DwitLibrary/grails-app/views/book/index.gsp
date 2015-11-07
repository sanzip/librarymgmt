<%@ page import="np.edu.dwit.Book" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-book" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                           default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="list-book" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="name" title="${message(code: 'book.name.label', default: 'Name')}"/>

            <g:sortableColumn property="author" title="${message(code: 'book.author.label', default: 'Author')}"/>

            <g:sortableColumn property="bookNumber"
                              title="${message(code: 'book.bookNumber.label', default: 'Book Number')}"/>

            <g:sortableColumn property="availableQuantity"
                              title="${message(code: 'book.availableQuantity.label', default: 'Available Quantity')}"/>

            <g:sortableColumn property="totalQuantity"
                              title="${message(code: 'book.totalQuantity.label', default: 'Total Quantity')}"/>

            <g:sortableColumn property="bookType"
                              title="${message(code: 'book.bookType.label', default: 'Book Type')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${bookInstanceList}" status="i" var="bookInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${bookInstance.id}">${fieldValue(bean: bookInstance, field: "name")}</g:link></td>

                <td>${fieldValue(bean: bookInstance, field: "author")}</td>

                <td>${fieldValue(bean: bookInstance, field: "bookNumber")}</td>

                <td>${fieldValue(bean: bookInstance, field: "availableQuantity")}</td>

                <td>${fieldValue(bean: bookInstance, field: "totalQuantity")}</td>

                <td>${fieldValue(bean: bookInstance, field: "bookType")}</td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${bookInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
