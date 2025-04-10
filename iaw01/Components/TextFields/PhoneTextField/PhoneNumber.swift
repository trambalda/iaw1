import Foundation

struct PhoneNumber {
    let number: String?
    let countryCode: CountryCodeModel?
    
    var fullNumber: String {
        guard let number = number else { return "" }
        if let code = countryCode?.code {
            return code + number
        } else {
            return number
        }
    }
    
    static let `default` = PhoneNumber(number: nil, countryCode: .default)
}


