
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <link href="${resource(dir: "css",file: "jquery-ui.css")}" rel="stylesheet">
    <script type="text/javascript" src="${resource(dir: "js",file: "jquery-2.1.4.min.js")}"></script>
    %{--<script type="text/javascript" src="${resource(dir: "js",file: "jquery-ui.js")}"></script>--}%
    <r:require module="jquery"/>
    <r:require module="jquery-ui"/>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#issue").hide();
            $.ajax({
                type: "GET",
                url: "${createLink(controller:"book",action:"getAllUsers")}",
                success : function(response) {

                    $("#fullName").autocomplete({
                        source: response
                    });

                }

            });

        });


        function checkValid(id) {
            if(isNaN(id)) {
                $('#bookId').focus(function(){
                    $(this).val('');
                });
                alert("Invalid book number.");
            }else if(!(/^\d*$/.test(id))){
                $('#bookId').focus(function(){
                    $(this).val('');
                });
                alert("Invalid book number.");

            }else if(id.length>4){
                $("#bookId").val('');
                alert("Invalid book number.");

            }

            $.ajax({
                url:"${createLink(controller: "book",action: "checkValidBookType")}",
                type:"post",
                data:'bookId='+id,
                success:function(result){
                    if(result=='gifted'){
                        alert("Gifted book cannot be issued.");
                    }else if(result=='reference') {
                        alert("Reference book cannot be issued.");
                    }else if(result=='bought') {
                        $("#issue").show();
                    }
                }
            })

            }

        function issue() {
            var bookNumber=$("#bookNumber").val();
            var memberName=$("#fullName").val();
                $.ajax({
                    url:"${createLink(controller:"book" ,action:"saveIssue" )}",
                    data:"bookNumber="+bookNumber+"&memberName="+memberName,
                    type:'post',
                    success: function (result) {
                        console.log(result);
                        if(result=="greaterborrowcount"){
                            alert("You have already borrowed three books");
                        }else if(result=="issue") {
                            alert("Book issued");
                        }else if(result=="error") {
                            $("#bookNumber").val("");
                            $("#fullName").val("");
                            alert("This book is already borrowed.");
                        }
                    }
                })

        }





    </script>
</head>

<body>
Book Id: <input type="text" name="bookNumber" id="bookNumber" placeholder="Book Id" onkeyup="checkValid(this.value);"/><br/>
Member name: <input type="text" name="fullName" id="fullName" placeholder="Member Name"/><br/>
<input type="submit" value="Issue" id="issue" onclick="issue();"/>

<r:layoutResources/>
</body>
</html>
