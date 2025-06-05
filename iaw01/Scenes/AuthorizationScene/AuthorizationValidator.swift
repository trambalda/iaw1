import Foundation

enum ValidationContext {
    case auth
    case register
}

struct Validatior {
    
    static func validate(
        name: String?,
        phone: String?,
        email: String,
        password: String,
        context: ValidationContext
    ) -> String? {
        if context == .register {
            
            guard let name = name?.trimmingCharacters(in: .whitespacesAndNewlines) else { return "Введите имя"}
            let letterCount = name.filter { $0.isLetter }.count
            if letterCount < 2 {
                return "Имя должно содержать хотя бы 2 буквы"
            }
            
            guard let phone = phone else { return "Введите номер телефона" }
            let digitsOnly = phone.filter { $0.isNumber }
            if let country = CountryCodeModel.countryCodes.first(where: {
                digitsOnly.hasPrefix($0.code.filter { $0.isNumber })
            }) {
                let requiredDigits = country.mask.filter { $0 == "#" }.count
                let expectedTotalDigits = country.code.filter { $0.isNumber }.count + requiredDigits
                guard digitsOnly.count == expectedTotalDigits else {
                    return "Телефон должен содержать \(requiredDigits) цифр"
                }
            } else if digitsOnly.count < 8 {
                return "Введите корректный номер телефона"
            }
            
            let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
            if !NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) {
                return "Не корректный формат емейла"
            }
            
            let passwordMinLength = 8
            if password.count < passwordMinLength {
                return "Короткий пароль, он должен содержать не менее 8 символов"
            }
            
            let passwordMaxLength = 64
            if password.count > passwordMaxLength {
                return "Привышено допустимое количество символов"
            }
            
            let uppercaseSet = CharacterSet.uppercaseLetters
            if password.rangeOfCharacter(from: uppercaseSet) == nil {
                return "Пароль должен содержать хотя бы 1 заглавную букву"
            }
            
            let specialCharactersSet = CharacterSet(charactersIn: "!@#$%^&*()_+-={}[]|:;\"'<>,.?/~`")
            if password.rangeOfCharacter(from: specialCharactersSet) == nil {
                return "Пароль должен содержать хотя бы 1 специальный символ "
            }
        }
        return nil
    }
}
