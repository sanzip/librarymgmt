package np.edu.dwit

class Book {
    String name
    String author
    String publication
    Integer availableQuantity
    Integer totalQuantity


    static constraints = {
        name blank: false, nullable: false
        author blank: false, nullable: false
        publication blank: false, nullable: false

        availableQuantity nullable: true
        totalQuantity nullable: true
    }
    static mapping = {
        version false
    }
}
