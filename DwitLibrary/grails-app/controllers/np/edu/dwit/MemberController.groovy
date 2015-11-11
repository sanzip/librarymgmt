package np.edu.dwit

import grails.converters.JSON
import grails.transaction.Transactional
import org.json.simple.JSONArray
import org.json.simple.JSONObject
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class MemberController {
    def springSecurityService
    def memberService
    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def index() {
        println(springSecurityService.isLoggedIn())
        if (springSecurityService.loggedIn) {
            def role = springSecurityService.getAuthentication().authorities.toString()
            def currentUser = User.findById(springSecurityService.principal.id)
            println("current user:"+currentUser)
            println("=========="+role.substring(6,9))
            redirect(controller:'Member', action:'dashboard')

        }
        else {
            redirect(controller:'login', action:'index')
        }

    }

    @Secured(['ROLE_LIBRARIAN', 'ROLE_ADMIN', 'ROLE_STUDENT', 'ROLE_FACULTY'])
    def dashboard() {
        def currentUser= Member.findById(springSecurityService.principal.id)
        def count = Borrow.findAllByMemberAndReturned(currentUser, false);
        def bookList = Book.list();
        render (view: "dashboard", model:[list: bookList, count: (3-count.size())])
    }


    @Secured(['ROLE_ADMIN', 'ROLE_STUDENT', 'ROLE_FACULTY'])
    def history(){

        def currentUser = springSecurityService.currentUser
        def member = Member.findByUsername(currentUser)
        if(!member.username.equalsIgnoreCase(currentUser.username)){
            flash.message = "Sorry, you're not authorized to view this page."
            redirect(action: 'index')
        }
        [history : memberService.getHistory(member)]
    }

    @Secured("ROLE_LIBRARIAN")
    def search(){

        String query = params?.query
        def states =  params?.states
        states = states.split(',')
        if (query.length() > 0) {
            def probableMembers = Member.findAllByFullNameIlike(query + '%')
            JSONArray jsonArray = new JSONArray()
            for(Member member : probableMembers) {
                JSONObject jsonObject = new JSONObject()
                if(!states.contains(member.fullName)) {
                    jsonObject.put("fullName", member.fullName)
                    jsonArray.add(jsonObject)
                }
            }
            if(jsonArray.size() > 0)
                render jsonArray.toJSONString()
        }
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
        memberInstance.fullName=memberInstance.fullName/*+"-"+memberInstance.userId*/

        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+memberInstance.fullName)
        def fName = memberInstance.fullName.toLowerCase().split(" ")
        memberInstance.username=fName[0]+"_"+memberInstance.userId
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
                redirect action: "list", method: "GET"
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
