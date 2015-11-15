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
        $('#asim').hide();
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
                <td style="text-align: center">
                  <a class="ui white tag label" href="#" onclick = "select(${book.id});" style="color: black;background-color:rgb(217, 217, 217)">${fieldValue(bean: book, field: "name")}</a>
        </td>
%{--
                <td  --}%
%{--onmouseover="highlightTr(this);" onmouseout="removeHighlight(this);"--}%%{--
 id = "${"row" + i}" style="text-align: center;" class = "availableRow"><a href="#" onclick = "select(${book.id});" style="color: black;"><strong>${fieldValue(bean: book, field: "name")}</strong></a></td>
--}%
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
