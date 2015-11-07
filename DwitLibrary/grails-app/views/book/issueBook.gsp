<%--
  Created by IntelliJ IDEA.
  User: saneel
  Date: 11/5/15
  Time: 12:11 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <link href="${resource(dir: "css",file: "bootstrap.min.css")}" rel="stylesheet">
    <script type="text/javascript" src="${resource(dir: "js",file: "jquery-2.1.4.min.js")}"></script>

</head>
<script type="text/javascript">

    $(function() {

        $("#searchName").on("keyup", function (e) {
                    var searchresult=$(this).val().trim();
                    var parameter = 'borrowingUsername='+searchresult+'&bookId='+${bookId};
                    $.ajax({
                        url:"${createLink(controller: 'book', action:'beforeIssue')}",
                        data: parameter,
                        type:'post',
                        success: function(result){
                            console.log(result);
                            if(result=="greaterborrowcount"){
                                alert("You have already borrowed three books");
                            }else if(result=="issue") {
                                alert("Book issued");
                            }else if(result=="error") {
                                alert("Username not found");
                            }

                        }
                    })
                }
        )

    });

</script>

<body>
<form method="post" controller="member" action="issueBook">
    <input type="text" name="name" placeholder="member name" id="searchName"/>
</form>
</body>
</html>