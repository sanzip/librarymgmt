package np.edu.dwit

import constants.DWITLibraryConstants
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import java.sql.Timestamp
import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_LIBRARIAN'])

@Transactional(readOnly = true)
class BookController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def bookService
    def fineService
    def springSecurityService
    def report() {

        def booksWithBorrowCount = bookService.booksWithBorrowCount
        [booksWithBorrowCount: booksWithBorrowCount]
    }

    def index(Integer max) {
        respond Book.list(), model: [bookInstanceCount: Book.count()]
    }

    def show(Book bookInstance) {
        respond bookInstance
    }

    def create() {
        respond new Book(params)
    }

    @Transactional
    def save(Book bookInstance) {
        if (bookInstance == null) {
            notFound()
            return
        }

        if (bookInstance.hasErrors()) {
            respond bookInstance.errors, view: 'create'
            return
        }

        bookInstance.totalQuantity=0
        bookInstance.availableQuantity=bookInstance.totalQuantity
        bookInstance.save flush: true

        redirect(controller:'bookInfo', action:'create',params:[id:bookInstance.id])
        /*request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'bookInstance.label', default: 'Book'), bookInstance.id])
                redirect bookInstance
            }
            '*' { respond bookInstance, [status: CREATED] }
        }*/
    }

    def edit(Book bookInstance) {
        respond bookInstance
    }

    @Transactional
    def update(Book bookInstance) {
        if (bookInstance == null) {
            notFound()
            return
        }

        if (bookInstance.hasErrors()) {
            respond bookInstance.errors, view: 'edit'
            return
        }
        flash.message = 'Book updated'
        bookInstance.save flush: true
        redirect(controller: 'book', action:'index',params:[id:bookInstance.id, messageType: 'sucess'])
        /*request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Book.label', default: 'Book'), bookInstance.id])
                redirect bookInstance
            }
            '*' { respond bookInstance, [status: OK] }
        }*/
    }

    @Transactional
    def delete(Book bookInstance) {

        if (bookInstance == null) {
            notFound()
            return
        }

        def bookInfo = BookInfo.findAllByBook(bookInstance)
        def messageType
        if (bookInfo==null){
            if (bookInstance.delete(flush: true)){
                flash.message='Book is deleted successfully.'
                messageType = 'success'
            }
            else {
                flash.message='Delete Failed. If the problem persists contact IT department.'
                messageType = 'error'
            }
        }
        else {
                flash.message='Delete Failed. BookInfo of this book is not empty.'
                messageType = 'error'
        }


       /* request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Book.label', default: 'Book'), bookInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'bookInstance.label', default: 'Book'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


//    @Secured("ROLE_LIBRARIAN")
//    @Transactional
//    def beforeIssue() {
//        def borrowingUser = User.findByUsername(params.borrowingUsername);
//
//        if(borrowingUser){
//            def c = Borrow.createCriteria()
//
//            def borrowCount = c.count {
//                eq("member", borrowingUser)
//                eq("returned", false)
//
//            }
//            def role = borrowingUser.getAuthorities().toString().substring(6,9);
//            def book = Book.findById(Long.valueOf(params.bookId).longValue())
//
//            Borrow borrow = new Borrow();
//            borrow.book = book
//            borrow.borrowedDate=new Timestamp(new Date().getTime())
//            borrow.returned=false
//            borrow.member=borrowingUser
//
//            if(role.equals("FAC")){
//                if(borrowCount>=DWITLibraryConstants.LIMIT_BOOK_BORROWABLE_FACULTY) {
//                    render "greaterborrowcount"
//                }else {
//                    borrow.save(flush: true)
//                    render "issue"
//                }
//            }else if(role.equals("LIB")){
//                if(borrowCount>=DWITLibraryConstants.LIMIT_BOOK_BORROWABLE_LIBRARIAN) {
//                    render "greaterborrowcount"
//                }else {
//
//                    borrow.save(flush: true)
//                    render "issue"
//                }
//            }
//
//            else if(role.equals("ADM")){
//                if(borrowCount>=DWITLibraryConstants.LIMIT_BOOK_BORROWABLE_ADMIN) {
//                    render "greaterborrowcount"
//                }else {
//                    borrow.save(flush: true)
//                    render "issue"
//                }
//            }else if(role.equals("STU")){
//                if(borrowCount>=DWITLibraryConstants.LIMIT_BOOK_BORROWABLE_STUDENT) {
//                    render "greaterborrowcount"
//                }else {
//                    borrow.save(flush: true)
//                    render "issue"
//                }
//            }
//            else {
//                render "error"
//            }
//
//        }
//    }

    @Secured("ROLE_LIBRARIAN")
    def returnBookNav() {
        render(template: "returnBook",model:[userInstanceList: User.list(params), userInstanceTotal: User.count()])
    }

    @Secured("ROLE_LIBRARIAN")
    def bookInfoList(){

        def bookId = params?.bookId
        def bookInfos = BookInfo.findAllByBook(Book.findById(bookId as Long))

        def bookInfosToRemove = Borrow.createCriteria().list {
            eq('returned', false)
            inList('bookInfo', bookInfos)
        }.bookInfo

        render(template: 'issueBook', model: [bookInfos: bookInfos - bookInfosToRemove])
    }

    @Secured("ROLE_LIBRARIAN")
    def issueBookNav() {
        render(template: "issue",model:[userInstanceList: User.list(params), userInstanceTotal: User.count()])
    }

    def getAllUsers() {
        def users = User.list()
        def response = []

        users.each {
            response << "${it.fullName}"
        }
        render response as JSON
    }

    /*def checkValidBookType() {
        def bookTypeResult = BookInfo.findByBookNumber(params.bookNumber);

        if(bookTypeResult){
            if(bookTypeResult.bookType.equalsIgnoreCase("Reference")){
                flash.message = "Reference book cannot be borrowed"
                redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
            }
            if(bookTypeResult.bookType.equalsIgnoreCase("Gifted")){
                flash.message = "Gifted book cannot be borrowed"
                redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
            }
            if(bookTypeResult.bookType.equalsIgnoreCase("Borrowable")){
                flash.message = "Valid book number"
            }
            if(bookTypeResult.bookType.equalsIgnoreCase("novel")){
                flash.message = "Valid book number"
            }
        }
    }*/

    @Transactional
    def saveIssue() {
        def borrowingUser = Member.findByFullName(params.fullName)
        def bookInfo = BookInfo.findByBookNumber(params.bookNumber)
        def currentlyloggedInUser = springSecurityService.principal.id
        def configure = Configure.get(1);

        if(!bookInfo) {
            flash.message = "Book number doesnot exist."
            redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
        }else {

            def borrowingBook = bookInfo.book
            def issueSaved = false
            if (!borrowingBook && !borrowingUser) {
                flash.message = "Book number and username doesnot exist."
                redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
            } else if (borrowingBook && !borrowingUser) {
                flash.message = "Username doesnot exist."
                redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
            } else if (!borrowingBook && borrowingUser) {
                flash.message = "Book number doesnot exist."
                redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
            } else if (bookInfo.bookType.equalsIgnoreCase("Reference") || bookInfo.bookType.equalsIgnoreCase("Gifted")) {
                flash.message = "Reference or gifted book cannot be borrowed"
                redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
            }else if(borrowingUser.id==currentlyloggedInUser) {
                flash.message = "Librarian are not allowed to issue book to themselves."
                redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
            }
            else {

                if (borrowingUser && borrowingBook) {
                    def c = Borrow.createCriteria()

                    def borrowCount = c.count {
                        eq("member", borrowingUser)
                        eq("returned", false)

                    }

                    def role = borrowingUser.getAuthorities()[0].toString();

                    def isAlreadyBorrowed = Borrow.findByBookInfoInListAndReturned(BookInfo.findAllByBookNumber(params.bookNumber), false)

                    Borrow borrow = new Borrow();

                    if (borrowCount > 0) {
                        //to not let already issued book,again reissuing mistakely,
                        // 261 already issued, so not letting it to reissue
                        if (isAlreadyBorrowed?.returned || isAlreadyBorrowed == null) {
                            borrow.bookInfo = bookInfo
                            borrow.borrowedDate = new Timestamp(new Date().getTime())
                            borrow.returned = false
                            borrow.member = borrowingUser

                            if (role.equals("ROLE_FACULTY")) {
                                if (borrowCount >= configure.limitBookBorrowableFaculty) {
                                    flash.message = "User have already borrowed three books"
                                    redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
                                } else {
                                    borrow.save(flush: true)

                                    bookInfo.book.availableQuantity -= 1
                                    bookInfo.save(flush: true)
                                    saveTimestamp(bookInfo, borrowingUser)

                                    issueSaved = true

                                    flash.message = "Book Issued"
                                    redirect(controller: 'member', action: 'dashboard', params: [messageType: 'success'])
                                }
                            } else if (role.equals("ROLE_LIBRARIAN")) {
                                if (borrowCount >= configure.limitBookBorrowableLibrarian) {
                                    flash.message = "You have already borrowed three books"
                                    redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
                                } else {
                                    borrow.save(flush: true)
                                    bookInfo.book.availableQuantity -= 1
                                    bookInfo.save(flush: true)
                                    saveTimestamp(bookInfo, borrowingUser)

                                    issueSaved = true

                                    flash.message = "Book Issued"
                                    redirect(controller: 'member', action: 'dashboard', params: [messageType: 'success'])
                                }
                            } else if (role.equals("ROLE_ADMIN")) {
                                if (borrowCount >= configure.limitBookBorrowableAdmin) {
                                    flash.message = "You have already borrowed three books"
                                    redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
                                } else {
                                    borrow.save(flush: true)
                                    bookInfo.book.availableQuantity -= 1
                                    bookInfo.save(flush: true)
                                    saveTimestamp(bookInfo, borrowingUser)

                                    issueSaved = true

                                    flash.message = "Book Issued"
                                    redirect(controller: 'member', action: 'dashboard', params: [messageType: 'success'])
                                }
                            } else if (role.equals("ROLE_STUDENT")) {
                                if (borrowCount >= configure.limitBookBorrowableStudent) {
                                    flash.message = "You have already borrowed three books"
                                    redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
                                } else {
                                    borrow.save(flush: true)
                                    bookInfo.book.availableQuantity -= 1
                                    bookInfo.save(flush: true)
                                    saveTimestamp(bookInfo, borrowingUser)

                                    issueSaved = true

                                    flash.message = "Book Issued"
                                    redirect(controller: 'member', action: 'dashboard', params: [messageType: 'success'])
                                }
                            }
                        } else {
                            flash.message = "Book is already borrowed by other user."
                            redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
                        }

                    } else {
                        //if member had not borrowed book yet it will come here
                        if (isAlreadyBorrowed?.returned || isAlreadyBorrowed == null) {
                            borrow.bookInfo = bookInfo
                            borrow.borrowedDate = new Timestamp(new Date().getTime())
                            borrow.returned = false
                            borrow.member = borrowingUser
                            borrow.save(flush: true)

                            bookInfo.book.availableQuantity -= 1
                            bookInfo.save(flush: true)

                            saveTimestamp(bookInfo, borrowingUser)

                            issueSaved = true

                            flash.message = "Book Issued"
                            redirect(controller: 'member', action: 'dashboard', params: [messageType: 'success'])
                        } else {
                            flash.message = "Book is already borrowed by other user."
                            redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
                        }


                    }
                    if (issueSaved) {

                        //Saving log
                        Log log = new Log()
                        log.by = springSecurityService.currentUser
                        log.borrow = borrow
                        log.to = borrow.member
                        log.actionType = configure.ACTION_TYPE_ISSUE
                        log.save(failOnError: true)
                    }
                }
            }
        }

    }
    def saveTimestamp(BookInfo bookInfo,Member member) {
        def configure = Configure.get(1)
        TimeStamp timeStamp = new TimeStamp()
        def borrow =Borrow.findByBookInfoAndMemberAndReturned(bookInfo,member,false)
        def role = borrow.member.getAuthorities()[0].toString()
        def date = getBorrowedDate(borrow)
        if(role.equals("ROLE_STUDENT")) {

            if(borrow.bookInfo.bookType.equalsIgnoreCase("Borrowable")) {
                def deadline = addDays(date, configure.courseBookBorrowableAdmin);
                timeStamp.deadline = deadline;

            }else if(borrow.bookInfo.bookType.equalsIgnoreCase("Novel")) {

                def deadline = addDays(date, configure.novelBookBorrowable);

                timeStamp.deadline = deadline;
            }



        }else if(role.equals("ROLE_LIBRARIAN")) {
            if(borrow.bookInfo.bookType.equalsIgnoreCase("Borrowable")) {
                def deadline = addDays(date, configure.courseBookBorrowableLibrarian)

                timeStamp.deadline = deadline
            }else if(borrow.bookInfo.bookType.equalsIgnoreCase("Novel")) {
                def deadline = addDays(date, configure.novelBookBorrowable);

                timeStamp.deadline = deadline;
            }



        }else if(role.equals("ROLE_ADMIN")) {
            if(borrow.bookInfo.bookType.equalsIgnoreCase("Borrowable")) {
                def deadline = addDays(date, configure.courseBookBorrowableAdmin)

                timeStamp.deadline = deadline
            }else if(borrow.bookInfo.bookType.equalsIgnoreCase("Novel")) {
                def deadline = addDays(date, configure.novelBookBorrowable);

                timeStamp.deadline = deadline;
            }


        }else if(role.equals("ROLE_FACULTY")) {
            if(borrow.bookInfo.bookType.equalsIgnoreCase("Borrowable")) {
                def deadline = addDays(date, configure.courseBookBorrowableFaculty)

                timeStamp.deadline = deadline
            }else if(borrow.bookInfo.bookType.equalsIgnoreCase("Novel")) {
                def deadline = addDays(date, configure.novelBookBorrowable);

                timeStamp.deadline = deadline;
            }
        }
        timeStamp.borrow = borrow
        timeStamp.save(flush: true, failOnError: true)


    }
    def getBorrowedDate(Borrow borrow) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = format.parse(borrow.borrowedDate.toString());

        return date
    }

    private static def addDays(Date date, int days) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, days);

        return cal.getTime().format("yyyy-MM-dd")

    }

    @Secured("ROLE_LIBRARIAN")
    def checkBorrowedMember(){
        def amount
        def result
        def borrowingBook = BookInfo.findByBookNumber(params.bookNumber)

        if(borrowingBook){
            def borrowedMember = Borrow.findByBookInfoAndReturned(borrowingBook, false)

            if(borrowedMember) {
                def fine = fineService.calculatefine(borrowedMember);
                def borrowInfo = Borrow.createCriteria().list {
                    and {
                        eq("bookInfo", borrowingBook)
                        eq("member", borrowedMember.member)
                        eq("returned", false)
                    }
                }
                amount = fine.fineAmount ?: 0

                def totalBorrowedDays = new Date() - borrowInfo[0].borrowedDate
                if(totalBorrowedDays > 0){
                    result = borrowedMember.member.fullName + ":" + amount + ":${fine.days >= 0 ? fine.days : 0}:${totalBorrowedDays >= 0 ? totalBorrowedDays : 0}"
                }else {
                    result = borrowedMember.member.fullName + ":" + amount + ":${totalBorrowedDays >= 0 ? totalBorrowedDays : 0}"
                }

                render result
            }
        }else {
            render "error"
        }

    }


    @Secured("ROLE_LIBRARIAN")@Transactional
    def saveReturn() {

        def borrowedBook = BookInfo.findByBookNumber(params.bookNumber)
        if(borrowedBook) {
            def borrowingUser = Member.findByFullName(params.fullName)

            def borrow = Borrow.findByBookInfoAndMemberAndReturned(borrowedBook,borrowingUser,false)

            if(borrow){
                if(borrowingUser){

                    borrow.member = borrowingUser
                    borrow.bookInfo=borrowedBook
                    borrow.returned = true
                    borrow.returnedDate=new Timestamp(new Date().getTime())
                    borrow.save(flush: true, failOnError: true)

                    borrowedBook.book.availableQuantity +=1;
                    borrowedBook.book.save(failOnError: true)

                    Fine fine = new Fine()
                    fine.borrow = borrow
                    fine.fineAmount = params.fine as double
                    def fineDays
                    if(params.totalFineDays){
                        fineDays = params.totalFineDays as short
                        fine.days = fineDays
                    }else {
                        fine.days = 0
                    }
                    fine.member=borrowingUser

                    fine.save(flush: true, failOnError: true)

                    //Saving log
                    Log log = new Log()
                    log.by = borrow.member
                    log.borrow = borrow
                    log.to = springSecurityService.currentUser
                    log.actionType = configure.ACTION_TYPE_RETURN
                    log.save(failOnError: true)

                    flash.message = "Book Successfully returned"

                    redirect(controller: 'member', action: 'dashboard', params: [messageType: 'success'])
                }
            }else {
                flash.message = "Book Number is not borrowed yet."
                redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
            }


        }else {
            flash.message = "Book Number does not exist"
            redirect(controller: 'member', action: 'dashboard', params: [messageType: 'error'])
        }

    }

    def recalculateFine() {
        def amount
        def borrowingUser = Member.findByFullName(params.memberName)

        def borrowedBook = BookInfo.findByBookNumber(params.bookNumber)
        def borrow = Borrow.findByBookInfoAndMemberAndReturned(borrowedBook,borrowingUser,false)

        def fine = fineService.recalculatefine(borrow,params.days as int);

        def amt = fine.fineAmount

        if(amt) {
            amount = amt
        }else {
            amount = 0
        }

        def totalBorrowedDays = borrow.borrowedDate-new Date()
        render borrowingUser.fullName +":"+amount+":"+params.days+":"+totalBorrowedDays


    }
}
