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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="${resource(dir: 'semantic/dist', file: 'semantic.min.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css/assets/css', file: 'style.css')}" rel="stylesheet">
    <script src="${resource(dir: 'semantic/dist', file: 'jquery-2.1.4.min.js')}"></script>
    <script src="${resource(dir: 'js', file: 'typeahead.js')}"></script>
    <script src="${resource(dir: 'js', file: 'custom.js')}"></script>
    <script src="${resource(dir: 'js/noty/packaged', file: 'jquery.noty.packaged.min.js')}"></script>
    <script type="text/javascript">
        $(function()
        {
            /*$("#datepicker").datepicker({dateFormat: 'yy/mm/dd'});*/
        })
    </script>
    <g:layoutHead/>
    <g:javascript library="application"/>
    <r:layoutResources />
    <style>
        * {
            margin: 0;
        }

        html, body {
            /* all your other css */
            height: 100%;
        }
        i{
            color: white;
        }
        form{
            text-align: right;
        }
        #wrapper {
            height: auto !important;
            height: 100%;
            margin: 0 auto -20px; /* must be the height of your footer */
            min-height: 100%;
        }

        #footer, #footer-push {
            height: 20px;
            line-height: 20px;
        }
    </style>
</head>
<body>
    <div id="wrapper">
        <g:render template="/layouts/header"/>
        <div class="contents">
            <g:layoutBody/>
            <r:layoutResources />
            <div id="footer-push"></div>
        </div>
    </div>
    <g:render template="/layouts/footer"/>
</body>
</html>
