<%--
  Created by IntelliJ IDEA.
  User: asimsangram
  Date: 11/5/15
  Time: 12:31 PM
--%>


<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Issued Books Report</title>
    <meta name="layout" content="main_page">
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
    </style>
    <script>
        function setValue(){
            $("#bookName").val('');
        }
        $(document).ready(function(){
            setValue();
            var table;
            if ( $.fn.dataTable.isDataTable( '#first_table' ) ) {
                table = $('#first_table').DataTable();
            }
            else {
                table = $('#first_table').DataTable( {
                    'bPaginate':false,
                    'bInfo':false,
                    'bFilter': true
                } );
            }
            $('#bookName').on( 'keyup', function () {
                table
                        .columns( 1 )
                        .search( this.value )
                        .draw();
            } );
        })
    </script>

</head>

<body>
    <br>

    %{--<g:if test="${flash.message}">--}%
        %{--<div class="ui center aligned segment">--}%
            %{--<div class="ui positive message">--}%
                %{--<div class="header">--}%
                    %{--<h1 style="text-align: center">${flash.message}</h1>--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</g:if>--}%
    %{--<br>--}%

    %{--<g:if test="${flash.message}">--}%
        %{--<div class="ui center aligned segment">--}%
            %{--<div class="ui positive message">--}%
                %{--<div class="header">--}%
                    %{--<h1 style="text-align: center">${flash.message}</h1>--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</g:if>--}%
<div id="wrappers">

    <div id="ajaxed_div">
        <div class="ui icon input" style="float: right; margin-bottom: 24px;">
            <input type="text" name="bookName" id="bookName" placeholder="Search Book Name..."/>
            <i class="inverted circular search link icon"></i>
        </div>
        <table id="first_table" class="ui sortable celled table" cellspacing="0" width="100% margin: 0px">
            <thead>
            <tr>
                <th>S.No</th>
                <th>Name</th>
                <th>Author</th>
                <th>No. of Issues</th>
            </tr>
            </thead>
            <tbody>
                <g:each in="${booksWithBorrowCount}" var="bookWithBorrowCount" status="i">
                    <tr>
                        <td>${i + 1}</td>
                        <td>${bookWithBorrowCount.key.name}</td>
                        <td>${bookWithBorrowCount.key.author}</td>
                        <td>${bookWithBorrowCount.value}</td>
                    </tr>
                </g:each>
            </tbody>
        </table>
        %{--<div id = "issueBook">

        </div>
    <br>
    <div id="space">
        <g:paginate total="$list ?: 0}" />
    </div>
    --}%
        %{--<script>--}%
            %{--function setValue(){--}%
                %{--$("#bookName").val('');--}%
                %{--$("#authorName").val('');--}%
            %{--}--}%
            %{--$(document).ready(function(){--}%
                %{--setValue();--}%
                %{--var table = $('#first_table').DataTable();--}%

                %{--$('#bookName').on( 'keyup', function () {--}%
                    %{--table--}%
                            %{--.columns( 1 )--}%
                            %{--.search( this.value )--}%
                            %{--.draw();--}%
                %{--} );--}%
                %{--$('#authorName').on( 'keyup', function () {--}%
                    %{--table--}%
                            %{--.columns( 2 )--}%
                            %{--.search( this.value )--}%
                            %{--.draw();--}%
                %{--} );--}%
            %{--})--}%
        %{--</script>--}%

        %{--<input type="hidden" id = "bookForIssue"/>--}%
    </div>
</div>
</body>
</html>