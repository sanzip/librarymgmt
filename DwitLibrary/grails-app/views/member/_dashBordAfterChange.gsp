<script type="text/javascript">
        function select(id){

            var data = "bookId=" + id;
            $('#issueBook').html("");
            jQuery.ajax({
                type: 'post',
                data: data,
                url: '<g:createLink controller="book" action="bookInfoList" />',
                success: function (html) {
                    $("#issueBook").html(html);
                }
            });
            $('#mo').show();
        }

        var states = [];
        function pop(input){

            var data = "query=" + $("#username").val() + "&states=" + states;
            jQuery.ajax({
                type: 'post',
                data: data,
                url: '<g:createLink controller="member" action="search" />',
                success: function (html) {

                    var users = jQuery.parseJSON(html);
                    for(i = 0; i < users.length; i++){
                        if(users[i].username != null) {
                            states.push(users[i].username);
                        }
                    }
                }
            });
        }
</script>
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
            <g:each in="${list}" var="book" status="i">
                <g:if test="${book.availableQuantity > 0}">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" style="background-color: #1aa62a; color: #FFFFFF;">
                </g:if>
                <g:else>
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" style="background-color: #843534; color: #FFFFFF;">
                </g:else>
                    <td>${i+1}.</td>
                    <g:if test="${book.availableQuantity > 0}">
                        <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                            <td  style="text-align: center;"><button onclick="select(${book.id});">${fieldValue(bean: book, field: "name")}</button></td>
                        </sec:ifAllGranted>
                        <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
                            <td  style="text-align: center;"><button onclick="select(${book.id});">${fieldValue(bean: book, field: "name")}</button></td>
                        </sec:ifAnyGranted>
                    </g:if>
                    <g:else>
                        <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                            <td  style="text-align: center;">${fieldValue(bean: book, field: "name")}</td>
                        </sec:ifAllGranted>
                        <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
                            <td  style="text-align: center;">${fieldValue(bean: book, field: "name")}</td>
                        </sec:ifAnyGranted>
                    </g:else>
                    <td  style="text-align: center;">${fieldValue(bean: book, field: "author")}</td>
                    <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                        <td  style="text-align: center;">${fieldValue(bean: book, field: "totalQuantity")}</td>
                    </sec:ifAllGranted>
                    <td  style="text-align: center;">${fieldValue(bean: book, field: "availableQuantity")}</td>
                </tr>
            </g:each>
        </tbody>
</table>
<div class="ui small modal" id = "mo" style="position: absolute;top: 18%;left: 50%;">
    <div class="header" id = "issueBookHeader">Issue Book</div>
    <form action="<g:createLink controller="book" action="issue"/>" method="POST">
        <div class="content" style="text-align: left; padding: 50px;">
            <div id = "issueBook">

            </div>
            <div id="the-basics">
                <label for="username">Username:</label>
                <input class="typeahead" type="text" onkeyup="pop(this);" id = "username" name="username">
            </div>
        </div>
        <div class = "actions" style="text-align: right;">
            <div class="ui buttons">
                <div class="ui negative button" id = "cancel">Cancel</div>
                <div class="or"></div>
                <input type="submit" class="ui positive button" value="Issue"/>
            </div>
        </div>
    </form>
</div>
<br>
<div id="space">
    <g:paginate total="$list ?: 0}" />
</div>

