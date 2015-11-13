package np.edu.dwit

import constants.DWITLibraryConstants

class Log {

    Member by
    Borrow borrow
    Member to
    String actionType

    static constraints = {

        by nullable: false
        borrow nullable: false
        actionType inList: [DWITLibraryConstants.ACTION_TYPE_ISSUE, DWITLibraryConstants.ACTION_TYPE_RETURN], nullable: false, blank: false
    }
    static mapping = {

        version false
    }
}
