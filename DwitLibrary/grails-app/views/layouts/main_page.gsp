<%--
  Created by IntelliJ IDEA.
  User: sumitshrestha
  Date: 11/6/15
  Time: 10:22 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/></title>
    <script type="text/javascript">
        $(document).ready(function()
        {
            $("#datepicker").datepicker({dateFormat: 'yy/mm/dd'});
        })
    </script>
    <title><g:layoutTitle/></title>
    <g:javascript library="jquery"/>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="${resource(dir: 'semantic/dist', file: 'semantic.min.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css/assets/css', file: 'style.css')}" rel="stylesheet">
    <script src="${resource(dir: 'semantic/dist', file: 'jquery-2.1.4.min.js')}"></script>
    <script src="${resource(dir: 'js', file: 'custom.js')}"></script>
    <g:layoutHead/>
    <g:javascript library="application"/>
    <r:layoutResources />
    <style>
    i{
        color: white;
    }
    form{
        text-align: right;
    }

    </style>
</head>
<body>
    <div class="ui center aligned segment" style="background-color: #3573A3;">
        <img style="float: left; height: 80px;width: 80px" src="${resource(dir: 'img', file: 'deerwalk.png')}" alt="Logo" >
        <h1 style="color:white"><b>Library Management System</b></h1></img>

        %{--<p style="float:right;color: white; font-style: oblique; font-size: 20px" class="item"><b>Hello ${session.userName}</b><br>
            <g:link style="float: right;color: #ASD6F2" controller="logout" class="item"> <i class="power icon"></i>Logout </g:link></p>--}%
        <form name="logout" method="POST" action="${createLink(controller:'logout') }">

        <em><i class="power icon"></i><input type="submit" class="ui button" value="logout" style="background-color:rgba(255, 0, 0, 0.04)"></em></form>
    </div>
<g:layoutBody/>
<r:layoutResources />
</body>
</html>
