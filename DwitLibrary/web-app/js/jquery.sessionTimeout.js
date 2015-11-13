/*jshint browser:true*/

//
// jquery.sessionTimeout.js
//
// After a set amount of time, a dialog is shown to the user with the option
// to either log out now, or stay connected. If log out now is selected,
// the page is redirected to a logout URL. If stay connected is selected,
// a keep-alive URL is requested through AJAX. If no options is selected
// after another set amount of time, the page is automatically redirected
// to a timeout URL.
//
//
// USAGE
//
//   1. Include jQuery
//   2. Include jQuery UI (for dialog)
//   3. Include jquery.sessionTimeout.js
//   4. Call $.sessionTimeout(); after document ready
//
//
// OPTIONS
//
//   message
//     Text shown to user in dialog after warning period.
//     Default: 'Your session is about to expire.'
//
//   keepAliveUrl
//     URL to call through AJAX to keep session alive. This resource should do something innocuous that would keep the session alive, which will depend on your server-side platform.
//     Default: '/keep-alive'
//
//   keepAliveAjaxRequestType
//     How should we make the call to the keep-alive url? (GET/POST/PUT)
//     Default: 'POST'
//
//   redirUrl
//     URL to take browser to if no action is take after warning period
//     Default: '/timed-out'
//
//   logoutUrl
//     URL to take browser to if user clicks "Log Out Now"
//     Default: '/log-out'
//
//   warnAfter
//     Time in milliseconds after page is opened until warning dialog is opened
//     Default: 900000 (15 minutes)
//
//   redirAfter
//     Time in milliseconds after page is opened until browser is redirected to redirUrl
//     Default: 1200000 (20 minutes)
//
//   appendTime
//     If true, appends the current time stamp to the Keep Alive url to prevent caching issues
//     Default: true
//
(function( $ ){
    jQuery.sessionTimeout = function( options ) {
        var defaults = {
            message      : 'Your session is about to expire in 10 minutes. Do you want to refresh your session?',
            keepAliveUrl : '/DwitLibrary/logout/ajaxKeepAlive',//'/Annapurna/logout/ajaxKeepAlive'
            logOutUrl : '/DwitLibrary/logout/index',
            firstWarnAfter    :1200000, // 20 minutes   1200000 to test use 3000
            secondWarnAfter   : 300000,//300000, // 5 minutes
            thirdWarnAfter3   :240000, //240000, // 4 minute
            forthWarnAfter   :70000 //70000 // 90sec

        };

        // Extend user-set options over defaults
        var o = defaults,
            dialogTimer;

        if ( options ) { o = $.extend( defaults, options ); }

        // Create timeout warning dialog
        $('body').append('<div title="Session Timeout" id="sessionTimeout-dialog"></div>');
        $('#sessionTimeout-dialog').dialog({
            autoOpen: false,
            width: 400,
            modal: true,
            closeOnEscape: false,
            open: function() { $(".ui-dialog-titlebar-close").hide(); },
            buttons: {
                // Button one - takes user to logout URL
                "Stay Connected": function() {
                    $(this).dialog('close');

                    $.ajax({
                        type: 'POST',
                        url: o.keepAliveUrl
                    });
                    clearTimeout(dialogTimer);
                    // restart warning timer
                    controlDialogTimer('start');
                },
                // Button two - closes dialog and makes call to keep-alive URL
                "Cancel": function() {
                    $(this).dialog('close');
                }

            }
        });

        function controlDialogTimer(action){
            switch(action) {
                case 'start':
                    // After first warning period, show dialog and start redirect timer
                    dialogTimer = setTimeout(function(){
                        $("#sessionTimeout-dialog").text("Your session is about to expire in 10 minutes. Do you want to refresh your session?");
                        $('#sessionTimeout-dialog').dialog('open');
                        controlDialogTimer('start2');
                    }, o.firstWarnAfter);
                    break;
                case 'start2':
                    // After second warning period, show dialog and start redirect timer
                    dialogTimer = setTimeout(function(){
                        $("#sessionTimeout-dialog").text("Your session is about to expire in 5 minutes. Do you want to refresh your session?");
                        $('#sessionTimeout-dialog').dialog('open');
                        controlDialogTimer('start3');
                    }, o.secondWarnAfter);
                    break;
                case 'start3':
                    // After third warning period, show dialog and start redirect timer
                    dialogTimer = setTimeout(function(){
                        $("#sessionTimeout-dialog").text("Your session is about to expire in 1 minute. Do you want to refresh your session?");
                        $('#sessionTimeout-dialog').dialog('open');
                        controlDialogTimer('start4');
                    }, o.thirdWarnAfter3);
                    break;
                case 'start4':
                    // After forth warning period, show dialog and start redirect timer
                    dialogTimer = setTimeout(function(){
                        //window.location.reload();
                        window.location = o.logOutUrl;
                        /*var str=window.location.pathname.split("/").join("ef<<f!30/!gsk<<//!@!err/2cphu>><<//co")
                         window.location.href= '/login/sessionExpired?p='+str*/
//                        window.location.href= o.deny
                    }, o.forthWarnAfter);
                    break;
                case 'stop':
                    clearTimeout(dialogTimer);
                    break;
            }
        }

        // Begin warning period
        controlDialogTimer('start');
    };
})( jQuery );