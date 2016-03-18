import np.edu.dwit.User
import np.edu.dwit.Member
import np.edu.dwit.Role
import np.edu.dwit.UserRole


class BootStrap {

    def init = { servletContext ->
        def memberCount = Member.findAll().size();
        if(!memberCount){
            Member admin = new Member(username:'admin',password:'admin',email:'admin@deerwalk.edu.np',contact:'9841000000',fullName:'Admin admin-0101',userId:'01',enabled:true).save(failOnError: true)
            Member faculty = new Member(username:'faculty',password:'faculty',email:'faculty@deerwalk.edu.np',contact:'9841000000',fullName:'Faculty faculty-0102',userId:'02',enabled: true).save(failOnError: true)
            Member student = new Member(username:'student',password:'student',email:'student@deerwalk.edu.np',contact:'9841000000',fullName:'Student student-0101',userId:'0101',enabled: true).save(failOnError: true)
            Member librarian = new Member(username:'l',password:'l',email:'librarian@deerwalk.edu.np',contact:'9841000000',fullName:'Librarian librarian-03',userId:'03',enabled: true).save(failOnError: true)
            def roleCount = Role.findAll().size();
            if(!roleCount){
                Role role_admin = new Role(authority: 'ROLE_ADMIN').save()
                Role role_faculty = new Role(authority: 'ROLE_FACULTY').save()
                Role role_student = new Role(authority: 'ROLE_STUDENT').save()
                Role role_librarian = new Role(authority: 'ROLE_LIBRARIAN').save()
                def userRole = UserRole.findAll().size();
                if(!userRole){
                    UserRole.create(admin,role_admin)
                    UserRole.create(faculty,role_faculty)
                    UserRole.create(student,role_student)
                    UserRole.create(librarian,role_librarian)
                }
            }
        }
    }
    def destroy = {
    }
}
