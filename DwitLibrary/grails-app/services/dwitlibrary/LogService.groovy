package dwitlibrary

import grails.transaction.Transactional
import np.edu.dwit.Borrow
import np.edu.dwit.Log
import np.edu.dwit.Member

@Transactional
class LogService {

    def saveLog(Member by, Borrow borrow, String actionType) {

        Log log = new Log()

        log.by = by
        log.borrow = borrow
        log.actionType = actionType

        log.save(failOnError: true)
    }
}
