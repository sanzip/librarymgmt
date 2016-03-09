
<%@ page import="np.edu.dwit.Configure" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'configure.label', default: 'Configure')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-configure" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-configure" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list configure">
			
				<g:if test="${configureInstance?.courseBookBorrowableAdmin}">
				<li class="fieldcontain">
					<span id="courseBookBorrowableAdmin-label" class="property-label"><g:message code="configure.courseBookBorrowableAdmin.label" default="Course Book Borrowable Admin" /></span>
					
						<span class="property-value" aria-labelledby="courseBookBorrowableAdmin-label"><g:fieldValue bean="${configureInstance}" field="courseBookBorrowableAdmin"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.courseBookBorrowableFaculty}">
				<li class="fieldcontain">
					<span id="courseBookBorrowableFaculty-label" class="property-label"><g:message code="configure.courseBookBorrowableFaculty.label" default="Course Book Borrowable Faculty" /></span>
					
						<span class="property-value" aria-labelledby="courseBookBorrowableFaculty-label"><g:fieldValue bean="${configureInstance}" field="courseBookBorrowableFaculty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.courseBookBorrowableLibrarian}">
				<li class="fieldcontain">
					<span id="courseBookBorrowableLibrarian-label" class="property-label"><g:message code="configure.courseBookBorrowableLibrarian.label" default="Course Book Borrowable Librarian" /></span>
					
						<span class="property-value" aria-labelledby="courseBookBorrowableLibrarian-label"><g:fieldValue bean="${configureInstance}" field="courseBookBorrowableLibrarian"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.courseBookBorrowableStudent}">
				<li class="fieldcontain">
					<span id="courseBookBorrowableStudent-label" class="property-label"><g:message code="configure.courseBookBorrowableStudent.label" default="Course Book Borrowable Student" /></span>
					
						<span class="property-value" aria-labelledby="courseBookBorrowableStudent-label"><g:fieldValue bean="${configureInstance}" field="courseBookBorrowableStudent"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.fineAmtAdmin}">
				<li class="fieldcontain">
					<span id="fineAmtAdmin-label" class="property-label"><g:message code="configure.fineAmtAdmin.label" default="Fine Amt Admin" /></span>
					
						<span class="property-value" aria-labelledby="fineAmtAdmin-label"><g:fieldValue bean="${configureInstance}" field="fineAmtAdmin"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.fineAmtFaculty}">
				<li class="fieldcontain">
					<span id="fineAmtFaculty-label" class="property-label"><g:message code="configure.fineAmtFaculty.label" default="Fine Amt Faculty" /></span>
					
						<span class="property-value" aria-labelledby="fineAmtFaculty-label"><g:fieldValue bean="${configureInstance}" field="fineAmtFaculty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.fineAmtLibrarian}">
				<li class="fieldcontain">
					<span id="fineAmtLibrarian-label" class="property-label"><g:message code="configure.fineAmtLibrarian.label" default="Fine Amt Librarian" /></span>
					
						<span class="property-value" aria-labelledby="fineAmtLibrarian-label"><g:fieldValue bean="${configureInstance}" field="fineAmtLibrarian"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.fineAmtStudent}">
				<li class="fieldcontain">
					<span id="fineAmtStudent-label" class="property-label"><g:message code="configure.fineAmtStudent.label" default="Fine Amt Student" /></span>
					
						<span class="property-value" aria-labelledby="fineAmtStudent-label"><g:fieldValue bean="${configureInstance}" field="fineAmtStudent"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.limitBookBorrowableAdmin}">
				<li class="fieldcontain">
					<span id="limitBookBorrowableAdmin-label" class="property-label"><g:message code="configure.limitBookBorrowableAdmin.label" default="Limit Book Borrowable Admin" /></span>
					
						<span class="property-value" aria-labelledby="limitBookBorrowableAdmin-label"><g:fieldValue bean="${configureInstance}" field="limitBookBorrowableAdmin"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.limitBookBorrowableFaculty}">
				<li class="fieldcontain">
					<span id="limitBookBorrowableFaculty-label" class="property-label"><g:message code="configure.limitBookBorrowableFaculty.label" default="Limit Book Borrowable Faculty" /></span>
					
						<span class="property-value" aria-labelledby="limitBookBorrowableFaculty-label"><g:fieldValue bean="${configureInstance}" field="limitBookBorrowableFaculty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.limitBookBorrowableLibrarian}">
				<li class="fieldcontain">
					<span id="limitBookBorrowableLibrarian-label" class="property-label"><g:message code="configure.limitBookBorrowableLibrarian.label" default="Limit Book Borrowable Librarian" /></span>
					
						<span class="property-value" aria-labelledby="limitBookBorrowableLibrarian-label"><g:fieldValue bean="${configureInstance}" field="limitBookBorrowableLibrarian"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.limitBookBorrowableStudent}">
				<li class="fieldcontain">
					<span id="limitBookBorrowableStudent-label" class="property-label"><g:message code="configure.limitBookBorrowableStudent.label" default="Limit Book Borrowable Student" /></span>
					
						<span class="property-value" aria-labelledby="limitBookBorrowableStudent-label"><g:fieldValue bean="${configureInstance}" field="limitBookBorrowableStudent"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${configureInstance?.novelBookBorrowable}">
				<li class="fieldcontain">
					<span id="novelBookBorrowable-label" class="property-label"><g:message code="configure.novelBookBorrowable.label" default="Novel Book Borrowable" /></span>
					
						<span class="property-value" aria-labelledby="novelBookBorrowable-label"><g:fieldValue bean="${configureInstance}" field="novelBookBorrowable"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:configureInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${configureInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
