import Foundation

struct PhoneNumber {
    let number: String?
    let countryCode: CountryCodeModel?
    
    var fullNumber: String {
        [countryCode?.code, number].compactMap { $0 }.joined()
    }
    
    static let `default` = PhoneNumber(number: nil, countryCode: .default)
}


