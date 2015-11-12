package np.edu.dwit

import grails.plugin.springsecurity.annotation.Secured

class FineController {
//student name, borrowed book, book number, borrowed date, return date, fine day, fine amount, Mail

    def fineService

    @Secured("ROLE_LIBRARIAN")
    def report() {

        def borrowsWithFine = fineService.report

        def messageType
        if(borrowsWithFine.size() == 0) {
            flash.message = "There are no records to show"
            messageType = 'error'
        }

        [borrowsWithFine: borrowsWithFine, params:[messageType: messageType]]
    }

    @Secured("ROLE_LIBRARIAN")
    def sendEmail(){

        def member = Member.findById(params?.memberId as Long)

        def bodyOfEmail = "\nHello ${member.fullName.split(' ')[0]},\n" +
                "\t";

        sendMail {

            async true
            to member.email
            subject "Library: Fine Overdue"
            text bodyOfEmail
        }

        flash.message = "Email Sent to ${member.fullName}."
    }
}
