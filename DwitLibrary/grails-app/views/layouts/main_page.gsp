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
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title><g:layoutTitle default="Grails"/></title>
    <link href="${resource(dir: 'css/assets/css', file: 'style.css')}" rel="stylesheet">
    <script src="${resource(dir: 'semantic/dist', file: 'jquery-2.1.4.min.js')}"></script>
    <script src="${resource(dir: 'semantic/dist', file: 'semantic.min.js')}"></script>
    <link href="${resource(dir: 'semantic/dist', file: 'semantic.min.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css/assets/css', file: 'style.css')}" rel="stylesheet">
    <script src="${resource(dir: 'js', file: 'custom.js')}"></script>
    <script type="text/javascript">
        $(function()
        {
            /*$("#datepicker").datepicker({dateFormat: 'yy/mm/dd'});*/
        })
    </script>
    <g:javascript library="jquery" plugin="jquery"/>
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
        <h1 style="color:white;float:left"><b>Library Management System</b></h1></img>
        <div style="float:right;color: white; font-style: oblique; font-size: 20px" class="item">
            <form name="logout" method="POST" style="float: right;color: #E7746F" class="item" action="${createLink(controller:'logout') }">
               <em>
                   <input type="submit" class="ui button" value="logout" style="color:#fff;background-color:rgba(255, 0, 0, 0.04)">
               </em>
            </form>
        </div>
    </div>
    <div class="ui five item menu" style="margin: 0px auto;width: 98%;">
        <div class="ui large menu">
            <div class="ui simple link item">
                <g:link controller="member" action="history" params="[id: id]"><i class="icon book"></i> History</g:link>
            </div>

            <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                <div class="ui simple link item">
                    <g:link controller="book" action="issueBook"> <i class="icon users"></i> Issue </g:link>
                </div>
                <div class="ui simple link item">
                    <g:link controller="book" action="returnBook"> <i class="icon users"></i> Return </g:link>
                </div>
                <div class="ui simple link item">
                    <g:link controller="member" action="report"> <i class="icon users"></i> Report </g:link>
                </div>
                <div class="ui simple dropdown link item">
                    <i class="icon book"></i> Configure <i class="dropdown icon"></i>
                    <div class="menu">
                        <g:link controller="member" action="create" class="item"> <i class="list icon"></i>  User  </g:link>
                        <g:link controller="book" action="create" class="item"> <i class="plus icon"></i>  Book  </g:link>
                    </div>
                </div>
            </sec:ifAllGranted>
        </div>
    </div>
<g:layoutBody/>
<r:layoutResources />
</body>
</html>
