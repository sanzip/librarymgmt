

import grails.transaction.Transactional
import groovy.time.TimeCategory
import np.edu.dwit.Book
import np.edu.dwit.BookInfo
import np.edu.dwit.Borrow
import np.edu.dwit.Configure

@Transactional
class BookService {

    def getBooksWithBorrowCount() {

        Map booksWithBorrowCount = new HashMap()

        for (Book book: Book.all)
            booksWithBorrowCount.put(book, Borrow.countByBookInfo(BookInfo.findAllByBook(book)))

        TreeMap sortedBooksWithBorrowCount = new TreeMap(new BookMapComparator(booksWithBorrowCount));
        sortedBooksWithBorrowCount.putAll(booksWithBorrowCount);

        return sortedBooksWithBorrowCount
    }

    def mailMembersWithBooksBorrowsWithReturnDateParsi(){

        def burrows = Borrow.findByReturned(false)
        Configure configure = Configure.get(1)

        for (borrow in burrows) {
            def member = borrow.member
            def bDate = borrow.borrowedDate

            def tDays = new Date() - bDate
            def noOfDaysRemaining = 0

            if (member.getAuthorities()[0].toString().equals("ROLE_STUDENT")) {
                if (borrow.bookInfo.bookType.equals("Borrowable")) {
                    noOfDaysRemaining = tDays - configure.daysCourseBookBorrowableStudent
                } else if (borrow.bookInfo.bookType.equals("Novel")) {
                    noOfDaysRemaining = tDays - configure.daysNovelBookBorrowable /*DWITLibraryConstants.NOVEL_BOOK_BORROWABLE*/
                }
            }

            if (member.getAuthorities()[0].toString().equals("ROLE_FACULTY")) {
                if (borrow.bookInfo.bookType.equals("Borrowable")) {
                    noOfDaysRemaining = tDays - configure.daysCourseBookBorrowableFaculty
                } else if (borrow.bookInfo.bookType.equals("Novel")) {
                    noOfDaysRemaining = tDays - configure.daysNovelBookBorrowable /*DWITLibraryConstants.NOVEL_BOOK_BORROWABLE*/
                }
            }

            if (member.getAuthorities()[0].toString().equals("ROLE_ADMIN")) {
                if (borrow.bookInfo.bookType.equals("Borrowable")) {
                    noOfDaysRemaining = tDays - configure.daysCourseBookBorrowableAdmin
                } else if (borrow.bookInfo.bookType.equals("Novel")) {
                    noOfDaysRemaining = tDays - configure.daysNovelBookBorrowable /*DWITLibraryConstants.NOVEL_BOOK_BORROWABLE*/
                }
            }

            if (member.getAuthorities()[0].toString().equals("ROLE_LIBRARIAN")) {
                if (borrow.bookInfo.bookType.equals("Borrowable")) {
                    noOfDaysRemaining = tDays - configure.daysCourseBookBorrowableLibrarian
                } else if (borrow.bookInfo.bookType.equals("Novel")) {
                    noOfDaysRemaining = tDays - configure.daysNovelBookBorrowable /*DWITLibraryConstants.NOVEL_BOOK_BORROWABLE*/
                }
            }

            if(noOfDaysRemaining == -2){

                def bodyOfEmail
                use(TimeCategory) {

                    bodyOfEmail = "\nHello ${member.username},\n\n" +
                            "\tThis is a reminder to return '${borrow.bookInfo.book.name}' by " + Date.parse('MM/dd/yy', (new Date() + (-noOfDaysRemaining).days).getDateString()).format('MM/dd/yyyy') + "." +
                            "\n\nRegards,\nThe DWIT Library\n\n*****This is an auto-generated email.*****"
                }

                sendMail {

                    async true
                    to member.email
                    cc "samjhana.pokhrel@deerwalk.edu.np "
                    subject "Library: Reminder to return book"
                    text bodyOfEmail
                }
            }
        }
    }
}