import Foundation

struct PhoneNumber {
    let number: String?
    let countryCode: String?
    
    var fullNumber: String? {
        guard let number = number, let countryCode = countryCode else { return nil }
        return countryCode + number
    }
}


