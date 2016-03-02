package np.edu.dwit

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured("ROLE_LIBRARIAN")
class BookInfoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def index(Integer max) {

        def book = Book.findById(params.id)

        def bookInfo = BookInfo.findAllByBook(book)

        render view: 'index', model:[bookInfoInstanceList:bookInfo,bookInfoInstanceCount: bookInfo.size()/*,count:remainingToAdd>0 ? remainingToAdd:0*/]

    }


    def show(BookInfo bookInfoInstance) {
        respond bookInfoInstance
    }

    def create() {
//        println params.id
        def bookInfo = BookInfo.findByBook(Book.findById(params.id))
        if(bookInfo==null){
            respond new BookInfo(params)
        }
        else {
            bookInfo.bookNumber=""
            respond bookInfo
        }
    }

    @Transactional
    def save(BookInfo bookInfoInstance) {

        def bookNumber = params.list('bookNumber')
//        println bookInfoInstance.bookNumber
        boolean saved = false

        for(int i=0;i<bookNumber.size();i++) {
            def bookInfo = BookInfo.findByBookNumber(bookNumber[i])

            if(bookInfo == null){
                BookInfo bookInfos = new BookInfo()
                bookInfos.bookNumber=bookNumber[i]
                bookInfos.book=bookInfoInstance.book
                bookInfos.cost=bookInfoInstance.cost
                bookInfos.edition=bookInfoInstance.edition
                bookInfos.pages=bookInfoInstance.pages
                bookInfos.publishedYear=bookInfoInstance.publishedYear
                bookInfos.source=bookInfoInstance.source
                bookInfos.bookType=bookInfoInstance.bookType

                def book = Book.findById(bookInfos.book.id)
                book.totalQuantity+=1
                book.availableQuantity+=1

                if (bookInfos.save(flush: true,failOnError: true)){
                    book.save flush: true, failOnError: true
                }
                flash.message="New book info added"
                redirect(controller: 'book', action: "index", params: [messageType: 'success'])
            }else{
                flash.message="Book info with this book number is already added."
                redirect(controller: 'bookInfo', action: "create", params: [id: bookInfo.book.id , messageType: 'error'])
                break
            }

        }


    }

    def edit(BookInfo bookInfoInstance) {
        respond bookInfoInstance
    }

    @Transactional
    def update(BookInfo bookInfoInstance) {
        if (bookInfoInstance == null) {
            notFound()
            return
        }

        if (bookInfoInstance.hasErrors()) {
            respond bookInfoInstance.errors, view:'edit'
            return
        }

        String number = params.bookNumber
        bookInfoInstance.discard()
        def bookInfo = BookInfo.findByBookNumber(number)
        def messageType
        if(bookInfo==null){
            bookInfoInstance.save flush:true
            flash.message='Book information updated'
            messageType = 'success'
        }
        else {
            flash.message='Error! Book number already exist'
            messageType = 'error'
//            respond bookInfoInstance, view: 'edit', params:[messageType: 'error']
        }
        redirect(controller: 'bookInfo', action:'index',params:[id:bookInfoInstance.book.id,messageType: messageType])
/*        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BookInfo.label', default: 'BookInfo'), bookInfoInstance.id])
                redirect bookInfoInstance
            }
            '*'{ respond bookInfoInstance, [status: OK] }
        }*/
    }

    @Transactional
    def delete(BookInfo bookInfoInstance) {

        if (bookInfoInstance == null) {
            notFound()
            return
        }

        def bookBorrow = Borrow.findAllByBookInfo(bookInfoInstance)
        def timeStamp
        def log
        def messageType
        if (bookBorrow!=null){
            for (Borrow borrowInstance:bookBorrow){
                if (borrowInstance.returned){
                    timeStamp = TimeStamp.findAllByBorrow(borrowInstance)
                    log = Log.findAllByBorrow(borrowInstance)
                    if (timeStamp!=null){
                        for (TimeStamp timeStampInstance: timeStamp){
                            timeStampInstance.delete flush:true
                        }
                    }
                    if (log!=null){
                        for (Log logInstance:log){
                            logInstance.delete flush:true
                        }
                    }
                    borrowInstance.delete(flush: true)
                }
                else {
                    flash.message='Delete Failed. Book has not been returned.'
                    messageType = 'error'
                    redirect(controller: 'bookInfo', action:'index',params:[id:bookInfoInstance.book.id,messageType: messageType])
                }
            }
        }
        if (bookInfoInstance.delete (flush:true)){
            flash.message='BookInfo is deleted successfully.'
            messageType = 'success'
        }
        else {
            flash.message='Delete Failed. If the problem persists contact IT department.'
            messageType = 'error'

        }
        redirect(controller: 'bookInfo', action:'index',params:[id:bookInfoInstance.book.id,messageType: messageType])

/*
        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BookInfo.label', default: 'BookInfo'), bookInfoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'bookInfoInstance.label', default: 'BookInfo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
