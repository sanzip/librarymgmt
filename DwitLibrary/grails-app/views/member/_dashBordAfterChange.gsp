<table class="ui celled table">
    <thead>
    <tr>
        <th>S.No</th>
        <th>Name</th>
        <th>Author</th>
        <sec:ifAllGranted roles="ROLE_LIBRARIAN">
            <th>Total Quantity</th>
        </sec:ifAllGranted>
        <th>Available Quantity</th>
        <sec:ifAllGranted roles="ROLE_LIBRARIAN">
            <th>Issue</th>
        </sec:ifAllGranted>
    </tr>
    </thead>
    <tbody>
    <g:each in="${list}" var="booklist" status="i">
        <tr>
            <td>${i+1}</td>
            <td>${booklist.name}</td>
            <td>${booklist.author}</td>
            <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                <td>${booklist.totalQuantity}</td>
            </sec:ifAllGranted>
            <td>${booklist.availableQuantity}</td>
            <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                <td><g:link controller="book" action="issueBook" params="[bookId: booklist.id]">Issue</g:link></td>
            </sec:ifAllGranted>
        </tr>
    </g:each>
    </tbody>
</table>

