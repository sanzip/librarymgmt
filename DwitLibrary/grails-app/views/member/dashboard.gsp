<%--
  Created by IntelliJ IDEA.
  User: saneel
  Date: 11/3/15
  Time: 12:15 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main_page">
    <title> Dashboard </title>
    <script src="${resource(dir: 'js', file: 'jquery-2.1.4.min.js')}"> </script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'datatable.min.css')}" />
    <g:javascript src="datatable-min.js"/>
    <style>
    .dataTables_filter {
        display: none;
    }
    #wrapper{
        margin: 0px auto;
        width: 95%;
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
<div id="wrapper">
<div class="ui six item menu">
    <div class="item">
        <g:link controller="member" action="history" params="[id: params.id]">History</g:link>
    </div>
    <sec:ifAllGranted roles="ROLE_LIBRARIAN">
        <div class="item">
        <a href="#">Issue</a>
        </div>
    <div class="item">
        <g:link action="returnBook" controller="book">Return book</g:link>
    </div>
    <div class="item">
        <g:link action="create" controller="member">User</g:link>
    </div>
        <div class="item">
            <g:link action="create" controller="book">Book</g:link>
        </div>
        <div class="item">
            <a href="#">Configure</a>
        </div>
    </sec:ifAllGranted>
    </div>
    </br></br></br>
        %{--
        <form name="logout" method="POST" action="${createLink(controller:'logout') }">
            <input type="submit" value="logout"></form>--}%
    <strong><span style="font-size: 18px;">Book Name:</span></strong>
    <div class="ui icon input">
        <input type="text" placeholder="Search Books" id="bookName" name="bookName">
        <i class="inverted circular search link icon"></i>
    </div>
    &nbsp;&nbsp;&nbsp;<strong><span style="font-size: 18px;">Author Name:</span></strong>
    <div class="ui icon input">
        <input type="text" placeholder="Search Author" id="authorName" name="authorName">
        <i class="inverted circular search link icon"></i>
    </div>
    <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
        <div>Number of allowed : <input type="text" name="allowed" id="allowed" value="${count}" disabled></div>
    </sec:ifAnyGranted>
</br></br>
    <div id="ajaxed_div">
        <g:render template="dashBordAfterChange"/>
    </div>
</div>
</body>
</html>