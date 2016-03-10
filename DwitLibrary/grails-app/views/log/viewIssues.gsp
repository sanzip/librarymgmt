<%--
  Created by IntelliJ IDEA.
  User: asimsangram
  Date: 11/13/15
  Time: 6:55 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Issue Log</title>
    <meta name="layout" content="main_page">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'datatable.min.css')}" />
    <g:javascript src="datatable-min.js"/>
    <style>
        .dataTables_filter {
            display: none;
        }
        #wrapper1{
            margin: 0px auto;
            width: 95%;
        }
    #searchField{
        margin:0px auto;
        width:80%;
    }
    </style>
    <script>
        function setValue(){
            $("#issued_to").val('');
            $("#issued_by").val('');
            $("#book_name").val('');
        }

        $(document).ready(function(){
            setValue();


            if ( $.fn.dataTable.isDataTable( '#issue_table' ) ) {
                table = $('#issue_table').DataTable();
            }
            else {
                table = $('#issue_table').DataTable( {
                    'bPaginate':true,
                    'bInfo':false,
                    'bFilter': true
                } );
            }
            $('#issued_to').on( 'keyup', function () {
                table
                        .columns( 4 )
                        .search( this.value )
                        .draw();
            } );
            $('#issued_by').on( 'keyup', function () {
                table
                        .columns( 1 )
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
<div id="wrapper1">
    <hr>
    <div id="searchField">
    </br>

    <strong><span style="font-size: 18px;">Issued To: </span></strong>
    <div class="ui icon input">
        <input type="text" placeholder="" id="issued_to" name="issued_to">
        <i class="inverted circular search link icon"></i>
    </div>
%{--
Issued To: <g:textField name="issued_to" id="issued_to"/>
--}%
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

    <strong><span style="font-size: 18px;">Issued By: </span></strong>
    <div class="ui icon input">
        <input type="text" placeholder="" id="issued_by" name="issued_by">
        <i class="inverted circular search link icon"></i>
    </div>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
%{--
Issued by: <g:textField name="issued_by" id="issued_by"/>
--}%
%{--
Book Name: <g:textField name="book_name" id="book_name"/>
--}%

    <strong><span style="font-size: 18px;">Book Name: </span></strong>
    <div class="ui icon input">
        <input type="text" placeholder="" id="book_name" name="book_name">
        <i class="inverted circular search link icon"></i>
    </div>
    <br>
        </div>
    <br>
    <hr>
    <br>
    <table class="ui sortable celled table" id="issue_table" style="margin: 0px auto;width: 95%">
        <thead>
        <tr>
            <th>S.N.</th>
            <th>Issued By</th>
            <th>Book Name</th>
            <th>Book Number</th>
            <th>Issued To</th>
            <th>Issued Date</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${issueLogs}" var="issueLog" status="i">
            <tr>
                <td>${i + 1}</td>
                <td>${issueLog.by.fullName}</td>
                <td>${issueLog.borrow.bookInfo.book.name}</td>
                <td>${issueLog.borrow.bookInfo.bookNumber}</td>
                <td>${issueLog.to.fullName}</td>
                <td>${issueLog.borrow.borrowedDate}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
    </div>
</body>
</html>