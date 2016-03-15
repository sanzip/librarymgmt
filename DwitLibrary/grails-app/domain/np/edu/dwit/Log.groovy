package np.edu.dwit


class Log {

    Member by
    Borrow borrow
    Member to
    String actionType

    static constraints = {

        by nullable: false
        borrow nullable: false
        actionType inList: [Configure.ACTION_TYPE_ISSUE, Configure.ACTION_TYPE_RETURN], nullable: false, blank: false
    }
    static mapping = {

        version false
    }
}
