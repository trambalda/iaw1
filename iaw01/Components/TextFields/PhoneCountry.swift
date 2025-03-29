import UIKit

struct PhoneCountry {
    let phoneCode: String
    let mask: String
    let flag: String // для теста
    
    static let allCountries: [PhoneCountry] = [
        PhoneCountry(phoneCode: "+1", mask: "(###)###-####", flag: "🇺🇸"),
        PhoneCountry(phoneCode: "+7", mask: "(###)###-##-##", flag: "🇷🇺"),
        PhoneCountry(phoneCode: "+375", mask: "(##)###-##-##", flag: "🇧🇾"),
        PhoneCountry(phoneCode: "+1", mask: "(###)###-####", flag: "🇺🇸"),
        PhoneCountry(phoneCode: "+44", mask: "(###)###-##-##", flag: "🇬🇧"),
        PhoneCountry(phoneCode: "+375", mask: "(##)###-##-##", flag: "🇧🇾"),
    ]
}
