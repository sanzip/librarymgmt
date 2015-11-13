<%@ page import="np.edu.dwit.BookInfo" %>

<g:javascript>
$(function() {
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

function duplicateAdd(){
$('#bookNumberInput').append(' <br><input type="text" name="bookNumber" required="" value="${bookInfoInstance?.bookNumber}"/>');
        $('#bookNumberInput .addbutton').remove();
		$('#bookNumberInput').append('<br>  <button type="button" class = "ui teal button" onclick="duplicateAdd();">Add</button>');
	}

      function onlyNumbers(e, t) {
            try {
                if (window.event) {
                    var intCode = window.event.keyCode;
                }
                else if (e) {
                    var intCode = e.which;
                }
                else { return true; }
                if ((intCode >=48   && intCode <= 57)){
                    return true;
                }

                else{

                    alert("Please Enter Numeric Character");
                     $("#pages").val('');
                    return false;
                }

            }
            catch (err) {
                alert(err.Description);
            }
        }

      function onlyNumbersCost(e, t) {
            try {
                if (window.event) {
                    var intCode = window.event.keyCode;
                }
                else if (e) {
                    var intCode = e.which;
                }
                else { return true; }
                if ((intCode >=48   && intCode <= 57)){
                    return true;
                }

                else{

                    alert("Please Enter Numeric Character");
                     $("#cost").val('');
                    return false;
                }

            }
            catch (err) {
                alert(err.Description);
            }
        }


    function yearValidation(year,ev) {

              var text = /^[0-9]+$/;
              if(ev.type=="blur" || year.length==4 && ev.keyCode!=8 && ev.keyCode!=46) {
                if (year != 0) {
                    if ((year != "") && (!text.test(year))) {

                    alert("Please Enter Numeric Values Only");
                    $("#publishedYear").val('');
                    return false;
                }

              if (year.length != 4) {
                    alert("Year is not proper. Please check");
                    $("#publishedYear").val('');

                    return false;
                }
            var current_year=new Date().getFullYear();
                if((year < 1920) || (year > current_year))
                {
                     alert("Year should be in range 1920 to current year");
                    $("#publishedYear").val('');
                    return false;
                }
            return true;
            }
     }
}


</g:javascript>

<div class="ui form" id="bookInfoForm" style="margin: 0px auto;width:90%;">
    <br>
    <div class="two fields">
        <div class="field">
            <h3 class="ui dividing header">Book <span class="required-indicator">*</span> </h3>
                <g:textField id="book" name="book.id" readonly="" required="" value="${params.id}" class="many-to-one"/>
            </div>
            <div class="field">
                <h3 class="ui dividing header">Published Year <span class="required-indicator">*</span> </h3>
                <g:textField name="publishedYear" id="publishedYear" onblur="yearValidation(this.value,event)" onkeypress="yearValidation(this.value,event)" required="" value="${bookInfoInstance?.publishedYear}"/>
            </div>
        </div>

        <br>
        <div class="two fields">
            <div class="field">
                <h3 class="ui dividing header">Edition <span class="required-indicator">*</span> </h3>

                <g:textField name="edition" required="" value="${bookInfoInstance?.edition}"/>
            </div>
            <div class="field">
                <h3 class="ui dividing header">Pages <span class="required-indicator">*</span> </h3>

                <g:textField name="pages" id="pages" required="" onkeypress="return onlyNumbers(event,this)" value="${bookInfoInstance?.pages}"/>
            </div>

        </div>
        <br>

        <div class="two fields">

            <div class="field">
                <h3 class="ui dividing header">Cost <span class="required-indicator">*</span> </h3>

                <g:textField type="" name="cost" id="cost" onkeypress="return onlyNumbersCost(event,this)" value="${fieldValue(bean: bookInfoInstance, field: 'cost')}" required=""/>
            </div>

            <div class="field">
                <h3 class="ui dividing header">Source <span class="required-indicator">*</span> </h3>

                <g:textField name="source" required="" value="${bookInfoInstance?.source}"/>
            </div>
        </div>
<div class="two fields">
    <div class="field">
        <div class="fieldcontain ${hasErrors(bean: bookInfoInstance, field: 'bookType', 'error')} required">
            <h3 class="ui dividing header">Book Type <span class="required-indicator">*</span> </h3>
            <g:select name="bookType" from="${bookInfoInstance.constraints.bookType.inList}" required="" value="${bookInfoInstance?.bookType}" valueMessagePrefix="bookInfo.bookType"/>
        </div>
        </div>

    <div class="field">
        <h3 class="ui dividing header">Book Number <span class="required-indicator">*</span> </h3>

            %{--	<g:textField name="bookNumber" required="" value="${bookInfoInstance?.bookNumber}"/>--}%
            <div id="bookNumberInput" >
                <input type="text" name="bookNumber" required="" onkeypress="return onlyNumbers(event,this)" value="${bookInfoInstance?.bookNumber}" autocomplete="off"/>
        <br>
                <button type="button" class = "ui teal button" onclick="duplicateAdd();">Add</button>
            </div>
    </div>
</div>
    </div>
