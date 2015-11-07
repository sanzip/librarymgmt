<%@ page import="np.edu.dwit.Member" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'member.label', default: 'Member')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-member" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                             default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="list-member" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="username"
                              title="${message(code: 'member.username.label', default: 'Username')}"/>

            %{--<g:sortableColumn property="password"
                              title="${message(code: 'member.password.label', default: 'Password')}"/>
--}%
            <g:sortableColumn property="email" title="${message(code: 'member.email.label', default: 'Email')}"/>

            <g:sortableColumn property="contact" title="${message(code: 'member.contact.label', default: 'Contact')}"/>

            <g:sortableColumn property="status" title="${message(code: 'member.status.label', default: 'Status')}"/>

            <g:sortableColumn property="accountExpired"
                              title="${message(code: 'member.accountExpired.label', default: 'Account Expired')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${memberInstanceList}" status="i" var="memberInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${memberInstance.id}">${fieldValue(bean: memberInstance, field: "username")}</g:link></td>
%{--
                <td>${fieldValue(bean: memberInstance, field: "password")}</td>--}%

                <td>${fieldValue(bean: memberInstance, field: "email")}</td>

                <td>${fieldValue(bean: memberInstance, field: "contact")}</td>

                <td>${fieldValue(bean: memberInstance, field: "status")}</td>

                <td><g:formatBoolean boolean="${memberInstance.accountExpired}"/></td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${memberInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
