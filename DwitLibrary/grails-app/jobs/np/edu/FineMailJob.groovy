package np.edu


class FineMailJob {

    def bookService

    static triggers = {
      simple repeatInterval: 60000 * 60 * 24l  //execute job once in 24 hours
    }

    def execute() {

        println "Mailing members with return date day after tomorrow"
        bookService.mailMembersWithBooksBorrowsWithReturnDateParsi()
    }
}
