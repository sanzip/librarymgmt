<html>
<head>
    <style>
    #overlay_form{
        position: absolute;
        border: 2px solid gray;
        padding: 10px;
        background: white;
        width: 370px;
        height: 290px;
    }
    #pop{
        display: block;
        width: 75px;
        text-align: center;
        padding: 2px;
        text-decoration: none;
        margin: 0 auto;
    }
    .ui.segment{
        margin: 0px ;
    }
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#issue").hide();
            $("#fullNameReturn").hide();
            $("#reset").hide();

            $("#bookNo").on("contextmenu",function(){
                return false;
            });

            $("#fullNameReturn").on("contextmenu",function(){
                return false;
            });


            $.ajax({
                type: "GET",
                url: "${createLink(controller:"book",action:"getAllUsers")}",
                success : function(response) {

                    $("#fullNameReturn").autocomplete({
                        source: response,
                        select: function(event, ui) {
                            if (ui.item) {
                                $("#fullNameReturn").prop("readonly", true);
                                $("#issue").show();

                                alert("Member selected: "+ui.item.value);
                            }
                        }
                    });

                }


            });

        });



        function checkValid(bookNumber) {
            if(isNaN(bookNumber)) {
                $('#bookNo').focus(function(){
                    $(this).val('');
                });
                var n = noty({
                    layout: 'topRight',
                    theme: 'relax',
                    type: 'error',
                    text: 'Invalid book number.',
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing', // easing
                        speed: 500
                    },
                    timeout: 1000
                });
                n.animate();
            }else if(!(/^\d*$/.test(bookNumber))){
                $('#bookNo').focus(function(){
                    $(this).val('');
                });
                var n = noty({
                    layout: 'topRight',
                    theme: 'relax',
                    type: 'error',
                    text: 'Only numbers are accepted',
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing', // easing
                        speed: 500
                    },
                    timeout: 1000
                });
                n.animate();

            }else if(bookNumber.length>4){
                $("#bookNo").val('');
                var n = noty({
                    layout: 'topRight',
                    theme: 'relax',
                    type: 'error',
                    text: 'Length of book number is invalid',
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing', // easing
                        speed: 500
                    },
                    timeout: 1000
                });
                n.animate();
            }
        }

        function issue() {
            var bookNumber=$("#bookNo").val();
            var memberName=$("#fullName").val();

            $.ajax({
                url:"${createLink(controller:"book" ,action:"saveIssue" )}",
                data:"bookNumber="+bookNumber+"&memberName="+memberName,
                type:'post',
                success: function (result) {
                    console.log(result);
                    if(result=="greaterborrowcount"){
                        var n = noty({
                            layout: 'topRight',
                            theme: 'relax',
                            type: 'error',
                            text: 'You have already borrowed three books',
                            animation: {
                                open: {height: 'toggle'},
                                close: {height: 'toggle'},
                                easing: 'swing', // easing
                                speed: 500
                            },
                            timeout: 10000
                        });
                        n.animate();
                    }else if(result=="issue") {
                        $("#fullName").hide();
                        $("#issue").hide();
                        var n = noty({
                            layout: 'topRight',
                            theme: 'relax',
                            type: 'error',
                            text: 'Book Issued',
                            animation: {
                                open: {height: 'toggle'},
                                close: {height: 'toggle'},
                                easing: 'swing', // easing
                                speed: 500
                            },
                            timeout: 10000
                        });
                        n.animate();
                    }else if(result=="error") {
                        $("#bookNo").val("");
                        $("#fullName").val("");
                        $("#fullName").hide();
                        $("#issue").hide();
                        var n = noty({
                            layout: 'topRight',
                            theme: 'relax',
                            type: 'error',
                            text: 'This book is already borrowed.',
                            animation: {
                                open: {height: 'toggle'},
                                close: {height: 'toggle'},
                                easing: 'swing', // easing
                                speed: 500
                            },
                            timeout: 10000
                        });
                        n.animate();
                    }
                }
            })


        }

        function reset() {
            $("#bookNo").val("");
            $("#fullNameReturn").val("");
            $("#fullNameReturn").hide();
            $("#issue").hide();
            $("#fullName").prop("readonly", false);

        }


        $(function() {
            $('#return').hide();
            $("#reset").hide();

            $("#bookNo").on("contextmenu",function(){
                return false;
            });
        });

        function checkValidBookNumber(id) {

            if (isNaN(id)) {
                $('#bookNo').focus(function () {
                    $(this).val('');
                });
                var n = noty({
                    layout: 'topRight',
                    theme: 'relax',
                    type: 'error',
                    text: 'Invalid book number.',
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing', // easing
                        speed: 500
                    },
                    timeout: 1000
                });
                n.animate();
            } else if (!(/^\d*$/.test(id))) {
                $('#returnBookNum').focus(function () {
                    $(this).val('');
                });
                var n = noty({
                    layout: 'topRight',
                    theme: 'relax',
                    type: 'error',
                    text: 'Only numbers are accepted',
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing', // easing
                        speed: 500
                    },
                    timeout: 1000
                });
                n.animate();
            } else if (id.length > 4) {
                $("#bookNo").val('');
                var n = noty({
                    layout: 'topRight',
                    theme: 'relax',
                    type: 'error',
                    text: 'Length of book number is invalid',
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing', // easing
                        speed: 500
                    },
                    timeout: 1000
                });
                n.animate();
            }
            var bookNumber = id;

            $.ajax({

                url: "<g:createLink controller="book" action="checkBorrowedMember"/>",
                data: 'bookNumber=' + bookNumber,
                type: "POST",
                success: function (result) {
                    console.log(result);
                    if(result=="error") {
                        $("#fullNameReturn").val('');
                        $("#fine").val('');
                        $("#totalFineDays").val('');
                        $("#totalKeptDays").val('');

                    }else {
                        var res = result.split(":");
                        if(res.length==4) {
                            $("#returnFinediv").show();
                            $("#fullNameReturn").val(res[0]);
                            $("#fine").val(res[1]);
                            $("#totalFineDays").val(res[2]);
                            $("#totalKeptDays").val(res[3]);

                        }else {
                            $("#fullNameReturn").val(res[0]);
                            $("#fine").val(res[1]);
                            $("#returnFinediv").hide();
                            $("#totalKeptDays").val(res[2]);
                        }

                    }

                }
            })

        }

        function saveReturn() {
            var bookNumber=$("#returnBookNum").val();
            var memberName=$("#fullNameReturn").val();
            var totalKeptDays=$("#totalKeptDays").val();
            var totalFineDays=$("#totalFineDays").val();
            var totalFineAmount=$("#fine").val();
            var parameter;
            if(totalFineDays.empty()) {
                parameter='bookNumber='+bookNumber+'&memberName='+memberName+'&totalKeptdays='+totalKeptDays+'&totalFineDays='+totalFineDays+'&fine='+totalFineAmount;
            }else {
                parameter='bookNumber='+bookNumber+'&memberName='+memberName+'&totalKeptdays='+totalKeptDays+'&fine='+totalFineAmount
            }

            $.ajax({
                url:"${createLink(controller: "book",action: "saveReturn")}",
                type:'post',
                data:parameter,
                success: function(result) {
                        reset();
                        $("#asim").close();

                        alert("Book returned.")
                }
            })
        }

        function changeFine() {
            var days = $("#totalFineDays").val();
            var memberName= $("#fullNameReturn").val();
            var bookNumber = $("#returnBookNum").val();

            if(days.length>3) {
                $('#totalFineDays').focus(function () {
                    $(this).val('');
                });
                var n = noty({
                    layout: 'topRight',
                    theme: 'relax',
                    type: 'error',
                    text: 'Fine days will be not be greater than 3 digit',
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing', // easing
                        speed: 500
                    },
                    timeout: 1000
                });
                n.animate();
            }else if(isNaN(days)) {
                $('#totalFineDays').focus(function () {
                    $(this).val('');
                });
                $("#fine").val('');

                var n = noty({
                    layout: 'topRight',
                    theme: 'relax',
                    type: 'error',
                    text: 'Invalid fine days',
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing', // easing
                        speed: 500
                    },
                    timeout: 1000
                });
                n.animate();
            }else if(!(/^\d*$/.test(days))) {
                $('#totalFineDays').focus(function () {
                    $(this).val('');
                });
                $("#fine").val('');
                $('#return').attr("disabled","disabled");

                var n = noty({
                    layout: 'topRight',
                    theme: 'relax',
                    type: 'error',
                    text: 'Invalid fine days',
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing', // easing
                        speed: 500
                    },
                    timeout: 1000
                });
                n.animate();
            }else {
                $.ajax({
                    url:"${createLink(controller: "book",action: "recalculateFine")}",
                    data:'days='+days+'&memberName='+memberName+'&bookNumber='+bookNumber,
                    type:'post',
                    success: function (result) {
                        console.log(result);
                        var res = result.split(":");
                        if(res.length==4){
                            $("#returnFinediv").show();
                            $("#fullNameReturn").val(res[0]);
                            $("#fine").val(res[1]);
                            $("#totalFineDays").val(res[2]);
                            $("#totalKeptDays").val(res[3]);
                        }else {
                            $("#fullNameReturn").val(res[0]);
                            $("#fine").val(res[1]);
                            $("#totalFineDays").hide();
                            $("#totalKeptDays").val(res[2]);
                        }






                    }

                })
            }

        }

        function resetclick() {
            $("#returnBookNum").val("");
            $("#fullNameReturn").val("");
            $("#totalKeptDays").val("");
            $("#totalFineDays").val("");
            $("#totalFineDays").removeAttr("disabled","disabled");
            $("#fine").val("");
        }
    </script>
    <script type="text/javascript">

        $(document).ready(function(){
//open popup
            $("#pop").click(function(){
                $("#overlay_form").fadeIn(1000);
                positionPopup();
            });

//close popup
            $("#close").click(function(){
                $("#overlay_form").fadeOut(500);
            });
        });

        //position the popup at the center of the page
        function positionPopup(){
            if(!$("#overlay_form").is(':visible')){
                return;
            }
            $("#overlay_form").css({
                left: ($(window).width() - $('#overlay_form').width()) / 2,
                top: ($(window).width() - $('#overlay_form').width()) / 7,
                position:'absolute'
            });
        }

        //maintain the popup at center of the page when browser resized
        $(window).bind('resize',positionPopup);

        function issueBookNav(){

            $.ajax({
                url:"${createLink(controller:"book" ,action:"issueBookNav" )}",
                data:"",
                type:'post',
                success: function (result) {
                    $("#issueBook").html(result);
                    $('#mo').show();
                    $('#asim').hide();
                }
            })
        }
        function returnBookNav(){
            $.ajax({
                url:"${createLink(controller:"book" ,action:"returnBookNav" )}",
                data:"",
                type:'post',
                success: function (result) {
                    console.log(result);
                    $("#returnBook").html(result);
                    $('#asim').show();
                    $('#mo').hide();
                }
            })
        }
        $(function(){

            $("#cancel").on('click', function(){

                $('#mo').hide();
            });
            $("#cancelReturn").on('click', function(){

                $('#asim').hide();
            });
            <g:if test="${flash.message}">
                var n = noty({
                    layout: 'topRight',
                    theme: 'relax',
                    type: '${params.messageType}',
                    text: '${flash.message}',
                    animation: {
                        open: {height: 'toggle'},
                        close: {height: 'toggle'},
                        easing: 'swing', // easing
                        speed: 500
                    },
                    timeout: 10000
                });
                n.animate();
            </g:if>
        });
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
                    console.log(states);
                },
                error:function(html){

                    console.log(html);
                }
            });
        }
        function onlyUnique(value, index, self) {
            return self.indexOf(value) === index;
        }
    </script>
</head>
<body>
<form id="overlay_form" style="display:none">
    <h2> Issue Book  </h2>     <a href="#" id="close" >Close</a>
    <input type="text" name="bookNumber" id="bookNo" placeholder="Book Number" onkeyup="checkValid(this.value);" required="required"/><br/>
    <input type="text" name="fullName" id="fullName" placeholder="Member Name" /><br/>
    <input type="submit" value="Issue" id="issue" onclick="issue();"/>
    <input type="submit" value="Reset" id="reset" onclick="resetclick();"/>
</form>
<div class="ui center aligned segment" style="background-color: #3573A3;">
    <g:link controller="member" action="dashboard"> <img style="float: left; height: 95px;width: 150px" src="${resource(dir: 'images', file: 'logo.png')}" alt="Logo" />
    <h1 style="color:white;float:left; margin-left: 185px"><b style="font-size: 70px;">Gyan Sangalo</b></h1></g:link>
    <div style="float:right;color: white; font-style: oblique; font-size: 20px; margin-top: 10px;" class="item">
        <sec:ifLoggedIn>
            <div class="ui simple dropdown link item">
                Welcome ${session["userName"]}<i class="dropdown icon"></i>
                <div class="menu" style="border-radius: 5px;border: none;">
                    <g:link controller="member" action="editPassword" class="item" style="color:white;background-color:#3573A3">Change Password</g:link>
                    <g:link controller="logout" class="item" style="color:white;background-color:#3573A3">Logout</g:link>
                    %{--<form name="logout" method="POST" style="color: #E7746F" class="item" action="${createLink(controller:'logout') }">--}%
                        %{--<em>--}%
                            %{--<input type="submit" class="ui button" value="Logout" style="background-color: #fff;">--}%
                        %{--</em>--}%
                    %{--</form>--}%
                </div>
            </div>

        </sec:ifLoggedIn>
    </div>
</div>
<br>
<div class="ui five item menu" style="margin: 0px auto;width: 98%;">
    <div class="ui large menu">
        <sec:ifNotGranted roles="ROLE_LIBRARIAN">
            <div class="ui simple link item">
                <g:link controller="member" action="history"><i class="history icon"></i> History</g:link>
            </div>
        </sec:ifNotGranted>



        <sec:ifAllGranted roles="ROLE_LIBRARIAN">
            <div class="ui simple link item" onclick = "issueBookNav();">
               <i class="barcode icon"> </i>Issue
            </div>
            <div class="ui simple link item" onclick = "returnBookNav();">
                <i class="reply icon"></i> Return
            </div>
            <div class="ui simple dropdown link item">
                <i class="browser icon"></i> Report <i class="dropdown icon"></i>
                <div class="menu">
                    <g:link controller="book" action="report" class="item"> <i class="browser icon"></i>  Issued Book  </g:link>
                    <g:link controller="fine" action="report" class="item"> <i class="browser icon"></i>  Fine Report </g:link>
                </div>
            </div>
            <div class="ui simple dropdown link item">
                <i class="circle icon"></i> Log <i class="dropdown icon"></i>
                <div class="menu">
                    <g:link controller="log" action="viewIssues" class="item"> <i class="circle thin icon "></i>   View Issues  </g:link>
                    <g:link controller="log" action="viewReturns" class="item"> <i class="circle thin icon"></i>  View Returns  </g:link>
                </div>
            </div>
            <div class="ui simple dropdown link item">
                <i class="configure icon"></i> Configure <i class="dropdown icon"></i>
                <div class="menu">
                    %{--<g:link controller="member" action="configDetails" class="item"> <i class="user icon"></i>   Fine  </g:link>--}%
                    <g:link controller="member" action="list" class="item"> <i class="user icon"></i>   User  </g:link>
                    <g:link controller="book" action="index" class="item"> <i class="book icon"></i>  Book  </g:link>
                </div>
            </div>
        </sec:ifAllGranted>
    </div>
</div>
<div class="ui small modal" id = "mo" style="position: absolute;top: 18%;left: 50%;">
    <div class="header" id = "issueBookHeader">Issue Book</div>
    <form action="<g:createLink controller="book" action="saveIssue"/>" method="POST">
        <div class="content" style="text-align: left; padding: 30px;">
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
                <input type="hidden" value="${controllerName}" name="currentController"/>
                <input type="hidden" value="${actionName}" name="currentAction"/>
            </div>
        </div>
    </form>
</div>
<div class="ui small modal" id = "asim" style="position: absolute;top: 10%;left: 50%;">
    <div class="header" id = "returnBookHeader">Return Book</div>
    <form action="<g:createLink controller="book" action="saveReturn"/>" method="POST">
        <div class="content" style="text-align: left; padding: 30px;" id = "returnBook">
        </div>
        <div class = "actions" style="text-align: right;">
            <div class="ui buttons">
                <div class="ui negative button" id = "cancelReturn">Cancel</div>
                <div class="or"></div>
                <input type="submit" class="ui positive button" value="Return"/>
                <input type="hidden" value="${controllerName}" name="currentController"/>
                <input type="hidden" value="${actionName}" name="currentAction"/>
            </div>
        </div>
    </form>
</div>

</body>
</html>