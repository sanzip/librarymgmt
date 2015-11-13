<%@ page import="np.edu.dwit.BookInfo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_page">
		<g:set var="entityName" value="${message(code: 'bookInfo.label', default: 'BookInfo')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
        <style>
        form{
            text-align: left !important;
        }
        fieldset{
            margin:0px auto;
            width:50%;
            background-color: rgba(53, 115, 163, 0.03);
            border-radius: 2px;
            box-shadow:  10px 10px 5px ;
        }
        #head{
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
    <br>

		<div id="edit-bookInfo" class="content scaffold-edit" role="main">
            <h2 style="text-align: center;font-family:Open Sans Helvetica Neue Helvetica, Arial sans-serif">Edit Book Info</h2>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${bookInfoInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${bookInfoInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:bookInfoInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${bookInfoInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
                    <br>
                    <g:actionSubmit class="ui blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>

			</g:form>
		</div>
	</body>
</html>
