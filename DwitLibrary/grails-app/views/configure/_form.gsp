<%@ page import="np.edu.dwit.Configure" %>
<style>
input#courseBookBorrowableAdmin,input#courseBookBorrowableFaculty, input#courseBookBorrowableStudent,input#courseBookBorrowableLibrarian{
    width: 25%;
    text-align: center;
}
</style>
<div class="ui form" style="margin: 0px auto;width:90%;">

    <div class="field">
        <div class="two fields">
            <div class="field">
                <label>Fine Amount Admin *</label>
                <g:field name="fineAmtAdmin" id="fineAmtAdmin" type="number"  value="${fieldValue(bean: configureInstance, field: 'fineAmtAdmin')}" required=""/>
            </div>
            <div class="field">
                <label>Fine Amount Faculty *</label>
                <g:field name="fineAmtFaculty" id="fineAmtFaculty" type="number" value="${fieldValue(bean: configureInstance, field: 'fineAmtFaculty')}" required=""/>
            </div>
        </div>
    </div>



    <div class="field">
        <div class="two fields">
            <div class="field">
                <label>Fine Amount Librarian *</label>
                <g:field name="fineAmtLibrarian" id="fineAmtLibrarian" type="number" value="${fieldValue(bean: configureInstance, field: 'fineAmtLibrarian')}" required=""/>
            </div>
            <div class="field">
                <label>Fine Amount Student *</label>
                <g:field name="fineAmtStudent" id="fineAmtStudent" type="number" value="${fieldValue(bean: configureInstance, field: 'fineAmtStudent')}" required=""/>
            </div>
        </div>
    </div>

    <div class="field">
        <div class="two fields">
            <div class="field">
                <label>Course Book Borrowable Admin *</label>
                <g:field name="courseBookBorrowableAdmin" id="courseBookBorrowableAdmin" type="number" value="${configureInstance.courseBookBorrowableAdmin}" required=""/>
            </div>
            <div class="field">
                <label>Course Book Borrowable Faculty *</label>
                <g:field name="courseBookBorrowableFaculty" id="courseBookBorrowableFaculty" type="number" value="${configureInstance.courseBookBorrowableFaculty}" required=""/>
            </div>
        </div>
    </div>

    <div class="field">
        <div class="two fields">
            <div class="field">
                <label>Course Book Borrowable Librarian *</label>
                <g:field name="courseBookBorrowableLibrarian" id="courseBookBorrowableLibrarian"  type="number" value="${configureInstance.courseBookBorrowableLibrarian}" required=""/>
            </div>
            <div class="field">
                <label>Course Book Borrowable Student *</label>
                <g:field name="courseBookBorrowableStudent" id="courseBookBorrowableStudent" type="number" value="${configureInstance.courseBookBorrowableStudent}" required=""/>
            </div>
        </div>
    </div>

    <div class="field">
        <div class="two fields">
            <div class="field">
                <label>Novel Book Borrowable *</label>
                <g:field name="novelBookBorrowable" id="novelBookBorrowable" type="number" value="${configureInstance.novelBookBorrowable}" required=""/>
            </div>
            <div class="field">

            </div>
        </div>
    </div>


</div>