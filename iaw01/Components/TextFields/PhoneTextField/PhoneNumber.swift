import Foundation

struct PhoneNumber {
    let number: String?
    let countryCode: String?
    
    var fullNumber: String? {
        guard let number = number else { return "" }
        
        if let countryCode = countryCode {
            return countryCode + number
        } else {
            return number
        }
    }
}


