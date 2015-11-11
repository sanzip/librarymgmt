import np.edu.dwit.Borrow
import np.edu.dwit.Fine

/**
 * Created by asimsangram on 11/11/15.
 */
class BorrowMapComparator implements Comparator<Borrow> {
    Map<Borrow, Fine> base;

    public BorrowMapComparator(Map<Borrow, Fine> base) {
        this.base = base;
    }

    public int compare(Borrow a, Borrow b) {
        if (base.get(a).fineAmount >= base.get(b).fineAmount) {
            return -1;
        } else {
            return 1;
        }
    }
}
