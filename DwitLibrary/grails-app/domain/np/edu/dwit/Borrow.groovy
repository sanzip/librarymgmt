package np.edu.dwit

class Borrow {

    BookInfo bookInfo
    Date borrowedDate = new Date()
    Boolean returned = false
    Member member
    Date returnedDate

    static constraints = {

        bookInfo nullable: false
        borrowedDate nullable: false
        member nullable: false
        returnedDate nullable: true
    }

    static mapping = {

        version false
    }
}
