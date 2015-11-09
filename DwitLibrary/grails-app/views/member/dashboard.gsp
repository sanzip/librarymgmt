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
%{--    <link rel="stylesheet" href="${resource(dir: 'css', file: 'datatable.min.css')}" />
    <g:javascript src="datatable-min.js"/>--}%
    <style>
    /*.dataTables_filter {
        display: none;
    }*/
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
        /*$(function(){
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
        })*/
    </script>
    <g:javascript>
        function selectBook(id){

            $('#mo').show();
        }
        $(function(){

            $("#cancel").on('click', function(){

                $('#mo').hide();
            });
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
        });
    </g:javascript>
</head>


<body>
<div id="wrapper">
    <br>
    <div style="text-align: center;">
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
    </div>

    <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
        <div>Number of allowed : <input type="text" name="allowed" id="allowed" value="${count}" disabled></div>
    </sec:ifAnyGranted>

    <div id="ajaxed_div">
        <g:render template="dashBordAfterChange"/>
    </div>
</div>
</body>
</html>