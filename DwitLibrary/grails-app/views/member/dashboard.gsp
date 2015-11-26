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
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'datatable.min.css')}" />--}%
    <g:javascript src="datatable-min.js"/>
    <style>
    .dataTables_filter {
        display: none;
    }
    #wrapper1{
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
    </style>

    <g:javascript>
        function selectBook(id){

            $('#mo').show();
        }
    </g:javascript>
</head>


<div id="wrapper1">
    <br><hr>
    <br>
    <div style="margin: 0px auto;width: 77%;">
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
    <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
        %{--<div>Number of allowed : <input type="text" name="allowed" id="allowed" value="${count}" disabled></div>--}%
        <div class="ui label" style="text-align: center;margin: 0px auto;width:300px;display: table;background-color: #F7F7F7">
            <div class="ui input">
                Number Of Books Allowed:
                <input style="text-align: center;width:20%" type="text" name="allowed" id="allowed" value="${count}" disabled="">
            </div>
        </div>

    </sec:ifAnyGranted>

<div id="ajaxed_div">
    <g:render template="dashBordAfterChange"/>
</div>
</div>
</body>
</html>