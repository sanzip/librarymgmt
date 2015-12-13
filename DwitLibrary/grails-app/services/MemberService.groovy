

import grails.transaction.Transactional
import np.edu.dwit.Book
import np.edu.dwit.Borrow
import np.edu.dwit.Fine
import np.edu.dwit.Member
import np.edu.dwit.Role
import np.edu.dwit.User
import np.edu.dwit.UserRole
import org.json.simple.JSONArray
import org.json.simple.JSONObject

@Transactional
class MemberService {
   def springSecurityService
   def getCurrentUser(){
       return User.findById(springSecurityService.principal.id)
   }
    def getBorrowedBookCount(){
        def currentUser= getCurrentUser()
        return Borrow.findAllByMemberAndReturned(currentUser, false)
    }

    def getBookList(){
        return Book.list();
    }

    def getProbableMembers(def query){
        return Member.findAllByFullNameIlike(query + '%')
    }

    def searchMember(String query, def states, def max){
        if (query.length() > 0) {
            def probableMembers = getProbableMembers(query)
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
            if(jsonArray.size() > 0) {
                return jsonArray.toJSONString()
            }
        }
    }
    def mailMember(Member memberInstance){
        def bodyOfEmail = "\nHello $memberInstance.fullName,\n\nYour account has been created on GyanSangalo.\n\nYour credentials are: \n" +
                "\n\tUsername: $memberInstance.username\n\tPassword: $memberInstance.password\nYou can change this password right after you login.\n\nThanks,\nThe DWIT Library.";


        sendMail {

            async true
            to memberInstance.email
            subject "GyanSangalo: User Credentials"
            text bodyOfEmail
        }
    }
    def saveMember(Member memberInstance, String role, boolean newMember){
        def member = Member.findByUserId(memberInstance.userId)
        if (member&&newMember){
            return 'User Id already exists,error'
        }
        else {
            def  fullName
            if(newMember){
                fullName=memberInstance.fullName
                memberInstance.fullName=fullName+" -"+memberInstance.userId
                def fName = fullName.toLowerCase().split(' ')
                memberInstance.username=fName[0]+"_"+memberInstance.userId
            }
            else if(!newMember){
                fullName=memberInstance.fullName.split(' ')
                memberInstance.fullName=fullName[0]+' '+fullName[1]+' -'+memberInstance.userId
                memberInstance.username=fullName[0]+'_'+memberInstance.userId
            }

            if (!memberInstance.save(flush: true,failOnError: true)) {
                return 'Unable to save new User,error'
            }
            if  (!memberInstance.authorities.contains( Role.findByAuthority(role))) {
                if (!newMember){
                    def userRole = UserRole.findByUser(memberInstance)
                    userRole.delete flush: true
                }
                UserRole.create memberInstance, Role.findByAuthority(role)

            }
            if(newMember){
                mailMember(memberInstance)
            }
            return 'success'
        }
    }

    def validPassword(def member, def password, def newPassword, def newPassword2)
    {
        if (!springSecurityService.passwordEncoder.isPasswordValid(member.password, password, null /*salt*/)) {
            return 'Invalid current password'
        }

        if (newPassword != newPassword2) {
            return 'New password doesn\'t match'
        }

        if (springSecurityService.passwordEncoder.isPasswordValid(member.password, newPassword, null /*salt*/)) {
            return 'New password is same as current password'
        }
        return 'valid'
    }


    def updatePassword(def member, def newPassword){
        member.password = newPassword
        if(!member.save(flush: true, failOnError: true)){
            return 'Unable to change password,error'
        }
        else {
            return 'Password changed,success'
        }
    }

    def getHistory(Member member) {


        def borrowedBooks = Borrow.createCriteria().list {

            eq('member', member)
            order('returned')
        }
        def fines = Fine.findAllByBorrowInList(borrowedBooks);

        Map<Borrow, Double> history = new HashMap<>()

        for (int i = 0; i < borrowedBooks.size(); i++){

            Borrow borrow = borrowedBooks.get(i)
            Fine fine
            try {
                fine = fines.get(i)
                history.put(borrow, fine.fineAmount)
            }catch(IndexOutOfBoundsException e) {
                history.put(borrow, null)
            }
        }

        return history
    }
}
