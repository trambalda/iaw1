import UIKit

struct CountryCodeModel {
    let region: String
    let flag: String
    let code: String
    let mask: String
    
    static let defaultMask = "(##)##-##-##"
    
    static let countryCodes: [CountryCodeModel] = [
        CountryCodeModel(region: "US", flag: "🇺🇸", code: "+1", mask: "(###)###-####"),
        CountryCodeModel(region: "RU", flag: "🇷🇺", code: "+7", mask: "(###)###-##-##"),
        CountryCodeModel(region: "BY", flag: "🇧🇾", code: "+375", mask: "(##)###-##-##"),
        CountryCodeModel(region: "US", flag: "🇺🇸", code: "+1", mask: "(###)###-####"),
        CountryCodeModel(region: "RU", flag: "🇷🇺", code: "+7", mask: "(###)###-##-##"),
        CountryCodeModel(region: "BY", flag: "🇧🇾", code: "+375", mask: "(##)###-##-##"),
    ]
}
