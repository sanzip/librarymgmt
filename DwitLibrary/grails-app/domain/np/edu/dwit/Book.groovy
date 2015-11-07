package np.edu.dwit

class Book {
    String name
    String author
    Integer bookNumber
    Integer availableQuantity
    Integer totalQuantity
    String bookType

    static constraints = {
        name blank: false, nullable: false
        author blank: false, nullable: false
        bookNumber nullable: false
        availableQuantity nullable: false
        totalQuantity nullable: false
        bookType nullable: false, blank: false, inList: ['Reference', 'Gifted', 'Bought']
    }
    static mapping = {
        version false
    }
}
