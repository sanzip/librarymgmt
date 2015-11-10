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
<style>
    a{
        color: blue;
    }
</style>
<table id="first_table" class="ui sortable celled table" cellspacing="0" width="100% margin: 0px">
    <thead>
    <tr>
        <th>S.No</th>
        <th>Name</th>
        <th>Author</th>
        <sec:ifAllGranted roles="ROLE_LIBRARIAN">
            <th>Total Quantity</th>
        </sec:ifAllGranted>
        <th>Available Quantity</th>
    </tr>
    </thead>
    <tbody>
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
                <td  style="text-align: center;"><a href="#" onclick = "select(${book.id});">${fieldValue(bean: book, field: "name")}</a></td>
            </sec:ifAllGranted>
            <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
                <td  style="text-align: center;">${fieldValue(bean: book, field: "name")}</td>
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
    <form action="<g:createLink controller="book" action="saveIssue"/>" method="POST">
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
<script>
    function setValue(){
        $("#bookName").val('');
        $("#authorName").val('');
    }
    $(document).ready(function(){
        setValue();
        var table = $('#first_table').DataTable();

        $('#bookName').on( 'keyup', function () {
            table
                    .columns( 1 )
                    .search( this.value )
                    .draw();
        } );
        $('#authorName').on( 'keyup', function () {
            table
                    .columns( 2 )
                    .search( this.value )
                    .draw();
        } );
    })
</script>
