<%@ page import="np.edu.dwit.Member" %>



<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'username', 'error')} required">
    <label for="username">
        <g:message code="member.username.label" default="Username"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="username" required="" value="${memberInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'password', 'error')} required">
    <label for="password">
        <g:message code="member.password.label" default="Password"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="password" required="" value="${memberInstance?.password}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'role', 'error')} ">

    <label for="role">
        <g:message code="member.email.label" default="Role"/>

    </label>
    <select>
        <g:each in="${np.edu.dwit.Role.all}" var="roleList">
            <option>${roleList.authority}</option>
        </g:each>
    </select>

</div>

<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'email', 'error')} ">
    <label for="email">
        <g:message code="member.email.label" default="Email"/>

    </label>
    <g:textField name="email" value="${memberInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'contact', 'error')} ">
    <label for="contact">
        <g:message code="member.contact.label" default="Contact"/>

    </label>
    <g:textField name="contact" value="${memberInstance?.contact}"/>
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

<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'enabled', 'error')} ">
    <label for="enabled">
        <g:message code="member.enabled.label" default="Enabled"/>

    </label>
    <g:checkBox name="enabled" value="${memberInstance?.enabled}"/>
</div>

%{--<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'passwordExpired', 'error')} ">--}%
%{--    <label for="passwordExpired">--}%
%{--        <g:message code="member.passwordExpired.label" default="Password Expired"/>--}%
%{--
--}%

%{--    </label>--}%
%{--    <g:checkBox name="passwordExpired" value="${memberInstance?.passwordExpired}"/>--}%
%{--</div>--}%

