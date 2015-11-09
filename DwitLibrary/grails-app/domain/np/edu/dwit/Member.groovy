package np.edu.dwit

class Member extends User {
    String email
    String contact
    String status
    String fullName

    static constraints = {

        email nullable: true, blank: true
        contact nullable: true, blank: true
        status nullable: true, blank: true
        fullName nullable: true,blank: true
    }

    Member(String username, String password) {
        super(username, password)
    }
}
