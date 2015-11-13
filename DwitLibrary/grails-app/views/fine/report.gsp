<%--
  Created by IntelliJ IDEA.
  User: asimsangram
  Date: 11/11/15
  Time: 1:00 PM
--%>

<%@ page import="np.edu.dwit.Fine" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Fine Report</title>
    <meta name="layout" content="main_page">
    <style>
        .dataTables_filter {
            display: none;
        }
       #wrappers{
             margin: 0px auto;
             width: 95%;
         }
    </style>
    <g:javascript>
        $(function(){
            $("#loading").hide();
        });
        function sendEmail(memberId, memberName, borrowId){

            $('#loadingText').html('Sending email to ' + memberName);
            $('#loading').show();

            var data = "memberId=" + memberId + "&borrowId=" + borrowId;

            jQuery.ajax({
                type: 'post',
                data: data,
                url: '<g:createLink controller="fine" action="sendEmail" />',
                success: function() {
                },
                error: function() {

                  $("#loading").hide();
                  showSuccessAlert();
                }
            });
        }
        function showSuccessAlert(){

            var n = noty({
                layout: 'topRight',
                theme: 'relax',
                type: 'success',
                text: 'Email Sent',
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
    </g:javascript>
</head>

<body>
    <div id="wrappers">
        <div id="ajaxed_div">
            <br><br>
            <table id="first_table" class="ui sortable celled table" cellspacing="0" width="100% margin: 0px">
                <thead>
                <tr>
                    <th>S.No</th>
                    <th>Student Name</th>
                    <th>Book Name</th>
                    <th>Borrowed Date</th>
                    <th>Fine Amount</th>
                    <th>Email</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${borrowsWithFine}" var="borrowWithFine" status="i">
                    <tr>
                        <td>${i + 1}</td>
                        <td>${borrowWithFine.key.member.fullName}</td>
                        <td>${borrowWithFine.key.bookInfo.book.name}</td>
                        <td>${borrowWithFine.key.borrowedDate.format("yyyy/MM/dd")}</td>
                        <td>${borrowWithFine.value.fineAmount}</td>
                        <td><button class="ui green basic button" style="text-align: center;" onclick="sendEmail(${borrowWithFine.key.member.id}, '${borrowWithFine.key.member.fullName}', ${borrowWithFine.key.id});">Email</button></td>
                    </tr>
                </g:each>
                </tbody>
            </table>
            <div class="ui active dimmer" id = "loading" style="display: none;">
                <div class="ui large text loader" id = "loadingText"></div>
            </div>
        </div>
    </div>
</body>
</html>