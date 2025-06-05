import Foundation

struct AuthorizationModel {
    let email: String?
    let password: String?
    let name: String?
    let phone: String?
    
    static let empty = AuthorizationModel(email: nil, password: nil, name: nil, phone: nil)
    
    var isLoginModelFilled: Bool {
        email.notNilNotEmpty &&
        password.notNilNotEmpty
    }
    
    var isSignUpModelFilled: Bool {
        name.notNilNotEmpty &&
        phone.notNilNotEmpty &&
        email.notNilNotEmpty &&
        password.notNilNotEmpty
    }
}

extension AuthorizationDto {
    var model: AuthorizationModel  {
        AuthorizationModel(
            email: email,
            password: password,
            name: name,
            phone: phone
        )
    }
}
