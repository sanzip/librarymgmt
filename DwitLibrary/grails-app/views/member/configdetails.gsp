<%--
  Created by IntelliJ IDEA.
  User: sumitshrestha
  Date: 11/20/15
  Time: 6:53 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="main_page">
<style>
#wrapper1{
    margin: 0px auto;
    width: 45%;
}
</style>
</head>

<body>
<br>
<div id="wrapper1">
    <div class="ui form" style="margin: 0px auto;width:90%;">
        <div class="column">
        <div class="ui raised segment">
            <a class="ui blue ribbon label">Fine</a>
                <br><br>
            <div class="two fields">

                <div class="field">
                    <h3 class="ui dividing header">Full Name <span class="required-indicator">*</span> </h3>
                    <g:textField name="fullName" id="fullName" required="" onkeypress="return onlyAlphabets(event,this);" value="${memberInstance?.fullName}"/>
                </div>
                <div class="field">

                    <h3 class="ui dividing header">User Id <span class="required-indicator">*</span> </h3>

                    <g:textField name="userId" required="" id="userId" onkeypress="return onlyNumbers(event,this);" value="${memberInstance?.userId}"/>

            </div>
                </div>
            <p></p>
        </div>
    </div>

    <div class="column">
        <div class="ui raised segment">
            <a class="ui blue ribbon label">Course Book</a>
                <br><br>
                <div class="two fields">

                    <div class="field">
                        <h3 class="ui dividing header">Full Name <span class="required-indicator">*</span> </h3>
                        <g:textField name="fullName" id="fullName" required="" onkeypress="return onlyAlphabets(event,this);" value="${memberInstance?.fullName}"/>
                    </div>
                    <div class="field">

                        <h3 class="ui dividing header">User Id <span class="required-indicator">*</span> </h3>

                        <g:textField name="userId" required="" id="userId" onkeypress="return onlyNumbers(event,this);" value="${memberInstance?.userId}"/>

                    </div>
                </div>
            </div>
            <p></p>
    </div>


    <div class="column">
        <div class="ui raised segment">
            <a class="ui blue ribbon label">Limit</a>
                <br><br>
                <div class="two fields">

                    <div class="field">
                        <h3 class="ui dividing header">Full Name <span class="required-indicator">*</span> </h3>
                        <g:textField name="fullName" id="fullName" required="" onkeypress="return onlyAlphabets(event,this);" value="${memberInstance?.fullName}"/>
                    </div>
                    <div class="field">

                        <h3 class="ui dividing header">User Id <span class="required-indicator">*</span> </h3>

                        <g:textField name="userId" required="" id="userId" onkeypress="return onlyNumbers(event,this);" value="${memberInstance?.userId}"/>

                    </div>
                </div>
            <p></p>
        </div>
    </div>


    </div>
    </div>
</body>
</html>