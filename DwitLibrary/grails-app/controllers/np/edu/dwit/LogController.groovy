package np.edu.dwit

import constants.DWITLibraryConstants
import grails.plugin.springsecurity.annotation.Secured

@Secured("ROLE_LIBRARIAN")
class LogController {

    def viewIssues() {

        def issueLogs = Log.findAllByActionType(DWITLibraryConstants.ACTION_TYPE_ISSUE)

        def messageType = ""
        if(issueLogs.size() == 0){

            messageType = "error"
            flash.message = "No records to show"
        }

        [issueLogs: issueLogs, params: [messageType: messageType]]
    }

    def viewReturns(){

        def returnLogs = Log.findAllByActionType(DWITLibraryConstants.ACTION_TYPE_RETURN)

        def messageType = ""
        if(returnLogs.size() == 0){

            messageType = "error"
            flash.message = "No records to show"
        }

        [returnLogs: returnLogs, params: [messageType: messageType]]
    }
}
