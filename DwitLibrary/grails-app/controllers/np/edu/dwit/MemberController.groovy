package np.edu.dwit

import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class MemberController {
    def springSecurityService
    def memberService
    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def index() {
        println(springSecurityService.isLoggedIn())
        if (springSecurityService.isLoggedIn()) {
            def role = springSecurityService.getAuthentication().authorities.toString()
            def currentUser = User.findById(springSecurityService.principal.id)
            println("current user:"+currentUser)
            println("=========="+role.substring(6,9))
            redirect(controller:'Member', action:'dashboard', params: [id: springSecurityService.principal.id])

        }
        else {
            redirect(controller:'login', action:'index')
        }

    }

    @Secured("permitAll")
    def dashboard() {
        def currentUser= User.findById(springSecurityService.principal.id)
        def count = Book.executeQuery("SELECT COUNT(b.id) from Borrow b where b.member = ? and b.returned = true",currentUser);
        def bookList = Book.list();
        render (view: "dashboard", model:[list: bookList, count: count[0]])
    }


    @Secured("permitAll")
    def history(){

        def member = Member.findById(params?.id as Long)
        def currentUser = springSecurityService.currentUser
        if(!member.username.equalsIgnoreCase(currentUser.username)){
            flash.message = "Sorry, you're not authorized to view this page."
            redirect(action: 'index')
        }
        [history : memberService.getHistory(member)]
    }

    @Secured("ROLE_LIBRARIAN")

    def list(Integer max){
        params.max = Math.min(max ?: 10, 100)
        respond Member.list(params), model: [memberInstanceCount: Member.count()]
    }

    @Secured("ROLE_LIBRARIAN")

    def show(Member memberInstance) {
        respond memberInstance
    }
    @Secured("ROLE_LIBRARIAN")
    def create() {
        respond new Member(params)
    }

    @Secured("ROLE_LIBRARIAN")
    @Transactional
    def save(Member memberInstance) {
        if (memberInstance == null) {
            notFound()
            return
        }

        if (memberInstance.hasErrors()) {
            respond memberInstance.errors, view: 'create'
            return
        }

        memberInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'memberInstance.label', default: 'Member'), memberInstance.id])
                redirect memberInstance
            }
            '*' { respond memberInstance, [status: CREATED] }
        }
    }

    @Secured("ROLE_LIBRARIAN")
    def edit(Member memberInstance) {
        respond memberInstance
    }

    @Secured("ROLE_LIBRARIAN")
    @Transactional
    def update(Member memberInstance) {
        if (memberInstance == null) {
            notFound()
            return
        }

        if (memberInstance.hasErrors()) {
            respond memberInstance.errors, view: 'edit'
            return
        }

        memberInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Member.label', default: 'Member'), memberInstance.id])
                redirect memberInstance
            }
            '*' { respond memberInstance, [status: OK] }
        }
    }

    @Secured("ROLE_LIBRARIAN")
    @Transactional
    def delete(Member memberInstance) {

        if (memberInstance == null) {
            notFound()
            return
        }

        memberInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Member.label', default: 'Member'), memberInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'memberInstance.label', default: 'Member'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
