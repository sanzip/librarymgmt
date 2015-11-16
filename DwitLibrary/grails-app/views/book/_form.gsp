<%@ page import="np.edu.dwit.Book" %>



<div class="ui form" style="margin: 0px auto;width:90%;">
    <br>
	<div class="field">
		<h3 class="ui dividing header">Name <span class="required-indicator">*</span> </h3>
		<g:textField name="name" required="" value="${bookInstance?.name}"/>
	</div>

	<div class="field">
		<h3 class="ui dividing header">Author <span class="required-indicator">*</span> </h3>

		<g:textField name="author" required="" value="${bookInstance?.author}"/>
	</div>
	<div class="field">
		<h3 class="ui dividing header">Publication <span class="required-indicator">*</span> </h3>
		<g:textField name="publication" required="" value="${bookInstance?.publication}"/>
	</div>
</div>
