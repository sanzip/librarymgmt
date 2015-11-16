package np.edu.dwit

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured("ROLE_LIBRARIAN")
class BookInfoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def book = Book.findById(params.id)

        def bookInfo = BookInfo.findAllByBook(book)

//        def bookCount = BookInfo.countByBook(book)
//        def remainingToAdd = book.totalQuantity-bookCount
//        println bookInfo.bookNumber
        render view: 'index', model:[bookInfoInstanceList:bookInfo,bookInfoInstanceCount: bookInfo.size()/*,count:remainingToAdd>0 ? remainingToAdd:0*/]

    }


    def show(BookInfo bookInfoInstance) {
        respond bookInfoInstance
    }

    def create() {
        respond new BookInfo(params)
    }

    @Transactional
    def save(BookInfo bookInfoInstance) {

        if (bookInfoInstance == null) {
            notFound()
            return
        }

        if (bookInfoInstance.hasErrors()) {
            respond bookInfoInstance.errors, view:'create'
            return
        }


        def bookNumber = params.list('bookNumber')
        println bookInfoInstance.bookNumber
        boolean saved = false


        for(int i=0;i<bookNumber.size();i++) {
            def bookInfo = BookInfo.findByBookNumber(bookNumber[i])
            println bookInfo
//            def bookCount
//            if(bookInfo){
//                bookCount=BookInfo.countByBookNumber(bookNumber[i])
//            }
//            def bookcountbybook = BookInfo.countByBook(bookInfoInstance.book)

            if(bookInfo == null){
//                if(bookNumber.size()>bookInfoInstance.book.totalQuantity){
//                    flash.message="You are adding more number of books than the existing total quantity."
//                    redirect(controller: params.currentController, action: "create", params: [id: bookInfoInstance.book.id,messageType: 'error'])
//                    break
//
//                }else if(bookNumber.size()+bookcountbybook>bookInfoInstance.book.totalQuantity){
//                    flash.message="You are going to add more number of books than the existing total quantity."
//                    redirect(controller: params.currentController, action: "create", params: [id: bookInfoInstance.book.id,messageType: 'error'])
//                    break
//                }
//                else{
//                    if(bookcountbybook<=bookInfoInstance.book.totalQuantity){
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


//                        def bookcountbybookAfterSave = BookInfo.countByBook(bookInfoInstance.book)
//
//                        if(bookNumber.size()==1 && bookcountbybookAfterSave==bookInfoInstance.book.totalQuantity){
//                            flash.message="New book info added, now no any book info remaining to be added."
//                            redirect(controller: "book", action: "index",params: [messageType: 'success'])
//
//                        }else if(bookNumber.size()-1==i){
//                            flash.message="New book info added"
//                            redirect(controller: params.currentController, action: "create", params: [id: bookInfoInstance.book.id,messageType: 'success'])
//                            break
//                        }else if(bookcountbybook==bookInfoInstance.book.totalQuantity){
                flash.message="New book info added"
//                        }
//                    }
//                    else {
//                        flash.message="Please update total quantity of book to add further more book info."
//                        redirect(controller: params.currentController, action: "create", params: [id: bookInfoInstance.book.id,messageType: 'error'])
//                    }
//                }
            }else{
                flash.message="Book info with this book number is already added."
                break
            }

        }
        redirect(controller: 'book', action: "create", params: [messageType: 'success'])

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

        bookInfoInstance.save flush:true
        redirect(controller: params.currentController, action:'index',params:[id:bookInfoInstance.id])

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

        bookInfoInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BookInfo.label', default: 'BookInfo'), bookInfoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
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
