import Foundation

struct AuthorizationModel {
    let email: String?
    let password: String?
    let name: String?
    let phone: String?
    
    var isLoginModelFilled: Bool {
        !(email?.isEmpty ?? true) &&
        !(password?.isEmpty ?? true)
    }
    
    var isSignUpModelFilled: Bool {
        !(name?.isEmpty ?? true) &&
        !(phone?.isEmpty ?? true) &&
        !(password?.isEmpty ?? true)
    }
}
