
<%@ page import="np.edu.dwit.Configure" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_page">
		<g:set var="entityName" value="${message(code: 'configure.label', default: 'Configure')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <style>
        .dataTables_filter {
            display: none;
        }
        #wrappers{
            margin: 0px auto;
            width: 95%;
        }
        #authorSearch{
            text-align: center;
            margin-top:-37px;
            margin-left:424px;
        }
        #bookSearch{
            text-align: left;
        }
        #head{
            text-align: center;
        }
        </style>
	</head>
	<body>
        <br>
        <div class="ui one column grid" style="margin: 0px auto;text-align: center;background-color: #F7F7F7;width:50%;">
            <div class="column">
    <g:each in="${configureInstanceList}" status="i" var="configureInstance">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
        <div class="ui raised segment" style="text-align: left">
            <a class="ui blue ribbon label">Fine Amount Admin</a>
            <span>: ${fieldValue(bean: configureInstance, field: "fineAmtAdmin")}</span>
            <p></p>

            <a class="ui blue ribbon label">Fine Amount Faculty</a>
            <span>: ${fieldValue(bean: configureInstance, field: "fineAmtFaculty")}</span>
            <p></p>

            <a class="ui blue ribbon label">Fine Amount Student</a>
            <span>: ${fieldValue(bean: configureInstance, field: "fineAmtStudent")}</span>
            <p></p>

            <a class="ui blue ribbon label">Fine Amount Librarian</a>
            <span>: ${fieldValue(bean: configureInstance, field: "fineAmtLibrarian")}</span>
            <p></p>

            <a class="ui blue ribbon label">Course Book Borrowable Admin </a>
            <span>: ${fieldValue(bean: configureInstance, field: "courseBookBorrowableAdmin")}</span>
            <p></p>

            <a class="ui blue ribbon label">Days Course Book Borrowable Admin </a>
            <span>: ${fieldValue(bean: configureInstance, field: "daysCourseBookBorrowableAdmin")}</span>
            <p></p>

            <a class="ui blue ribbon label">Course Book Borrowable Faculty</a>
            <span>: ${fieldValue(bean: configureInstance, field: "courseBookBorrowableFaculty")}</span>
            <p></p>

            <a class="ui blue ribbon label">Days Course Book Borrowable Faculty</a>
            <span>: ${fieldValue(bean: configureInstance, field: "daysCourseBookBorrowableFaculty")}</span>
            <p></p>

            <a class="ui blue ribbon label"> Course Book Borrowable Librarian </a>
            <span>: ${fieldValue(bean: configureInstance, field: "courseBookBorrowableLibrarian")}</span>
            <p></p>

            <a class="ui blue ribbon label">Days Course Book Borrowable Librarian </a>
            <span>: ${fieldValue(bean: configureInstance, field: "daysCourseBookBorrowableLibrarian")}</span>
            <p></p>

            <a class="ui blue ribbon label">Course Book Borrowable Student</a>
            <span>: ${fieldValue(bean: configureInstance, field: "courseBookBorrowableStudent")}</span>
            <p></p>

            <a class="ui blue ribbon label">Days Course Book Borrowable Student</a>
            <span>: ${fieldValue(bean: configureInstance, field: "daysCourseBookBorrowableStudent")}</span>
            <p></p>

            <a class="ui blue ribbon label">Novel Book Borrowable</a>
            <span>: ${fieldValue(bean: configureInstance, field: "novelBookBorrowable")}</span>
            <p></p>

            <a class="ui blue ribbon label">Days Novel Book Borrowable</a>
            <span>: ${fieldValue(bean: configureInstance, field: "daysNovelBookBorrowable")}</span>
            <p></p>

                </div>
<br>
        <div id="">
            <div id="head">
                <g:link class="edit" action="edit" resource="${configureInstance}">
                    <button type="button" class="ui green button">
                        <i class="edit icon"> </i>
                        <g:message code="default.button.edit.label" default="Edit"/>
                    </button>
                </g:link>
            %{--<g:form url="[resource:bookInfoInstance, action:'delete']" method="DELETE" style="float:left">--}%
            %{--<g:link class="ui green button" action="edit" resource="${bookInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>--}%
            %{--</g:form>--}%


            </div>
        </div>
        </g:each>
                <br>
            </div>
            </div>

			<div class="pagination">
				<g:paginate total="${configureInstanceCount ?: 0}" />
			</div>
        </div>
    </div>
	</body>
</html>
