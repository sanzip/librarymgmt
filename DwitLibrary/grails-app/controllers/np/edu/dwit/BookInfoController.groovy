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
            def bookInfoInstance = new BookInfo(params)
            bookInfoInstance.bookNumber=""
            bookInfoInstance.book=bookInfo.book
            bookInfoInstance.cost=bookInfo.cost
            bookInfoInstance.edition=bookInfo.edition
            bookInfoInstance.pages=bookInfo.pages
            bookInfoInstance.publishedYear=bookInfo.publishedYear
            bookInfoInstance.source=bookInfo.source
            bookInfoInstance.bookType=bookInfo.bookType
            respond bookInfoInstance
        }
    }

    @Transactional
    def save(BookInfo bookInfoInstance) {

        def bookNumber = params.list('bookNumber')
        boolean saved = false
        def number =0
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

/*                def book = Book.findById(bookInfos.book.id)
                book.totalQuantity+=1
                book.availableQuantity+=1*/
                bookInfos.book.totalQuantity+=1
                bookInfos.book.availableQuantity+=1

                bookInfos.save(flush: true,failOnError: true)
/*                if (bookInfos.save(flush: true,failOnError: true)){
                    book.save flush: true, failOnError: true
                }*/
                saved=true
            }else{
                saved=false
                number=bookNumber[i]
                break
            }
        }
        if (saved){
            flash.message="New book info added"
            redirect(controller: 'book', action: "index", params: [messageType: 'success'])
        }
        else {
            flash.message="Book info with "+number+" book number is already added."
            redirect(controller: 'bookInfo', action: "create", params: [id: params.book.id , messageType: 'error'])
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
        def fine
        def messageType
        if (!bookBorrow.empty){
            for (Borrow borrowInstance:bookBorrow){
                if (borrowInstance.returned){
                    timeStamp = TimeStamp.findAllByBorrow(borrowInstance)
                    log = Log.findAllByBorrow(borrowInstance)
                    fine = Fine.findAllByBorrow(borrowInstance)
                    if (!timeStamp.empty){
                        for (TimeStamp timeStampInstance: timeStamp){
                            timeStampInstance.delete flush:true
                        }
                    }
                    if (!log.empty){
                        for (Log logInstance:log){
                            logInstance.delete flush:true
                        }
                    }
                    if(!fine.empty){
                        for (Fine fineInstance:fine){
                            fineInstance.delete flush: true
                        }
                    }
                    borrowInstance.delete(flush: true)
                }
                else {
                    flash.message='Delete Failed. Book has not been returned.'
                    messageType = 'error'
                    return redirect(controller: 'bookInfo', action:'index',params:[id:bookInfoInstance.book.id,messageType: messageType])
                }
            }
        }

        bookInfoInstance.book.totalQuantity-=1;
        bookInfoInstance.book.availableQuantity-=1;
        bookInfoInstance.delete (flush:true)
        flash.message='BookInfo is deleted successfully.'
        messageType = 'success'

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
