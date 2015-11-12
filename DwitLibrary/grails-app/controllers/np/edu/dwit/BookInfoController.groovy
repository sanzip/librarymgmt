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

        def book = np.edu.dwit.Book.findById(params.id)

        def bookInfo = np.edu.dwit.BookInfo.findAllByBook(book)

        println bookInfo.bookNumber
        render view: 'index', model:[bookInfoInstanceList:bookInfo,bookInfoInstanceCount: bookInfo.size() ]

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
        assert bookNumber.size()
        for(int i=0;i<bookNumber.size();i++){

            /*For Developers: This is working block of code but this code needs to be refactored*/

            if(BookInfo.findByBookNumber((String)bookNumber[i])==null){
                BookInfo bookInfo = new BookInfo()
                bookInfo.bookNumber=bookNumber[i]
                bookInfo.book=bookInfoInstance.book
                bookInfo.cost=bookInfoInstance.cost
                bookInfo.edition=bookInfoInstance.edition
                bookInfo.pages=bookInfoInstance.pages
                bookInfo.publishedYear=bookInfoInstance.publishedYear
                bookInfo.source=bookInfoInstance.source
                bookInfo.bookType=bookInfoInstance.bookType
                bookInfo.save(flush: true,failOnError: true)
            }

        }
        redirect(controller: "bookInfo", action: "index", params: [id: params.book.id])
      /*  bookInfoInstance.save flush:true*/

      /*  redirect(controller: "bookInfo", action: "index", params: [id: params.book.id])*/
        /*request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'bookInfoInstance.label', default: 'BookInfo'), bookInfoInstance.id])
                redirect bookInfoInstance
            }
            '*' { respond bookInfoInstance, [status: CREATED] }
        }*/
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

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BookInfo.label', default: 'BookInfo'), bookInfoInstance.id])
                redirect bookInfoInstance
            }
            '*'{ respond bookInfoInstance, [status: OK] }
        }
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
