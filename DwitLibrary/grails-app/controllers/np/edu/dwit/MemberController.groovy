package np.edu.dwit

import grails.transaction.Transactional
import org.json.simple.JSONArray
import org.json.simple.JSONObject
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.NO_CONTENT

@Transactional(readOnly = true)
class MemberController {
    def springSecurityService
    def memberService
    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def index() {
        if (springSecurityService.loggedIn) {
            def currentUser = memberService.getCurrentUser()
            session["userName"] = currentUser.username
            List<Configure> configureList = Configure.list()
            if(configureList.empty){
                redirect(controller: 'Configure', action: 'edit')
            }
            else {
                redirect(controller:'Member', action:'dashboard')
            }
        }
        else {
            redirect(controller:'login', action:'index')
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def dashboard() {
        Configure configure = Configure.get(1);
        String role = springSecurityService.getPrincipal().getAuthorities();
        def maxBorrowCount=3;
        if (role.contains("ROLE_STUDENT")){
            maxBorrowCount = configure.courseBookBorrowableStudent;
        }
        else if (role.contains("ROLE_ADMIN")){
            maxBorrowCount = configure.courseBookBorrowableAdmin;
        }
        else if (role.contains("ROLE_FACULTY")){
            maxBorrowCount = configure.courseBookBorrowableFaculty;
        }
        else if(role.contains("ROLE_LIBRARIAN")){
            maxBorrowCount = configure.courseBookBorrowableLibrarian;
        }
        def count = memberService.getBorrowedBookCount()
        def bookList = memberService.getBookList()
        render (view: "dashboard", model:[list: bookList, listCount:bookList.size(), count: (maxBorrowCount-count.size())])
    }


    @Secured(['ROLE_ADMIN', 'ROLE_STUDENT', 'ROLE_FACULTY'])
    def history(){

        def currentUser = springSecurityService.currentUser
        def member = memberService.getCurrentUser()
        if(!member.username.equalsIgnoreCase(currentUser.username)){
            flash.message = "Sorry, you're not authorized to view this page."
            redirect(action: 'index')
        }

        [history : memberService.getHistory(member)]
    }

    @Secured("ROLE_LIBRARIAN")
    def search(){

        def max = 7
        String query = params?.query
        def states =  params?.states
        states = states.split(',')
        render memberService.searchMember(query,states,max)
    }

    @Secured("ROLE_LIBRARIAN")
    def list(Integer max){
        respond Member.list(), model: [memberInstanceCount: Member.count()]
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
    def configDetails(){

    }
    @Secured("ROLE_LIBRARIAN")
    @Transactional
    def save(Member memberInstance) {
        def message = memberService.saveMember(memberInstance,params.role,true)
        if(message.equals('success')){
            flash.message ='New User created'
            redirect( action: 'list' ,params: [messageType: 'success'])
        }
        else{
            message=message.split(',')
            flash.message = message[0]
            respond memberInstance, view: 'create', params: [messageType: message[1]]

        }
    }

    @Secured("ROLE_LIBRARIAN")
    def edit(Member memberInstance) {
        respond memberInstance
    }

    @Secured("IS_AUTHENTICATED_FULLY")
    def editPassword() {
        render(view: "editPassword")
    }

    @Secured("IS_AUTHENTICATED_FULLY")
    @Transactional
    def updatePassword(){
        def member = memberService.getCurrentUser()

        def status=memberService.validPassword(member,params.password,params.npassword,params.rpassword)

        if(status.equals('valid')){
            status=memberService.updatePassword(member,params.npassword)
            status = status.split(',')
            flash.message = status[0]
            redirect( action: 'dashboard', params: [messageType: status[1]])
        }
        else {
            flash.message = status
            redirect( action: 'editPassword', params: [messageType: 'error'])
        }
    }
    @Secured("ROLE_LIBRARIAN")
    @Transactional
    def update(Member memberInstance) {
        def message = memberService.saveMember(memberInstance,params.role,false)
        if (message.equals('success')){
            flash.message ='User updated'
            redirect( action: 'list' ,params: [messageType: 'success'])
        }
        else{
            message=message.split(',')
            flash.message = message[0]
            respond memberInstance, view: 'edit', params: [messageType: message[1]]
        }
    }

    @Secured("ROLE_LIBRARIAN")
    @Transactional
    def delete(Member memberInstance) {

        if (memberInstance == null) {
            notFound()
            return
        }

        def userRole = UserRole.findByUser(memberInstance)
        def borrower = Borrow.findAllByMember(memberInstance)
        def timeStamp
        def log
        def fine
        def messageType
        for (Borrow borrowInstance: borrower){
            if (borrowInstance.returned){
                timeStamp = TimeStamp.findAllByBorrow(borrowInstance)
                log = Log.findAllByBorrow(borrowInstance)
                fine=Fine.findAllByMember(memberInstance)
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
                if (!fine.empty){
                    for(Fine fineInstance:fine){
                        fineInstance.delete(flush: true)
                    }
                }
                borrowInstance.delete(flush: true)
            }
            else {
                flash.message='User has not returned some books. Delete failed'
                return redirect( action: 'list' ,params: [messageType: 'error'])
            }
        }


        userRole.delete flush: true

        memberInstance.delete(flush: true)
        flash.message='User successfully deleted.'
        messageType = 'success'
        redirect( action: 'list' ,params: [messageType: 'success'])

/*        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Member.label', default: 'Member'), memberInstance.id])
                redirect action: "list", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }*/
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
