package np.edu.dwit

class Book {
    String name
    String author
    String publication
    Integer availableQuantity
    Integer totalQuantity
    String bookType

    BookInfo bookInfo

    static constraints = {
        name blank: false, nullable: false
        author blank: false, nullable: false
        publication blank: false, nullable: false
        availableQuantity nullable: false
        totalQuantity nullable: false
        bookType nullable: false, blank: false, inList: ['Reference', 'Gifted', 'Borrowable', 'Novel']
    }
    static mapping = {
        version false
    }
}
