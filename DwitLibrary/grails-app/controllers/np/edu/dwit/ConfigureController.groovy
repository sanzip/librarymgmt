package np.edu.dwit

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured("ROLE_LIBRARIAN")
class ConfigureController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Configure.list(params), model: [configureInstanceCount: Configure.count()]
    }

    def show(Configure configureInstance) {
        respond configureInstance
    }
def test(){

}
    def create() {
        respond new Configure(params)
    }

    @Transactional
    def save(Configure configureInstance) {
        if (configureInstance == null) {
            notFound()
            return
        }

        if (configureInstance.hasErrors()) {
            respond configureInstance.errors, view: 'create'
            return
        }

        configureInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'configureInstance.label', default: 'Configure'), configureInstance.id])
                redirect configureInstance
            }
            '*' { respond configureInstance, [status: CREATED] }
        }
    }

    def edit(Configure configureInstance) {
        respond configureInstance
    }

    @Transactional
    def update(Configure configureInstance) {
        if (configureInstance == null) {
            notFound()
            return
        }

        if (configureInstance.hasErrors()) {
            respond configureInstance.errors, view: 'edit'
            return
        }

        configureInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Configure.label', default: 'Configure'), configureInstance.id])
                redirect configureInstance
            }
            '*' { respond configureInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Configure configureInstance) {

        if (configureInstance == null) {
            notFound()
            return
        }

        configureInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Configure.label', default: 'Configure'), configureInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'configureInstance.label', default: 'Configure'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
