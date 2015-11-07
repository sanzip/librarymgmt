import constants.DWITLibraryConstants
import np.edu.dwit.Fine

/**
 * Created by zephyr on 11/5/15.
 */
class FIneService {
    def calculateTotalDays(Date bDate){

        def rDate = new Date()
        return rDate-bDate
    }

    def calculatefine(Fine fine){
        def bDate = fine.borrow.borrowedDate
        def tDays=calculateTotalDays(bDate)

        if(fine.member.getAuthorities().equals("ROLE_STUDENT")){
            if(fine.borrow.book.bookType.equals("Course")){
                fine.days=tDays - DWITLibraryConstants.COURSE_BOOK_BORROWABLE_STUDENT
                if(fine.days>0){
                  fine.fineAmount=fine.days * DWITLibraryConstants.FINE_AMT_STUDENT
                }
            }
            else if (fine.borrow.book.bookType.equals("Novel")){
                fine.days=tDays - DWITLibraryConstants.NOVEL_BOOK_BORROWABLE
                if(fine.days>0){
                    fine.fineAmount=fine.days * DWITLibraryConstants.FINE_AMT_STUDENT
                }
            }
        }

        if(fine.member.getAuthorities().equals("ROLE_FACULTY")){
            if(fine.borrow.book.bookType.equals("Course")){
                fine.days=tDays - DWITLibraryConstants.COURSE_BOOK_BORROWABLE_FACULTY
                if(fine.days>0){
                    fine.fineAmount=fine.days * DWITLibraryConstants.FINE_AMT_FACULTY
                }
            }
            else if (fine.borrow.book.bookType.equals("Novel")){
                fine.days=tDays - DWITLibraryConstants.NOVEL_BOOK_BORROWABLE
                if(fine.days>0){
                    fine.fineAmount=fine.days * DWITLibraryConstants.FINE_AMT_FACULTY
                }
            }
        }

        if(fine.member.getAuthorities().equals("ROLE_ADMIN")){
            if(fine.borrow.book.bookType.equals("Course")){
                fine.days=tDays - DWITLibraryConstants.COURSE_BOOK_BORROWABLE_ADMIN
                if(fine.days>0){
                    fine.fineAmount=fine.days * DWITLibraryConstants.FINE_AMT_ADMIN
                }
            }
            else if (fine.borrow.book.bookType.equals("Novel")){
                fine.days=tDays - DWITLibraryConstants.NOVEL_BOOK_BORROWABLE
                if(fine.days>0){
                    fine.fineAmount=fine.days * DWITLibraryConstants.FINE_AMT_ADMIN
                }
            }
        }

        if(fine.member.getAuthorities().equals("ROLE_LIBRARIAN")){
            if(fine.borrow.book.bookType.equals("Course")){
                fine.days=tDays - DWITLibraryConstants.COURSE_BOOK_BORROWABLE_LIBRARIAN
                if(fine.days>0){
                    fine.fineAmount=fine.days * DWITLibraryConstants.FINE_AMT_LIBRARIAN
                }
            }
            else if (fine.borrow.book.bookType.equals("Novel")){
                fine.days=tDays - DWITLibraryConstants.NOVEL_BOOK_BORROWABLE
                if(fine.days>0){
                    fine.fineAmount=fine.days * DWITLibraryConstants.FINE_AMT_LIBRARIAN
                }
            }
        }

        fine.save(failOnError: true)
    }
}
