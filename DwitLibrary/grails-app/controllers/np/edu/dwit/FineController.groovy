package np.edu.dwit

import grails.plugin.springsecurity.annotation.Secured

class FineController {
//student name, borrowed book, book number, borrowed date, return date, fine day, fine amount, Mail

    def fineService

    @Secured("ROLE_LIBRARIAN")
    def report() {

        def borrowsWithFine = fineService.report

        def messageType
        if(!borrowsWithFine) {
            flash.message = "There are no records to show"
            messageType = 'error'
        }

        [borrowsWithFine: borrowsWithFine, params:[messageType: messageType]]
    }

    @Secured("ROLE_LIBRARIAN")
    def sendEmail(){

        def member = Member.findById(params?.memberId as Long)

        Borrow borrow = Borrow.findById(params?.borrowId as Long)
        Fine fine = fineService.calculatefine(borrow)

        def bodyOfEmail = "\nHello ${member.fullName.split(' ')[0]},\n" +
                "\t${borrow.bookInfo.book.name} book you borrowed has crossed the deadline. Your total fine as of today is ${fine.fineAmount}." +
                "\n\tPlease return the book soon.\nRegards,\nThe DWIT Library";

        sendMail {

            async true
            to member.email
            subject "Library: Fine Overdue"
            text bodyOfEmail
        }
    }
}
