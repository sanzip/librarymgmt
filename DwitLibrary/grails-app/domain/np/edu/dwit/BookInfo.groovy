package np.edu.dwit

/**
 * Created by zephyr on 11/8/15.
 */
class BookInfo {
    Book book
    String bookNumber
    String edition
    String publishedYear
    String pages
    Double cost
    String source
    String bookType

    static constraints = {
        book blank: false, nullable: false
        bookNumber blank: false, nullable: false
        edition blank: true, nullable: true
        publishedYear blank: false, nullable: false
        pages blank: false, nullable: false
        cost blank:false, nullable: false
        source blank: false, nullable: false
        bookType nullable: false, blank: false, inList: ['Borrowable', 'Gifted', 'Reference', 'Novel']

    }
    static mapping = {
        version false
    }
}
