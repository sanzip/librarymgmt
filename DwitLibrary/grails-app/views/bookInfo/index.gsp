
<%@ page import="np.edu.dwit.BookInfo" %>
<!DOCTYPE html>
<html>
	<head>
        <meta name="layout" content="main_page">
		<g:set var="entityName" value="${message(code: 'bookInfo.label', default: 'BookInfo')}" />
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
        #head{
            text-align: center;
        }
        </style>
        <script>

            function setValue(){
                $("#bookNumber").val('');
            }
            $(document).ready(function(){
                setValue();

                var table;
                if ( $.fn.dataTable.isDataTable( '#book_info_table' ) ) {
                    table = $('#book_info_table').DataTable();
                }
                else {
                    table = $('#book_info_table').DataTable( {
                        'bPaginate':true,
                        'bInfo':false,
                        'bFilter': true
                    } );
                }
                $('#bookNumber').on( 'keyup', function () {
                    table
                            .columns( 1 )
                            .search( this.value )
                            .draw();
                } );

                var value = $("#allowed").val();
                if(value==="0") {
                    $("#newbooktab").hide();
                }else{
                    $("#newbooktab").show();
                }
                <g:if test="${flash.message}">
                var n = noty({
                    layout: 'topRight',
                    theme: 'relax',
                    type: '${params.messageType}',
                    text: '${flash.message}',
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing', // easing
                        speed: 500
                    },
                    timeout: 10000
                });
                n.animate();
                </g:if>
            })
        </script>
	</head>

    <div id="wrappers">
        <br>
        <div id="head">
            <div class="ui compact menu" style="float: left">
                <div class="active item">
				    <g:link controller="book" class="index" action="index">Book List</g:link>
                </div>
                <div class="active item" id="newbook">
				    <g:link class="create" action="create" params="[id: params.id]"><g:message code="default.new.label" args="[entityName]" /></g:link>
                 </div>
            </div>
		</div>
        %{--<div class="ui label" style="text-align: center;margin: 0px auto;width:300px;display: table;background-color: #F7F7F7">--}%
            %{--<div class="ui input">--}%
                %{--Number Of Book Info remaining to add:--}%
                %{--<input style="text-align: center;width:20%" type="text" name="allowed" id="allowed" value="${count}" disabled="">--}%
            %{--</div>--}%
        %{--</div>--}%

		<div id="list-bookInfo" class="content scaffold-list" role="main">
            %{--<h1 style="text-align: center"><g:message code="default.list.label" args="[entityName]" /></h1>--}%

            %{--<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
--}%
            <div class="ui icon input" style="float: right">
                <input type="text" name="bookNumber" id="bookNumber" placeholder="Book Number..."/>
                <i class="inverted circular search link icon"></i>
            </div>
        <br><br>
    <table class="ui celled table" id="book_info_table">
			<thead>
					<tr>

						<th><g:message code="bookInfo.book.label" default="Book" /></th>

						<g:sortableColumn property="bookNumber" title="${message(code: 'bookInfo.bookNumber.label', default: 'Book Number')}" />

						%{--<g:sortableColumn property="edition" title="${message(code: 'bookInfo.edition.label', default: 'Edition')}" />--}%

						<g:sortableColumn property="publishedYear" title="${message(code: 'bookInfo.publishedYear.label', default: 'Published Year')}" />

						<g:sortableColumn property="pages" title="${message(code: 'bookInfo.pages.label', default: 'Pages')}" />

						<g:sortableColumn property="cost" title="${message(code: 'bookInfo.cost.label', default: 'Cost')}" />

                        <g:sortableColumn property="bookType" title="${message(code: 'bookInfo.bookType.label', default: 'Book Type')}" />

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

						%{--<td>${fieldValue(bean: bookInfoInstance, field: "edition")}</td>--}%

						<td>${fieldValue(bean: bookInfoInstance, field: "publishedYear")}</td>

						<td>${fieldValue(bean: bookInfoInstance, field: "pages")}</td>

						<td>${fieldValue(bean: bookInfoInstance, field: "cost")}</td>

                        <td>${fieldValue(bean: bookInfoInstance, field: "bookType")}</td>

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
