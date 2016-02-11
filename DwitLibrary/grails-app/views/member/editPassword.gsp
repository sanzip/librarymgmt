<%@ page import="np.edu.dwit.Member" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_page">
    <g:set var="entityName" value="${message(code: 'member.label', default: 'Member')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
    <style>

    form{
        text-align: left !important;
    }
    fieldset{
        margin:0px auto;
        width:50%;
        background-color: rgba(53, 115, 163, 0.03);
        border-radius: 2px;
    }
    #head{
        text-align: center;
    }
    </style>
    <script>

        function validateEmail(){
            var pat=/(@deerwalk.edu.np)$/;
            var email = document.getElementById("email").value;
            if(!pat.test(email)){
                alert("Email must have \"@deerwalk.edu.np\" top level domain");
                return false;
            }
        }
    </script>
</head>

<body>

<div id="edit-member" class="content scaffold-edit" role="main">
    %{--<g:if test="${flash.message}">--}%
        %{--<div class="message" role="status">${flash.message}</div>--}%
    %{--</g:if>--}%
%{-- <g:hasErrors bean="${memberInstance}">
     <ul class="errors" role="alert">
         <g:eachError bean="${memberInstance}" var="error">
             <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                     error="${error}"/></li>
         </g:eachError>
     </ul>
 </g:hasErrors>
--}%
    <g:form method="PUT">
        <br>
        <fieldset class="form">
            <div class="ui form" style="margin: 0px auto;width:90%;">
                <br>

                <div class="field">

                    <h3 class="ui dividing header">Current Password <span class="required-indicator">*</span> </h3>

                    <g:passwordField name="password" required=""/>

                </div>

                <div class="field">

                    <h3 class="ui dividing header">New Password <span class="required-indicator">*</span> </h3>

                    <g:passwordField name="npassword" required=""/>

                </div>

                <div class="field">

                    <h3 class="ui dividing header">Confirm New Password <span class="required-indicator">*</span> </h3>

                    <g:passwordField name="rpassword" required=""/>

                </div>

            </div>
            <br>
            <g:actionSubmit class="ui blue button" action="updatePassword"
                            value="${message(code: 'default.button.update.label', default: 'Update')}"/>
        </fieldset>

    </g:form>
</div>
</body>
</html>
