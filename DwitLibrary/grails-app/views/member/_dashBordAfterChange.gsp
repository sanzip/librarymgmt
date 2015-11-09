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
        <sec:ifAllGranted roles="ROLE_LIBRARIAN">
            <th>Issue</th>
        </sec:ifAllGranted>
    </tr>
    </thead>
    <tbody>
    <g:each in="${list}" var="booklist" status="i">
        <tr>
            <td>${i+1}.</td>
            <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                <td  style="text-align: center;"><button id = "bookRow" onclick="selectBook(${booklist.id});">${fieldValue(bean: booklist, field: "name")}</button></td>
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
