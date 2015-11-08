<table class="ui sortable celled table" style="margin: 0px auto;width: 95%">
    <thead>
    <tr>
        <th style="text-align: center;color: #E7746F">S.No</th>
        <g:sortableColumn style="text-align: center;" property="name" title="${message(code: 'book.name.label', default: 'Book Name')}" />
        <g:sortableColumn style="text-align: center;" property="author" title="${message(code: 'book.author.label', default: 'Author')}" />
        <sec:ifAllGranted roles="ROLE_LIBRARIAN">
            <g:sortableColumn style="text-align: center;" property="totalQuantity" title="${message(code: 'book.totalQuantity.label', default: 'Total Quantity')}" />
        </sec:ifAllGranted>
        <g:sortableColumn style="text-align: center;" property="availableQuantity" title="${message(code: 'book.availableQuantity.label', default: 'Available Quantity')}" />
    </tr>
    </thead>

    <tbody style="text-align: center;">
    <g:each in="${list}" status="i" var="booklist">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
            <td  style="text-align: center;">${fieldValue(bean: booklist, field: "id")}</td>
            <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                <td  style="text-align: center;"><g:link controller="book" action="show" id="${booklist.id}">${fieldValue(bean: booklist, field: "name")}</g:link></td>
            </sec:ifAllGranted>
            <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
                <td  style="text-align: center;">${fieldValue(bean: booklist, field: "name")}</td>
            </sec:ifAnyGranted>
            <td  style="text-align: center;">${fieldValue(bean: booklist, field: "author")}</td>
            <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                <td  style="text-align: center;">${fieldValue(bean: booklist, field: "totalQuantity")}</td>
            </sec:ifAllGranted>
            <td  style="text-align: center;">${fieldValue(bean: booklist, field: "availableQuantity")}</td>

        </tr>
    </g:each>
    </tbody>
</table>
<br>
<div id="space">
    <g:paginate total="$list ?: 0}" />
</div>

