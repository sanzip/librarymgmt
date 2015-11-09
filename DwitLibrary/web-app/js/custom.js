/**
 * Created by sumitshrestha on 7/21/15.
 */
$(function(){
   var form = $("#userform");
   var password = $("#password");
   var userName = $("#userName");
   var role = $("#role");
   var userDetail= $("#userInfo");
    form.submit(function(){
         if(validateUserName()){
             return true;
         }else{
            return false;
         }
    });

    $('#the-basics .typeahead').typeahead(
        {
            hint: true,
            highlight: true,
            minLength: 1
        },
        {
            name: 'states',
            source: substringMatcher(states)
        }
    );


});

function validateUserName(){
    if(userName.val().length < 5){
        userName.addClass("span");
        userDetail.text("Your userName is to short");
        return false;
    }else{
        userName.removeClass("error");
        return true;
    }
}

var substringMatcher = function(strs) {
    return function findMatches(q, cb) {
        var matches, substringRegex;

        // an array that will be populated with substring matches
        matches = [];

        // regex used to determine if a string contains the substring `q`
        substrRegex = new RegExp(q, 'i');

        // iterate through the pool of strings and for any string that
        // contains the substring `q`, add it to the `matches` array
        $.each(strs, function(i, str) {
            if (substrRegex.test(str)) {
                matches.push(str);
            }
        });

        cb(matches);
    };
};