import UIKit

struct CountryCodeModel {
    let region: String
    let flag: String
    let code: String
    let mask: String
    let placeholder: String
    
    static var maxCountryCodeLength = CountryCodeModel.countryCodes.map { $0.code.count }.max()!
    
    static let defaultMask = "(##)##-##-##"
    
    static let countryCodes: [CountryCodeModel] = [
        CountryCodeModel(region: "US", flag: "🇺🇸", code: "+1", mask: "(###)###-####", placeholder: "(000)000-0000"),
        CountryCodeModel(region: "RU", flag: "🇷🇺", code: "+7", mask: "(###)###-##-##", placeholder: "(000)000-00-00"),
        CountryCodeModel(region: "BY", flag: "🇧🇾", code: "+375", mask: "(##)###-##-##", placeholder: "(00)000-00-00"),
        CountryCodeModel(region: "US", flag: "🇺🇸", code: "+1", mask: "(###)###-####", placeholder: "(000)000-0000"),
        CountryCodeModel(region: "RU", flag: "🇷🇺", code: "+7", mask: "(###)###-##-##", placeholder: "(000)000-00-00"),
        CountryCodeModel(region: "BY", flag: "🇧🇾", code: "+375", mask: "(##)###-##-##", placeholder: "(00)000-00-00"),
    ]
}
