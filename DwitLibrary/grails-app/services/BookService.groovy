

import grails.transaction.Transactional
import np.edu.dwit.Book
import np.edu.dwit.BookInfo
import np.edu.dwit.Borrow

@Transactional
class BookService {

    def getBooksWithBorrowCount() {

        Map booksWithBorrowCount = new HashMap()

        for (Book book: Book.all)
            booksWithBorrowCount.put(book, Borrow.countByBookInfo(BookInfo.findAllByBook(book)))

        TreeMap sortedBooksWithBorrowCount = new TreeMap(new BookMapComparator(booksWithBorrowCount));
        sortedBooksWithBorrowCount.putAll(booksWithBorrowCount);

        return sortedBooksWithBorrowCount
    }
}