import UIKit

struct CountryCodeModel {
    let flag: String
    let code: String
    let mask: String
    
    static let defaultMask = "(##)##-##-##"
    
    static let countryCodes: [CountryCodeModel] = [
        CountryCodeModel(flag: "🇺🇸", code: "+1", mask: "(###)###-####"),
        CountryCodeModel(flag: "🇷🇺", code: "+7", mask: "(###)###-##-##"),
        CountryCodeModel(flag: "🇧🇾", code: "+375", mask: "(##)###-##-##"),
        CountryCodeModel(flag: "🇺🇸", code: "+1", mask: "(###)###-####"),
        CountryCodeModel(flag: "🇬🇧", code: "+44", mask: "(#)###-##-##"),
        CountryCodeModel(flag: "🇧🇾", code: "+375", mask: "(##)###-##-##"),
    ]
}
