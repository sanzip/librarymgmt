<%@ page import="np.edu.dwit.Book" %>



<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'name', 'error')} required">
    <label for="name">
        <g:message code="book.name.label" default="Name"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" required="" value="${bookInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'author', 'error')} required">
    <label for="author">
        <g:message code="book.author.label" default="Author"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="author" required="" value="${bookInstance?.author}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'bookNumber', 'error')} required">
    <label for="bookNumber">
        <g:message code="book.bookNumber.label" default="Book Number"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="bookNumber" type="number" value="${bookInstance.bookNumber}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'availableQuantity', 'error')} required">
    <label for="availableQuantity">
        <g:message code="book.availableQuantity.label" default="Available Quantity"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="availableQuantity" type="number" value="${bookInstance.availableQuantity}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'totalQuantity', 'error')} required">
    <label for="totalQuantity">
        <g:message code="book.totalQuantity.label" default="Total Quantity"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="totalQuantity" type="number" value="${bookInstance.totalQuantity}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'bookType', 'error')} required">
    <label for="bookType">
        <g:message code="book.bookType.label" default="Book Type"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select name="bookType" from="${bookInstance.constraints.bookType.inList}" required=""
              value="${bookInstance?.bookType}" valueMessagePrefix="book.bookType"/>
</div>

