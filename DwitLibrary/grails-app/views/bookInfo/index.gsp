
<%@ page import="np.edu.dwit.BookInfo" %>
<!DOCTYPE html>
<html>
	<head>
        <meta name="layout" content="main_page">
		<g:set var="entityName" value="${message(code: 'bookInfo.label', default: 'BookInfo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <style>
        #wrapper{
            margin: 0px auto;
            width: 95%;
        }
        #head{
            text-align: center;
        }
        </style>
	</head>
	<body>
    <div id="wrapper">
        <div id="head">
            <div class="ui compact menu">
                <div class="active item">

				<a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                    </div>
                <div class="active item">
				    <g:link class="create" action="create" params="[id: params.id]"><g:message code="default.new.label" args="[entityName]" /></g:link>

                 </div>
            </div>

		</div>
        <br><br>
		<div id="list-bookInfo" class="content scaffold-list" role="main">
            <h1 style="text-align: center"><g:message code="default.list.label" args="[entityName]" /></h1>

            <g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="ui celled table">
			<thead>
					<tr>
					
						<th><g:message code="bookInfo.book.label" default="Book" /></th>
					
						<g:sortableColumn property="bookNumber" title="${message(code: 'bookInfo.bookNumber.label', default: 'Book Number')}" />

						<g:sortableColumn property="edition" title="${message(code: 'bookInfo.edition.label', default: 'Edition')}" />
					
						<g:sortableColumn property="publishedYear" title="${message(code: 'bookInfo.publishedYear.label', default: 'Published Year')}" />
					
						<g:sortableColumn property="pages" title="${message(code: 'bookInfo.pages.label', default: 'Pages')}" />
					
						<g:sortableColumn property="cost" title="${message(code: 'bookInfo.cost.label', default: 'Cost')}" />
					    <th>Action</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${bookInfoInstanceList}" status="i" var="bookInfoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        %{--<td><g:link action="show" id="${bookInfoInstance.name}">${fieldValue(bean: bookInfoInstance, field: "book")}</g:link></td>--}%

                       <td>${fieldValue(bean: bookInfoInstance,field: "book.name")}</td>

                    %{--  For Developers Not Designers: Keep this code below in action Edit/Delete--}%
                      %{--  <td><g:link action="show" id="${bookInfoInstance.id}">${fieldValue(bean: bookInfoInstance, field: "book.id")}</g:link></td>
					--}%
						<td>${fieldValue(bean: bookInfoInstance, field: "bookNumber")}</td>
					
						<td>${fieldValue(bean: bookInfoInstance, field: "edition")}</td>
					
						<td>${fieldValue(bean: bookInfoInstance, field: "publishedYear")}</td>
					
						<td>${fieldValue(bean: bookInfoInstance, field: "pages")}</td>
					
						<td>${fieldValue(bean: bookInfoInstance, field: "cost")}</td>

                        <td>
                            <div class="ui buttons">
                                <g:link class="edit" action="edit" resource="${bookInfoInstance}" style="color:#000000;">
                                    <button type="button" class="ui button">
                                        <i class="edit icon"> </i>
                                        <g:message code="default.button.edit.label" default="Edit"/>
                                    </button>
                                </g:link>
                                %{-- TODO <g:form url="[resource: bookInfoInstance, action: 'delete']" method="DELETE">--}%
                                    %{--<div class="or"></div>--}%

                                    %{--<button type="submit" class="ui button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">--}%
                                        %{--<i class="delete icon"> </i>--}%
                                        %{--<g:message code="default.button.delete.label" default="Delete"/>--}%
                                    %{--</button>--}%
                                %{--</g:form>--}%
                            </div>
                        </td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${bookInfoInstanceCount ?: 0}" />
			</div>
		</div>
            </div>
	</body>
</html>
