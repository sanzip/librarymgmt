import np.edu.dwit.Book

/**
 * Created by asimsangram on 11/11/15.
 */
class BookMapComparator implements Comparator<Book> {
    Map<Book, Integer> base;

    public BookMapComparator(Map<Book, Integer> base) {
        this.base = base;
    }

    public int compare(Book a, Book b) {
        if (base.get(a) >= base.get(b)) {
            return -1;
        } else {
            return 1;
        }
    }
}
