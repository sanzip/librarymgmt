<%@ page import="np.edu.dwit.Configure" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_page">
		<g:set var="entityName" value="${message(code: 'configure.label', default: 'Configure')}" />
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
        }
        #head{
            text-align: center;
        }
        </style>
        <script>

            function validateAmount(){
                var courseBookBorrowableAdmin = parseInt(document.getElementById("courseBookBorrowableAdmin").value);
                var courseBookBorrowableFaculty = parseInt(document.getElementById("courseBookBorrowableFaculty").value);
                var courseBookBorrowableLibrarian = parseInt(document.getElementById("courseBookBorrowableLibrarian").value);
                var courseBookBorrowableStudent = parseInt(document.getElementById("courseBookBorrowableStudent").value);
                var fineAmtAdmin = parseInt(document.getElementById("fineAmtAdmin").value);
                var fineAmtFaculty = parseInt(document.getElementById("fineAmtFaculty").value);
                var fineAmtLibrarian = parseInt(document.getElementById("fineAmtLibrarian").value);
                var fineAmtStudent = parseInt(document.getElementById("fineAmtStudent").value);
                var limitBookBorrowableAdmin = parseInt(document.getElementById("limitBookBorrowableAdmin").value);
                var limitBookBorrowableFaculty = parseInt(document.getElementById("limitBookBorrowableFaculty").value);
                var limitBookBorrowableLibrarian = parseInt(document.getElementById("limitBookBorrowableLibrarian").value);
                var limitBookBorrowableStudent = parseInt(document.getElementById("limitBookBorrowableStudent").value);
                var novelBookBorrowable = parseInt(document.getElementById("novelBookBorrowable").value);
                console.log("Hello"+courseBookBorrowableAdmin);
                if(nonNegative(courseBookBorrowableAdmin)&&nonNegative(courseBookBorrowableFaculty
                        &&nonNegative(courseBookBorrowableLibrarian)&&nonNegative(courseBookBorrowableStudent)
                        &&nonNegative(fineAmtAdmin)&&nonNegative(fineAmtFaculty)&&nonNegative(fineAmtLibrarian)
                        &&nonNegative(fineAmtStudent)&&nonNegative(limitBookBorrowableAdmin)
                        &&nonNegative(limitBookBorrowableFaculty)&&nonNegative(limitBookBorrowableLibrarian)
                        &&nonNegative(limitBookBorrowableStudent)&&nonNegative(novelBookBorrowable))){

                    return true;
                }
                else{
                    alert("Amount cannot be negative!");
                    return false;
                }
            }

            function nonNegative(num){
                console.log(num);
                return num >= 0;
            }
        </script>
	</head>
	<body>
    <div id="head">
        <div class="ui compact menu" style="margin: 13px;">
            <div class="active item">
                <g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link>            </div>
        </div>
    </div>
			<g:form url="[resource:configureInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${configureInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
					<g:actionSubmit class="ui blue button" onsubmit="return validateAmount()"
                                    action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
	</body>
</html>
