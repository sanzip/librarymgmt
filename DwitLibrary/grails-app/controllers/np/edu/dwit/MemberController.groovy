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
        println(springSecurityService.isLoggedIn())
        if (springSecurityService.loggedIn) {
            def role = springSecurityService.getAuthentication().authorities.toString()
            def currentUser = User.findById(springSecurityService.principal.id)
            session["userName"] = currentUser.username
            redirect(controller:'Member', action:'dashboard')
        }
        else {
            redirect(controller:'login', action:'index')
        }

    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def dashboard() {

        def currentUser= Member.findById(springSecurityService.principal.id)
        def count = Borrow.findAllByMemberAndReturned(currentUser, false)
        params.max = Math.min(params.max ?: 10, 100)
        def bookList = Book.list(params);
        render (view: "dashboard", model:[list: bookList, listCount:bookList.size(), count: (3-count.size())])
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

        def max = 7
        String query = params?.query
        def states =  params?.states
        states = states.split(',')
        if (query.length() > 0) {
            def probableMembers = Member.findAllByFullNameIlike(query + '%')
            JSONArray jsonArray = new JSONArray()
            int i = 0
            for(Member member : probableMembers) {
                JSONObject jsonObject = new JSONObject()
                if(!states.contains(member.fullName)) {
                    jsonObject.put("fullName", member.fullName)
                    jsonArray.add(jsonObject)
                }
                if(i++ == max)
                    break;
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
    def configDetails(){

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
        memberInstance.fullName=memberInstance.fullName/*+"-"+memberInstance.userId*/ /*>>>>This code creates issue*/

        def fName = memberInstance.fullName.toLowerCase().split(" ")
        memberInstance.username=fName[0]+"_"+memberInstance.userId
        params.role

        def bodyOfEmail = "\nHello $memberInstance.fullName,\n\nYour account has been created on Library Management System.\n\nYour credentials are: \n" +
                "\n\tUsername: $memberInstance.username\n\tPassword: $memberInstance.password\nYou can change this password right after you login.\n\nThanks,\nThe DWIT Library.";

        if (!memberInstance.save(flush: true,failOnError: true)) {
            flash.message ='Unable to save new User'
            def messageType = 'success'
            render view: "create", model: [userInstance: memberInstance], params: [messageType: messageType]
            return
        }
        if  (!memberInstance.authorities.contains( Role.findByAuthority(params.role))) {
            UserRole.create memberInstance, Role.findByAuthority(params.role)
        }

        sendMail {

            async true
            to memberInstance.email
            subject "LMS: User Credentials"
            text bodyOfEmail
        }
        flash.message ='New User saved'
        def messageType = 'success'
        redirect( action: 'list' ,params: [messageType: messageType])
        /*request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'memberInstance.label', default: 'Member'), memberInstance.id])
                redirect memberInstance

            }
            '*' { respond memberInstance, [status: CREATED] }

        }*/
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
        def memberInstance = User.findById(springSecurityService.principal.id)
        if (memberInstance == null) {
            notFound()
            return
        }
        def password = params.password
        def newPassword = params.npassword
        def newPassword2= params.rpassword
        def messageType

        if (!password || !newPassword || !newPassword2 || newPassword != newPassword2) {
            flash.message = 'Please enter your current password and a valid new password'
            messageType = 'error'
            redirect( action: 'editPassword', params: [messageType: messageType])
            return
        }

        if (!springSecurityService.passwordEncoder.isPasswordValid(memberInstance.password, password, null /*salt*/)) {
            flash.message =  'Current password is incorrect'
            messageType = 'error'
            redirect( action: 'editPassword', params: [messageType: messageType])
            return
        }

        if (springSecurityService.passwordEncoder.isPasswordValid(memberInstance.password, newPassword, null /*salt*/)) {
            flash.message = 'Please choose a different password from your current one'
            messageType = 'error'
            redirect( action: 'editPassword', params: [messageType: messageType])
            return
        }
        memberInstance.password = newPassword
        memberInstance.save flush: true, failOnError: true
        flash.message = 'Password changed.'
        messageType = 'success'
        redirect( action: 'dashboard', params: [messageType: messageType])
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

        memberInstance.save flush: true, failOnError: true
        flash.message = 'User updated'
        def messageType = 'success'
        redirect action:  'list' ,params: [messageType: messageType]

//        request.withFormat {
//            form {
//                flash.message = message(code: 'default.updated.message', args: [message(code: 'Member.label', default: 'Member'), memberInstance.id])
//                redirect memberInstance
//            }
//            '*' { respond memberInstance, [status: OK] }
//        }
    }

    @Secured("ROLE_LIBRARIAN")
    @Transactional
    def delete(Member memberInstance) {

        if (memberInstance == null) {
            notFound()
            return
        }

        def userRole = UserRole.findByUser(memberInstance)

        userRole.delete flush: true
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
