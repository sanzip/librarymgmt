
<%@ page import="np.edu.dwit.BookInfo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_page">
		<g:set var="entityName" value="${message(code: 'bookInfo.label', default: 'BookInfo')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <style>
        form{
        text-align: left !important;
        }
        fieldset{
        margin:0px auto;
        width:19%;
        background-color: rgba(53, 115, 163, 0.03);
        border-radius: 2px;
        }
        #head{
        text-align: center;
        }
         #wrapper{
                text-align: center;
            }
        </style>
	</head>
	<body>
    <div id="head">
        <div class="ui compact menu" style="margin: 13px;">
            <div class="active item">
                <g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link>
            </div>
            <div class="active item">
                <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                </div>
        </div>
    </div>



    <div id="wrapper">
		<div id="show-bookInfo" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
            <div class="ui one column grid" style="margin: 0px auto;text-align: center;background-color: #F7F7F7;width:32%;">
                <div class="column">
                    <div class="ui raised segment" style="text-align: left">
                        <a class="ui blue ribbon label"> Book </a>
                        <span>:  <g:link controller="book" action="show" id="${bookInfoInstance?.book?.id}">${bookInfoInstance?.book?.encodeAsHTML()}</g:link></span>
                        <p></p>

                        <a class="ui blue ribbon label">Book Number</a>
                        <span>:  <g:fieldValue bean="${bookInfoInstance}" field="bookNumber"/></span>
                        <p></p>

                        <a class="ui blue ribbon label"> Edition </a>
                        <span>: <g:fieldValue bean="${bookInfoInstance}" field="edition"/></span>
                        <p></p>

                        <a class="ui blue ribbon label">Published Year</a>
                        <span>: <g:fieldValue bean="${bookInfoInstance}" field="publishedYear"/></span>
                        <p></p>

                        <a class="ui blue ribbon label">Pages</a>
                        <span>:  <g:fieldValue bean="${bookInfoInstance}" field="pages"/> </span>
                        <p></p>

                        <a class="ui blue ribbon label">Costs</a>
                        <span>:  <g:fieldValue bean="${bookInfoInstance}" field="cost"/></span>
                        <p></p>

                        <a class="ui blue ribbon label">Source</a>
                        <span>:  <g:fieldValue bean="${bookInfoInstance}" field="source"/></span>
                        <p></p>
                    </div>
                </div>
                <g:form url="[resource:bookInfoInstance, action:'delete']" method="DELETE">
                    <fieldset class="buttons">
                        <g:link class="ui green button" action="edit" resource="${bookInfoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    </fieldset>
                </g:form>
            </div>

            <br>

		</div>
    </div>
	</body>
</html>
