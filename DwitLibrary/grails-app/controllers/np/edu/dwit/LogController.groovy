package np.edu.dwit

import grails.plugin.springsecurity.annotation.Secured

@Secured("ROLE_LIBRARIAN")
class LogController {

    def viewIssues() {

        def issueLogs = Log.findAllByActionType(Configure.ACTION_TYPE_ISSUE)

        def messageType = ""
        if(issueLogs.size() == 0){

            messageType = "error"
            flash.message = "No records to show"
        }

        [issueLogs: issueLogs, params: [messageType: messageType]]
    }

    def viewReturns(){

        def returnLogs = Log.findAllByActionType(Configure.ACTION_TYPE_RETURN)
        def fineAmount = Fine.findAllByBorrow(returnLogs.borrow)

        def messageType = ""
        if(returnLogs.size() == 0){

            messageType = "error"
            flash.message = "No records to show"
        }

        [returnLogs: returnLogs,fineAmt: fineAmount, params: [messageType: messageType]]
    }
}
