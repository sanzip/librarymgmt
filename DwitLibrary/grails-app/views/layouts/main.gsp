<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title></title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="${createLinkTo(dir:'img',file:'deerwalk.png')}" type="image/x-icon" />

    <link href="${resource(dir: 'semantic/dist', file: 'semantic.min.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css/assets/css', file: 'style.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'jquery-ui.min.css')}" rel="stylesheet">
    <script src="${resource(dir: 'semantic/dist', file: 'jquery-2.1.4.min.js')}"></script>
    <script src="${resource(dir: 'js', file: 'typeahead.js')}"></script>
    <script src="${resource(dir: 'js', file: 'custom.js')}"></script>
    <script src="${resource(dir: 'js', file: 'jquery-ui.min.js')}"></script>
    <script src="${resource(dir: 'semantic/dist/components', file: 'modal.js')}"></script>
    <script src="${resource(dir: 'semantic/dist/components', file: 'modal.min.js')}"></script>
    <link href="${resource(dir: 'semantic/dist/components', file: 'modal.css')}" rel="stylesheet">
    <link href="${resource(dir: 'semantic/dist/components', file: 'modal.min.css')}" rel="stylesheet">
    <script src="${resource(dir: 'js/noty/packaged', file: 'jquery.noty.packaged.min.js')}"></script>
    <script src="${resource(dir: 'js', file: 'jquery.sessionTimeout.js')}"></script>
    <link href="${resource(dir: 'css',file: 'style.css')}" rel="stylesheet">
		<script type="text/javascript">
			$(function()
			{
			})
		</script>
		<g:layoutHead/>
		<g:javascript library="application"/>
		<r:layoutResources />
	</head>
	<body>
		<g:layoutBody/>

		%{--<div class="footer" role="contentinfo"></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>--}%
		<r:layoutResources />
	</body>
</html>
