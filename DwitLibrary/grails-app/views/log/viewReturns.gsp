<%--
  Created by IntelliJ IDEA.
  User: asimsangram
  Date: 11/13/15
  Time: 6:55 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Return Log</title>
    <meta name="layout" content="main_page">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'datatable.min.css')}" />
    <g:javascript src="datatable-min.js"/>
    <style>
    .dataTables_filter {
        display: none;
    }
    </style>
    <script>
        function setValue(){
            $("#returned_to").val('');
            $("#returned_by").val('');
            $("#book_name").val('');
        }

        $(document).ready(function(){
            setValue();


            if ( $.fn.dataTable.isDataTable( '#return_table' ) ) {
                table = $('#return_table').DataTable();
            }
            else {
                table = $('#return_table').DataTable( {
                    'bPaginate':false,
                    'bInfo':false,
                    'bFilter': true
                } );
            }
            $('#returned_to').on( 'keyup', function () {
                table
                        .columns( 1 )
                        .search( this.value )
                        .draw();
            } );
            $('#returned_by').on( 'keyup', function () {
                table
                        .columns( 4 )
                        .search( this.value )
                        .draw();
            } );
            $('#book_name').on( 'keyup', function () {
                table
                        .columns( 2 )
                        .search( this.value )
                        .draw();
            } );
        })
    </script>
</head>

<body>
<br>
Returned To: <g:textField name="returned_to" id="returned_to"/>
Returned by: <g:textField name="returned_by" id="returned_by"/>
Book Name: <g:textField name="book_name" id="book_name"/>
<br>

    <table class="ui sortable celled table" id="return_table" style="margin: 0px auto;width: 95%">
        <thead>
        <tr>
            <th>S.N.</th>
            <th>Returned To</th>
            <th>Book Name</th>
            <th>Book Number</th>
            <th>Returned By</th>
            <th>Returned Date</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${returnLogs}" var="returnLog" status="i">
            <tr>
                <td>${i + 1}</td>
                <td>${returnLog.to.fullName}</td>
                <td>${returnLog.borrow.bookInfo.book.name}</td>
                <td>${returnLog.borrow.bookInfo.bookNumber}</td>
                <td>${returnLog.by.fullName}</td>
                <td>${returnLog.borrow.returnedDate}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</body>
</html>