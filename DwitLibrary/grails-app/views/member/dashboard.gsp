<%--
  Created by IntelliJ IDEA.
  User: saneel
  Date: 11/3/15
  Time: 12:15 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <script src="${resource(dir: 'js', file: 'jquery-2.1.4.min.js')}"> </script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'datatable.min.css')}" />
    <g:javascript src="datatable-min.js"/>
    <style>
    .dataTables_filter {
        display: none;
    }
    </style>
    <script>
        function setValue(){
            $("#bookName").val('');
            $("#authorName").val('');
        }
        $(document).ready(function(){
            setValue();
            var table = $('#first_table').DataTable();

            $('#bookName').on( 'keyup', function () {
                table
                        .columns( 1 )
                        .search( this.value )
                        .draw();
            } );
            $('#authorName').on( 'keyup', function () {
                table
                        .columns( 2 )
                        .search( this.value )
                        .draw();
            } );
        })
    </script>
</head>

<body>
    <ul>
        <g:link controller="member" action="history" params="[id: params.id]"><li>History</li></g:link>
        <sec:ifAllGranted roles="ROLE_LIBRARIAN">
            <a href="#"><li>Issue</li></a>

            <g:link action="returnBook" controller="book">Return book</g:link>
            <g:link action="report" controller="book">Report</g:link>
            <a href="#"><li>Configure</li></a>
            <g:link action="create" controller="book">Book</g:link>
            <g:link action="create" controller="member">User</g:link>

        </sec:ifAllGranted>
        <form name="logout" method="POST" action="${createLink(controller:'logout') }">
            <input type="submit" value="logout"></form>
    </ul>
    Book Name: <input type="text" name="bookName" id="bookName"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp; AuthorName<input type="text" name="authorName" id="authorName" >


    <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
        <div>Number of allowed : <input type="text" name="allowed" id="allowed" value="${count}" disabled></div>
    </sec:ifAnyGranted>

    <div id="ajaxed_div">
        <g:render template="dashBordAfterChange"/>
    </div>

</body>
</html>