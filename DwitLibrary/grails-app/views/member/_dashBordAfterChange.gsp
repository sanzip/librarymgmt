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
    var max = 7;
    function pop(input){

        var data = "query=" + $("#username").val() + "&states=" + states;
        jQuery.ajax({
            type: 'post',
            data: data,
            url: '<g:createLink controller="member" action="search" />',
            success: function (html) {

                var users = jQuery.parseJSON(html);
                var userFullnames = [];
                states.length = 0;
                for(i = 0; i < users.length; i++){
                    if(users[i].fullName != null) {
                        userFullnames.push(users[i].fullName);
                    }
                }
                var fullNamesUnique = userFullnames.filter(onlyUnique);
                for(i = 0; i < fullNamesUnique.length; i++) {
                    states.push(fullNamesUnique[i]);
                    if(states.length == max)
                        break;
                }
            }
        });
    }
    function onlyUnique(value, index, self) {
        return self.indexOf(value) === index;
    }

    function highlightTr(tag){

        $("#" + tag.id).css("background", "green");
    }

    function removeHighlight(tag){

        $("#" + tag.id).css("background", "");
    }
</script>
<style>
    a{
        color: blue;
    }
    table tbody td{
        background-color: white;
        color: black;
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
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" style="color: #FFFFFF;">
        </g:if>
        <g:else>
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" style="color: #FFFFFF;">
        </g:else>
        <td style="text-align: center">${i+1}.</td>
        <g:if test="${book.availableQuantity > 0}">
            <sec:ifAllGranted roles="ROLE_LIBRARIAN">
               <td style="text-align: center"> <div class="ui buttons">
                    <button class="ui green basic button" id = "${"row" + i}" style="text-align: center;" class = "availableRow"><a href="#" onclick = "select(${book.id});" style="color: black;">${fieldValue(bean: book, field: "name")}</a> </button>
                </div>
</td>
%{--
                <td  --}%
%{--onmouseover="highlightTr(this);" onmouseout="removeHighlight(this);"--}%%{--
 id = "${"row" + i}" style="text-align: center;" class = "availableRow"><a href="#" onclick = "select(${book.id});" style="color: black;"><strong>${fieldValue(bean: book, field: "name")}</strong></a></td>
--}%
            </sec:ifAllGranted>
            <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
                <td  style="text-align: center;"><strong>${fieldValue(bean: book, field: "name")}</strong></td>
            </sec:ifAnyGranted>
        </g:if>
        <g:else>
            <sec:ifAllGranted roles="ROLE_LIBRARIAN">
                <td  style="text-align: center;"><strong>${fieldValue(bean: book, field: "name")}</strong></td>
            </sec:ifAllGranted>
            <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_STUDENT,ROLE_FACULTY">
                <td  style="text-align: center;"><strong>${fieldValue(bean: book, field: "name")}</strong></td>
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
                <label for="username">FullName:</label>
                <input class="typeahead" type="text" onkeyup="pop(this);" id = "username" name="fullName">
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
