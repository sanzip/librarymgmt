

import grails.transaction.Transactional
import np.edu.dwit.Book
import np.edu.dwit.BookInfo
import np.edu.dwit.Borrow

@Transactional
class BookService {

    def getBooksWithBorrowCount() {

        Map sortedBooksWithBorrowCount = new HashMap()

        for (Book book: Book.all)
            sortedBooksWithBorrowCount.put(book, Borrow.countByBookInfoInList(BookInfo.findAllByBook(book)))

        return sortedBooksWithBorrowCount
    }
}