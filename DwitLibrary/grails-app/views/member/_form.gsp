<%@ page import="np.edu.dwit.Member; np.edu.dwit.Role" %>
<script language="JavaScript" type="text/javascript">

    function onlyAlphabets(e, t) {
        try {
            if (window.event) {
                var charCode = window.event.keyCode;
            }
            else if (e) {
                var charCode = e.which;
            }
            else { return true; }
            if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || (charCode==32))
                return true;
            else
                alert("Please enter alphabets")
            $("#fullName").val('');
            return false;    function onlyNumbers(e, t) {
        try {
            if (window.event) {
                var intCode = window.event.keyCode;
            }
            else if (e) {
                var intCode = e.which;
            }
            else { return true; }
            if ((intCode >=48   && intCode <= 57)){
                return true;
            }

            else{

                alert("Please Enter Numeric Character");
                $("#userId").val('');
                return false;

            }

        }
        catch (err) {
            alert(err.Description);
        }
    }

        }
        catch (err) {
            alert(err.Description);
        }
    }

    function onlyNumbers(e, t) {
        try {
            if (window.event) {
                var intCode = window.event.keyCode;
            }
            else if (e) {
                var intCode = e.which;
            }
            else { return true; }
            if ((intCode >=48   && intCode <= 57)){
                return true;
            }

            else{

                alert("Please Enter Numeric Character");
                $("#userId").val('');
                return false;

            }

        }
        catch (err) {
            alert(err.Description);
        }
    }

    function onlyContact(e, t) {
        try {
            if (window.event) {
                var intCode = window.event.keyCode;
            }
            else if (e) {
                var intCode = e.which;
            }
            else { return true; }
            if ((intCode >=48   && intCode <= 57)){
                return true;
            }

            else{

                alert("Please Enter Numeric Character");
                $("#contact").val('');
                return false;

            }

        }
        catch (err) {
            alert(err.Description);
        }
    }

</script>
<sec:ifAllGranted roles="ROLE_LIBRARIAN">

<div class="ui form" style="margin: 0px auto;width:90%;">
<br>
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
    <br>

<div class="two fields">
<div class="field">

    <h3 class="ui dividing header">Password <span class="required-indicator">*</span> </h3>

    <g:passwordField name="password" id = "password" required="" value="${memberInstance?.password}" readonly="readonly"/>

</div>


 <div class="field">
     <h3 class="ui dividing header">Role <span class="required-indicator">*</span> </h3>
     <div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'role', 'error')} required">
         <g:if test="${memberInstance.id}">
             <g:select name="role" from="${Role.all}" class="ui fluid dropdown" required="" value="${memberInstance.getAuthorities()[0]}" valueMessagePrefix="role.authority"/>
         </g:if>
         <g:else>
             <g:select name="role" from="${Role.all}" class="ui fluid dropdown" required=""  noSelection="['':'-Choose Role-']" valueMessagePrefix="role.authority"/>
         </g:else>
    </div>
 </div>


</div>

<br>
<div class="two fields">
<div class="field">
    <h3 class="ui dividing header">Email <span class="required-indicator">*</span> </h3>
    <g:textField name="email" id="email" value="${memberInstance?.email}"/>
</div>
<div class="field">
    <h3 class="ui dividing header">Contact <span class="required-indicator">*</span> </h3>

    <g:textField name="contact" id="contact" onkeypress="return onlyContact(event,this);" value="${memberInstance?.contact}"/>
</div>
</div>
%{--<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'status', 'error')} ">--}%
%{--    <label for="status">--}%
%{--        <g:message code="member.status.label" default="Status"/>--}%
%{--
--}%

%{--    </label>--}%
%{--    <g:textField name="status" value="${memberInstance?.status}"/>--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'accountExpired', 'error')} ">--}%
%{--    <label for="accountExpired">--}%
%{--        <g:message code="member.accountExpired.label" default="Account Expired"/>--}%
%{--
--}%

%{--    </label>--}%
%{--    <g:checkBox name="accountExpired" value="${memberInstance?.accountExpired}"/>--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'accountLocked', 'error')} ">--}%
%{--    <label for="accountLocked">--}%
%{--        <g:message code="member.accountLocked.label" default="Account Locked"/>--}%
%{--
--}%

%{--    </label>--}%
%{--    <g:checkBox name="accountLocked" value="${memberInstance?.accountLocked}"/>--}%
%{--</div>--}%
<br>
<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'enabled', 'error')} ">
    <h3 class="ui dividing header">Enabled <span class="required-indicator">*</span>
    <g:checkBox name="enabled" value="${memberInstance?.enabled}"/>
    </h3>
</div>
</div>
%{--<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'passwordExpired', 'error')} ">--}%
%{--    <label for="passwordExpired">--}%
%{--        <g:message code="member.passwordExpired.label" default="Password Expired"/>--}%
%{--
--}%

%{--    </label>--}%
%{--    <g:checkBox name="passwordExpired" value="${memberInstance?.passwordExpired}"/>--}%
%{--</div>--}%
</sec:ifAllGranted>

<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
    <div class="ui form" style="margin: 0px auto;width:90%;">
<br>

        <div class="field">

            <h3 class="ui dividing header">New Password <span class="required-indicator">*</span> </h3>

            <g:passwordField name="password" required=""/>

        </div>

        <div class="field">

            <h3 class="ui dividing header">Re-type Password <span class="required-indicator">*</span> </h3>

            <g:passwordField name="rpassword" required=""/>

        </div>

    </div>
</sec:ifAnyGranted>
