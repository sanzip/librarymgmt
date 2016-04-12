package np.edu.dwit

class Configure {
    double fineAmtStudent
    double fineAmtFaculty
    double fineAmtAdmin
    double fineAmtLibrarian
    short courseBookBorrowableStudent
    short courseBookBorrowableFaculty
    short courseBookBorrowableAdmin
    short courseBookBorrowableLibrarian

    short novelBookBorrowable

    static final String ACTION_TYPE_ISSUE = "Issue";
    static final String ACTION_TYPE_RETURN = "Return";
    static constraints = {
    }



    Configure(double fineAmtStudent,double fineAmtFaculty,double fineAmtAdmin,double fineAmtLibrarian, short courseBookBorrowableStudent,
              short courseBookBorrowableFaculty,short courseBookBorrowableAdmin,short courseBookBorrowableLibrarian,
              short novelBookBorrowable){
        this.fineAmtStudent=fineAmtStudent
        this.fineAmtFaculty=fineAmtFaculty
        this.fineAmtAdmin=fineAmtAdmin
        this.fineAmtLibrarian=fineAmtLibrarian
        this.courseBookBorrowableStudent=courseBookBorrowableStudent
        this.courseBookBorrowableFaculty=courseBookBorrowableFaculty
        this.courseBookBorrowableAdmin=courseBookBorrowableAdmin
        this.courseBookBorrowableLibrarian=courseBookBorrowableLibrarian
        this.novelBookBorrowable=novelBookBorrowable

    }
}
