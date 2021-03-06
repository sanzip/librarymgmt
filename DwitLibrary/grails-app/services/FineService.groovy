import np.edu.dwit.Borrow
import np.edu.dwit.Configure
import np.edu.dwit.Fine

/**
 * Created by zephyr on 11/5/15.
 */
class FineService {
    def calculateTotalDays(Date bDate){

        def rDate = new Date()
        return rDate-bDate
    }

    def calculatefine(Borrow borrow){
        Fine fine = new Fine()
        Configure configure = Configure.get(1);

        def member = borrow.member
        def bDate = borrow.borrowedDate

        def tDays=calculateTotalDays(bDate)

        if(member.getAuthorities()[0].toString().equals("ROLE_STUDENT")){
            if(borrow.bookInfo.bookType.equals("Borrowable")){
                fine.days=tDays - configure.daysCourseBookBorrowableStudent /*DWITLibraryConstants.COURSE_BOOK_BORROWABLE_STUDENT*/
                if(fine.days>0){
                    fine.fineAmount=fine.days * configure.fineAmtStudent /*DWITLibraryConstants.FINE_AMT_STUDENT*/
                }
            }
            else if (borrow.bookInfo.bookType.equals("Novel")){
                fine.days=tDays - configure.daysNovelBookBorrowable /*DWITLibraryConstants.NOVEL_BOOK_BORROWABLE*/
                if(fine.days>0){
                    fine.fineAmount=fine.days * configure.fineAmtStudent /*DWITLibraryConstants.FINE_AMT_STUDENT*/
                }
            }
        }

        if(member.getAuthorities()[0].toString().equals("ROLE_FACULTY")){
            if(borrow.bookInfo.bookType.equals("Borrowable")){
                fine.days=tDays - configure.daysCourseBookBorrowableFaculty /*DWITLibraryConstants.COURSE_BOOK_BORROWABLE_FACULTY*/
                if(fine.days>0){
                    fine.fineAmount=fine.days * configure.fineAmtFaculty /*DWITLibraryConstants.FINE_AMT_FACULTY*/
                }
            }
            else if (borrow.bookInfo.bookType.equals("Novel")){
                fine.days=tDays - configure.daysNovelBookBorrowable /*DWITLibraryConstants.NOVEL_BOOK_BORROWABLE*/
                if(fine.days>0){
                    fine.fineAmount=fine.days * configure.fineAmtFaculty /*DWITLibraryConstants.FINE_AMT_FACULTY*/
                }
            }
        }

        if(member.getAuthorities()[0].toString().equals("ROLE_ADMIN")){
            if(borrow.bookInfo.bookType.equals("Borrowable")){
                fine.days=tDays - configure.daysCourseBookBorrowableAdmin /*DWITLibraryConstants.COURSE_BOOK_BORROWABLE_ADMIN*/
                if(fine.days>0){
                    fine.fineAmount=fine.days * configure.fineAmtAdmin /*DWITLibraryConstants.FINE_AMT_ADMIN*/
                }
            }
            else if (borrow.bookInfo.bookType.equals("Novel")){
                fine.days=tDays - configure.daysNovelBookBorrowable /*DWITLibraryConstants.NOVEL_BOOK_BORROWABLE*/
                if(fine.days>0){
                    fine.fineAmount=fine.days * configure.fineAmtAdmin /*DWITLibraryConstants.FINE_AMT_ADMIN*/
                }
            }
        }

        if(member.getAuthorities()[0].toString().equals("ROLE_LIBRARIAN")){
            if(borrow.bookInfo.bookType.equals("Borrowable")){
                fine.days=tDays - configure.daysCourseBookBorrowableLibrarian /*DWITLibraryConstants.COURSE_BOOK_BORROWABLE_LIBRARIAN*/
                if(fine.days>0){
                    fine.fineAmount=fine.days * configure.fineAmtLibrarian /*DWITLibraryConstants.FINE_AMT_LIBRARIAN*/
                }
            }
            else if (borrow.bookInfo.bookType.equals("Novel")){
                fine.days=tDays - configure.daysNovelBookBorrowable /*DWITLibraryConstants.NOVEL_BOOK_BORROWABLE*/
                if(fine.days>0){
                    fine.fineAmount=fine.days * configure.fineAmtLibrarian /*DWITLibraryConstants.FINE_AMT_LIBRARIAN*/
                }
            }
        }

        fine.borrow=borrow
        fine.member=borrow.member
//        fine.save(flush: true)

        return fine
    }

    def recalculatefine(Borrow borrow,int days){
        Fine fine = new Fine()
        Configure configure = Configure.get(1);

        def member = borrow.member
        def bDate = borrow.borrowedDate

        //def tDays=calculateTotalDays(bDate)

        if(member.getAuthorities()[0].toString().equals("ROLE_STUDENT")){
            if(borrow.bookInfo.bookType.equals("Borrowable")){
                if(days>0){
                    fine.fineAmount=days * configure.fineAmtStudent /*DWITLibraryConstants.FINE_AMT_STUDENT*/
                }
            }
            else if (borrow.bookInfo.bookType.equals("Novel")){
                if(days>0){
                    fine.fineAmount=days * configure.fineAmtStudent /*DWITLibraryConstants.FINE_AMT_STUDENT*/
                }
            }
        }

        if(member.getAuthorities()[0].toString().equals("ROLE_FACULTY")){
            if(borrow.bookInfo.bookType.equals("Borrowable")){
                if(days>0){
                    fine.fineAmount=days * configure.fineAmtFaculty /*DWITLibraryConstants.FINE_AMT_FACULTY*/
                }
            }
            else if (borrow.bookInfo.bookType.equals("Novel")){
                if(days>0){
                    fine.fineAmount=days * configure.fineAmtFaculty /*DWITLibraryConstants.FINE_AMT_FACULTY*/
                }
            }
        }

        if(member.getAuthorities()[0].toString().equals("ROLE_ADMIN")){
            if(borrow.bookInfo.bookType.equals("Borrowable")){
                if(days>0){
                    fine.fineAmount=days * configure.fineAmtAdmin /*DWITLibraryConstants.FINE_AMT_ADMIN*/
                }
            }
            else if (borrow.bookInfo.bookType.equals("Novel")){
                if(days>0){
                    fine.fineAmount=days * configure.fineAmtAdmin /*DWITLibraryConstants.FINE_AMT_ADMIN*/
                }
            }
        }

        if(member.getAuthorities()[0].toString().equals("ROLE_LIBRARIAN")){
            if(borrow.bookInfo.bookType.equals("Borrowable")){
                if(days>0){
                    fine.fineAmount=days * configure.fineAmtLibrarian /*DWITLibraryConstants.FINE_AMT_LIBRARIAN*/
                }
            }
            else if (borrow.bookInfo.bookType.equals("Novel")){
                if(days>0){
                    fine.fineAmount=days * configure.fineAmtLibrarian /*DWITLibraryConstants.FINE_AMT_LIBRARIAN*/
                }
            }
        }

        fine.borrow=borrow
        fine.member=borrow.member

        return fine
    }

    def getReport(){

        def borrows = Borrow.createCriteria().list {
            eq("returned",false)
        }

        if(borrows.size() > 0) {

            Map<Borrow, Fine> borrowFineMap = new HashMap<>()
            for(Borrow borrow: borrows) {
                def fine = calculatefine(borrow)
                if(fine.fineAmount > 0)
                    borrowFineMap.put(borrow, fine)
            }

            TreeMap sortedBorrowFineMap = new TreeMap(new BorrowMapComparator(borrowFineMap));
            sortedBorrowFineMap.putAll(borrowFineMap);

            return sortedBorrowFineMap
        }
    }
}