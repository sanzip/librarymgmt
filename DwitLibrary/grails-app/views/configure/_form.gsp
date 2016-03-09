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
                <label>Course Book Borrowable Admin *</label>
                <g:field name="courseBookBorrowableAdmin" type="number" value="${configureInstance.courseBookBorrowableAdmin}" required=""/>
            </div>
            <div class="field">
                <label>Course Book Borrowable Faculty *</label>
                <g:field name="courseBookBorrowableFaculty" type="number" value="${configureInstance.courseBookBorrowableFaculty}" required=""/>
            </div>
        </div>
    </div>

    <div class="field">
        <div class="two fields">
            <div class="field">
                <label>Course Book Borrowable Librarian *</label>
                <g:field name="courseBookBorrowableLibrarian" type="number" value="${configureInstance.courseBookBorrowableLibrarian}" required=""/>
            </div>
            <div class="field">
                <label>Course Book Borrowable Student *</label>
                <g:field name="courseBookBorrowableStudent" type="number" value="${configureInstance.courseBookBorrowableStudent}" required=""/>
            </div>
        </div>
    </div>

    <div class="field">
        <div class="two fields">
            <div class="field">
                <label>Fine Amount Admin *</label>
                <g:field name="fineAmtAdmin" type="number"  value="${fieldValue(bean: configureInstance, field: 'fineAmtAdmin')}" required=""/>
            </div>
            <div class="field">
                <label>Fine Amount Faculty *</label>
                <g:field name="fineAmtFaculty" type="number" value="${fieldValue(bean: configureInstance, field: 'fineAmtFaculty')}" required=""/>
            </div>
        </div>
    </div>



    <div class="field">
        <div class="two fields">
            <div class="field">
                <label>Fine Amount Librarian *</label>
                <g:field name="fineAmtLibrarian" type="number" value="${fieldValue(bean: configureInstance, field: 'fineAmtLibrarian')}" required=""/>
            </div>
            <div class="field">
                <label>Fine Amount Student *</label>
                <g:field name="fineAmtStudent" type="number" value="${fieldValue(bean: configureInstance, field: 'fineAmtStudent')}" required=""/>
            </div>
        </div>
    </div>


    <div class="field">
        <div class="two fields">
            <div class="field">
                <label>Book Borrowable Admin Limit *</label>
                <g:field name="limitBookBorrowableAdmin" type="number" value="${configureInstance.limitBookBorrowableAdmin}" required=""/>
            </div>
            <div class="field">
                <label>Book Borrowable Faculty Limit *</label>
                <g:field name="limitBookBorrowableFaculty" type="number" value="${configureInstance.limitBookBorrowableFaculty}" required=""/>
            </div>
        </div>
    </div>

    <div class="field">
        <div class="two fields">
            <div class="field">
                <label>Book Borrowable Librarian Limit *</label>
                <g:field name="limitBookBorrowableLibrarian" type="number" value="${configureInstance.limitBookBorrowableLibrarian}" required=""/>
            </div>
            <div class="field">
                <label>Book Borrowable Student Limit *</label>
                <g:field name="limitBookBorrowableStudent" type="number" value="${configureInstance.limitBookBorrowableStudent}" required=""/>
            </div>
        </div>
    </div>



    <div class="field">
        <div class="two fields">
            <div class="field">
                <label>Novel Book Borrowable *</label>
                <g:field name="novelBookBorrowable" type="number" value="${configureInstance.novelBookBorrowable}" required=""/>
            </div>
            <div class="field">

            </div>
        </div>
    </div>


</div>