import UIKit

struct PhoneCountry {
    let flag: String
    let phoneCode: String
    let mask: String
    
    static let allCountries: [PhoneCountry] = [
        PhoneCountry(flag: "🇺🇸", phoneCode: "+1", mask: "(###)###-####"),
        PhoneCountry(flag: "🇷🇺", phoneCode: "+7", mask: "(###)###-##-##"),
        PhoneCountry(flag: "🇧🇾", phoneCode: "+375", mask: "(##)###-##-##"),
        PhoneCountry(flag: "🇺🇸", phoneCode: "+1", mask: "(###)###-####"),
        PhoneCountry(flag: "🇬🇧", phoneCode: "+44", mask: "(#)###-##-##"),
        PhoneCountry(flag: "🇧🇾", phoneCode: "+375", mask: "(##)###-##-##"),
    ]
}
