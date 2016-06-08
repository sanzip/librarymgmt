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
    short daysCourseBookBorrowableStudent
    short daysCourseBookBorrowableFaculty
    short daysCourseBookBorrowableAdmin
    short daysCourseBookBorrowableLibrarian
    short novelBookBorrowable
    short daysNovelBookBorrowable

    static final String ACTION_TYPE_ISSUE = "Issue";
    static final String ACTION_TYPE_RETURN = "Return";
    static constraints = {
    }

    Configure(double fineAmtStudent, double fineAmtFaculty, double fineAmtAdmin, double fineAmtLibrarian,
              short courseBookBorrowableStudent, short courseBookBorrowableFaculty, short courseBookBorrowableAdmin,
              short courseBookBorrowableLibrarian, short daysCourseBookBorrowableStudent,
              short daysCourseBookBorrowableFaculty, short daysCourseBookBorrowableAdmin,
              short daysCourseBookBorrowableLibrarian, short novelBookBorrowable, short daysNovelBookBorrowable) {
        this.fineAmtStudent = fineAmtStudent
        this.fineAmtFaculty = fineAmtFaculty
        this.fineAmtAdmin = fineAmtAdmin
        this.fineAmtLibrarian = fineAmtLibrarian
        this.courseBookBorrowableStudent = courseBookBorrowableStudent
        this.courseBookBorrowableFaculty = courseBookBorrowableFaculty
        this.courseBookBorrowableAdmin = courseBookBorrowableAdmin
        this.courseBookBorrowableLibrarian = courseBookBorrowableLibrarian
        this.daysCourseBookBorrowableStudent = daysCourseBookBorrowableStudent
        this.daysCourseBookBorrowableFaculty = daysCourseBookBorrowableFaculty
        this.daysCourseBookBorrowableAdmin = daysCourseBookBorrowableAdmin
        this.daysCourseBookBorrowableLibrarian = daysCourseBookBorrowableLibrarian
        this.novelBookBorrowable = novelBookBorrowable
        this.daysNovelBookBorrowable = daysNovelBookBorrowable
    }
}
