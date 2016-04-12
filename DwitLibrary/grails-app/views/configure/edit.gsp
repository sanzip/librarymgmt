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
                if(negative(courseBookBorrowableAdmin)){
                    alert("Course Book Borrowable for admin is negative!!!")
                    return false;

                }
                else if(negative(courseBookBorrowableFaculty)){
                    alert("Course Book Borrowable for faculty is negative!!!")
                    return false;
                }
                else if(negative(courseBookBorrowableLibrarian)){
                    alert("Course Book Borrowable for librarian is negative!!!")
                    return false;
                }
                else if(negative(courseBookBorrowableStudent) )  {
                    alert("Course Book Borrowable for student is negative!!!")
                    return false;
                }
                else if(negative(fineAmtAdmin)){
                    alert("Fine amount for Admin is negative!!!")
                    return false;
                }
                else if(negative(fineAmtFaculty)){
                    alert("Fine amount for faculty is negative!!!")
                    return false;
                }
                else if(negative(fineAmtLibrarian)){
                    alert("Fine amount for librarian is negative!!!")
                    return false;
                }
                else if(negative(fineAmtStudent)){
                    alert("Fine amount for student is negative!!!")
                    return false;
                }
                else if(negative(novelBookBorrowable)){
                    alert("Novel Book Borrowable!!!")
                    return false;
                }
                else{
                    return true;
                }
            }

            function negative(num){
                alert
                return num < 0;
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
					<g:actionSubmit class="ui blue button" onClick="return validateAmount()"
                                    action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
	</body>
</html>
