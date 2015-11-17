<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_page">
	<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}"/>
	<title><g:message code="default.create.label" args="[entityName]"/></title>
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
		%{--<a href="#create-book" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>--}%
<div id="head">
	<div class="ui compact menu" style="margin: 13px;">
		<div class="active item">
			<a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
		</div>

		<div class="active item">
			<g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/></g:link>
		</div>
	</div>
        </div>
		<div id="create-book" class="content scaffold-create" role="main">
			%{--<h1><g:message code="default.create.label" args="[entityName]" /></h1>--}%
			%{--<g:if test="${flash.message}">--}%
			%{--<div class="message" role="status">${flash.message}</div>--}%
			%{--</g:if>--}%
            <h2 style="text-align: center;font-family:Open Sans Helvetica Neue Helvetica, Arial sans-serif">Create Book</h2>

            <g:hasErrors bean="${bookInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${bookInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:bookInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
                    <br><br>
                    <g:submitButton name="create" class="ui blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" />

                </fieldset>

			</g:form>
		</div>
	</body>
</html>
