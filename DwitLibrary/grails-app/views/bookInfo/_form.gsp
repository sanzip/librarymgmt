<%@ page import="np.edu.dwit.BookInfo" %>
<div class="ui form" style="margin: 0px auto;width:90%;">
    <br>
    <h2 style="text-align: center;font-family:Open Sans Helvetica Neue Helvetica, Arial sans-serif">New Book Info</h2>
<div class="three fields">
    <div class="field">
    <h3 class="ui dividing header">Book <span class="required-indicator">*</span> </h3>

<g:javascript>

	function duplicateAdd(){
        $('#bookNumberInput').append('<input type="text" name="bookNumber" required="" value="${bookInfoInstance?.bookNumber}"/>');
        $('#bookNumberInput .addbutton').remove();
		$('#bookNumberInput').append('<button type="button" class = "addbutton" onclick="duplicateAdd();">Add</button>');
	}

</g:javascript>

<div class="fieldcontain ${hasErrors(bean: bookInfoInstance, field: 'book', 'error')} required">
	<label for="book">
		<g:message code="bookInfo.book.label" default="Book" />
		<span class="required-indicator">*</span>
	</label>

	<g:textField id="book" name="book.id" readonly="" required="" value="${params.id}" class="many-to-one"/>
</div>
    <div class="field">
        <h3 class="ui dividing header">Book Number <span class="required-indicator">*</span> </h3>

<div class="fieldcontain ${hasErrors(bean: bookInfoInstance, field: 'bookNumber', 'error')} required">
	<label for="bookNumber">
		<g:message code="bookInfo.bookNumber.label" default="Book Number" />
		<span class="required-indicator">*</span>

	</label>
%{--	<g:textField name="bookNumber" required="" value="${bookInfoInstance?.bookNumber}"/>--}%
	<div id="bookNumberInput" >

	<input type="text" name="bookNumber" required="" value="${bookInfoInstance?.bookNumber}"/>
	<button type="button" class = "addbutton" onclick="duplicateAdd();">Add</button>


</div>
	</div>

    <div class="field">
        <h3 class="ui dividing header">Published Year <span class="required-indicator">*</span> </h3>

        <g:textField name="publishedYear" required="" value="${bookInfoInstance?.publishedYear}"/>
    </div>
</div>

<br>
<div class="two fields">
<div class="field">
    <h3 class="ui dividing header">Edition <span class="required-indicator">*</span> </h3>

    <g:textField name="edition" required="" value="${bookInfoInstance?.edition}"/>
</div>
    <div class="field">
        <h3 class="ui dividing header">Pages <span class="required-indicator">*</span> </h3>

        <g:textField name="pages" required="" value="${bookInfoInstance?.pages}"/>
    </div>

</div>
    <br>

    <div class="two fields">



<div class="field">
    <h3 class="ui dividing header">Cost <span class="required-indicator">*</span> </h3>

    <g:textField type="" name="cost" value="${fieldValue(bean: bookInfoInstance, field: 'cost')}" required=""/>
</div>

<div class="field">
    <h3 class="ui dividing header">Source <span class="required-indicator">*</span> </h3>

    <g:textField name="source" required="" value="${bookInfoInstance?.source}"/>
</div>
    </div>

</div>
