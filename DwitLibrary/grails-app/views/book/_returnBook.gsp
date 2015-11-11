<div class = "ui form">
    <div class="ui icon input" style="text-align: right">
        <div class = "ui green button"  onclick="reset();">
            <i class="repeat icon"></i>Reset
        </div>
    </div>
    <div class = "ui icon input">
        <label for="bookNo"> Book Number </label>
        <input type="text" name="bookNumber" id="bookNo" placeholder="Book Id" onkeyup="checkValidBookNumber(this.value);" autocomplete="off"/><br/>
    </div>
    <div class = "ui icon input">
        <label for="fullNameReturn"> Member name </label>
        <input type="text" name="fullName" id="fullNameReturn" placeholder="Member Name" readonly/><br/>
    </div>
    <div class = "ui icon input">
        <label for="totalKeptDays"> Total kept Days</label>
        <input type ="text" name="totalKeptDays" id="totalKeptDays" readonly/><br>
    </div>
    <div class = "ui icon input">
        <label for="fine"> Fine</label>
        <input type="text" name="fine" id="fine"  readonly/><br/>
    </div>
    <div class = "ui icon input">
        <label for="fine"> Total fine Days</label>
        <input type ="text" name="totalFineDays" id="totalFineDays" onkeyup="changeFine();"/><br/>
    </div>
</div>