<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_page">
		<g:set var="entityName" value="${message(code: 'configure.label', default: 'Configure')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
        <style>
        form{
            text-align: left !important;
        }
        fieldset{
            margin:0px auto;
            width:50%;
            background-color: rgba(53, 115, 163, 0.03);
            border-radius: 2px;
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
            <g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link>            </div>
            </div>
        </div>
		<div id="create-configure" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${configureInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${configureInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:configureInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
                        <br>
					<g:submitButton name="create" class="ui blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
