package np.edu.dwit

import constants.DWITLibraryConstants
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import java.sql.Timestamp

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_LIBRARIAN'])

@Transactional(readOnly = true)
class BookController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def bookService
    def report() {

        def booksWithBorrowCount = bookService.booksWithBorrowCount
        [booksWithBorrowCount: booksWithBorrowCount]
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Book.list(params), model: [bookInstanceCount: Book.count()]
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

        bookInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'bookInstance.label', default: 'Book'), bookInstance.id])
                redirect bookInstance
            }
            '*' { respond bookInstance, [status: CREATED] }
        }
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

        bookInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Book.label', default: 'Book'), bookInstance.id])
                redirect bookInstance
            }
            '*' { respond bookInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Book bookInstance) {

        if (bookInstance == null) {
            notFound()
            return
        }

        bookInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Book.label', default: 'Book'), bookInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
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

    @Secured("ROLE_LIBRARIAN")
    def issueBook() {
        render(view: "issueBook",model: ["bookId":params.bookId])
    }

    @Secured("ROLE_LIBRARIAN")
    @Transactional
    def beforeIssue() {
        def borrowingUser = User.findByUsername(params.borrowingUsername);

        if(borrowingUser){
            def c = Borrow.createCriteria()

            def borrowCount = c.count {
                eq("member", borrowingUser)
                eq("returned", false)

            }
            def role = borrowingUser.getAuthorities().toString().substring(6,9);
            def book = Book.findById(Long.valueOf(params.bookId).longValue())

            Borrow borrow = new Borrow();
            borrow.book = book
            borrow.borrowedDate=new Timestamp(new Date().getTime())
            borrow.returned=false
            borrow.member=borrowingUser

            if(role.equals("FAC")){
                if(borrowCount>=DWITLibraryConstants.LIMIT_BOOK_BORROWABLE_FACULTY) {
                    render "greaterborrowcount"
                }else {
                    borrow.save(flush: true)
                    render "issue"
                }
            }else if(role.equals("LIB")){
                if(borrowCount>=DWITLibraryConstants.LIMIT_BOOK_BORROWABLE_LIBRARIAN) {
                    render "greaterborrowcount"
                }else {

                    borrow.save(flush: true)
                    render "issue"
                }
            }

            else if(role.equals("ADM")){
                if(borrowCount>=DWITLibraryConstants.LIMIT_BOOK_BORROWABLE_ADMIN) {
                    render "greaterborrowcount"
                }else {
                    borrow.save(flush: true)
                    render "issue"
                }
            }else if(role.equals("STU")){
                if(borrowCount>=DWITLibraryConstants.LIMIT_BOOK_BORROWABLE_STUDENT) {
                    render "greaterborrowcount"
                }else {
                    borrow.save(flush: true)
                    render "issue"
                }
            }
            else {
                render "error"
            }

        }
    }
}
