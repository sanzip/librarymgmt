package np.edu.dwit

import grails.plugin.springsecurity.annotation.Secured

class FineController {
//student name, borrowed book, book number, borrowed date, return date, fine day, fine amount, Mail

    def fineService

    @Secured("ROLE_LIBRARIAN")
    def report() {

        [borrowsWithFine: fineService.report]
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
