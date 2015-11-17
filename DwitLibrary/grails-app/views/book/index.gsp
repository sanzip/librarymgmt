
<%@ page import="np.edu.dwit.Book" %>
<!DOCTYPE html>
<html>
	<head>
        <meta name="layout" content="main_page">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'datatable.min.css')}" />
        <g:javascript src="datatable-min.js"/>
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
            margin-left:180px;
        }
        #bookSearch{
            text-align: left;
        }
        #head{
            text-align: center;
        }
        </style>
    <script>
        function setValue(){
            $("#bookName").val('');
            $("#authorName").val('');
        }
        $(document).ready(function(){
            setValue();
            var table;
            if ( $.fn.dataTable.isDataTable( '#book_table' ) ) {
                table = $('#book_table').DataTable();
            }
            else {
                table = $('#book_table').DataTable( {
                    'bPaginate':false,
                    'bInfo':false,
                    'bFilter': true
                } );
            }

            $('#bookName').on( 'keyup', function () {
                table
                        .columns( 0 )
                        .search( this.value )
                        .draw();
            } );
            $('#authorName').on( 'keyup', function () {
                table
                        .columns( 1 )
                        .search( this.value )
                        .draw();
            } );
        })
    </script>
	</head>

    <div id="wrappers">
        <br>

		<div id="list-book" class="content scaffold-list" role="main">

			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
            <br><hr><br>

            <div style="text-align: center;">
                <div id="bookSearch">
                    <strong><span style="font-size: 18px;">Book Name:</span></strong>
                <div class="ui icon input">
                    <input type="text" placeholder="Search Books" id="bookName" name="bookName" style="width: 382px;">
                    <i class="inverted circular search link icon"></i>
                </div>
                    </div>
                <div id="authorSearch">

                    <strong><span style="font-size: 18px;">Author Name:</span></strong>
                <div class="ui icon input">
                    <input type="text" placeholder="Search Author" id="authorName" name="authorName">
                    <i class="inverted circular search link icon"></i>
                </div>
                    </div>
            </div>

            <br><hr><br>
            <div id="head">
                <div class="ui compact menu"  style="float: left">
                    %{--<div class="active item">--}%
                    %{--<a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>--}%
                    %{--</div>--}%
                    <div class="active item">
                        <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                    </div>
                </div>
                %{--<h1 style="text-align: center"><g:message code="default.list.label" args="[entityName]" /></h1>--}%
            </div>
            <br><br>

            <table class="ui celled table" id="book_table">
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'book.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="author" title="${message(code: 'book.author.label', default: 'Author')}" />
					
						<g:sortableColumn property="publication" title="${message(code: 'book.publication.label', default: 'Publication')}" />
					
						<g:sortableColumn property="availableQuantity" title="${message(code: 'book.availableQuantity.label', default: 'Available Quantity')}" />
					
						<g:sortableColumn property="totalQuantity" title="${message(code: 'book.totalQuantity.label', default: 'Total Quantity')}" />
					

                        <th> Action </th>

                    </tr>
				</thead>
				<tbody>
				<g:each in="${bookInstanceList}" status="i" var="bookInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">


						<td><g:link controller="bookInfo" action="index" params="[id: bookInstance.id ]" id="${bookInstance.id}">${fieldValue(bean: bookInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: bookInstance, field: "author")}</td>
					
						<td>${fieldValue(bean: bookInstance, field: "publication")}</td>
					
						<td>${fieldValue(bean: bookInstance, field: "availableQuantity")}</td>
					
						<td>${fieldValue(bean: bookInstance, field: "totalQuantity")}</td>
					
                        <td>
                            <div class="ui buttons">
                                <g:link class="edit" action="edit" resource="${bookInstance}" style="color:#000000;">
                                    <button type="button" class="ui button">
                                        <i class="edit icon"> </i>
                                        <g:message code="default.button.edit.label" default="Edit"/>
                                    </button>
                                </g:link>
                                %{--TODO<g:form url="[resource: bookInstance, action: 'delete']" method="DELETE">--}%
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
				<g:paginate total="${bookInstanceCount ?: 0}" />
			</div>
		</div>
        </div>
	</body>
</html>
