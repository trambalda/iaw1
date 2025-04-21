struct CountryCodeModel {
    let region: String?
    let flag: String?
    let code: String
    let mask: String
    let placeholder: String
    
    static var maxLength = CountryCodeModel.countryCodes.map { $0.code.count }.max()!
    
    static let `default` = countryCodes[0]
    
    static let countryCodes: [CountryCodeModel] = [
        CountryCodeModel(region: "US", flag: "🇺🇸", code: "+1", mask: " (###) ###-####", placeholder: "(000) 000-0000"),
        CountryCodeModel(region: "RU", flag: "🇷🇺", code: "+7", mask: " (###) ###-##-##", placeholder: "(000) 000-00-00"),
        CountryCodeModel(region: "BY", flag: "🇧🇾", code: "+375", mask: " (##) ###-##-##", placeholder: "(00) 000-00-00"),
        CountryCodeModel(region: "GB", flag: "🇬🇧", code: "+44", mask: " #### ### ####", placeholder: "0000 000 0000"),
        CountryCodeModel(region: "DE", flag: "🇩🇪", code: "+49", mask: " #### ########", placeholder: "0000 00000000"),
        CountryCodeModel(region: "FR", flag: "🇫🇷", code: "+33", mask: " # ## ## ## ##", placeholder: "0 00 00 00 00"),
        CountryCodeModel(region: "IT", flag: "🇮🇹", code: "+39", mask: " ### #######", placeholder: "000 0000000"),
        CountryCodeModel(region: "ES", flag: "🇪🇸", code: "+34", mask: " ### ### ###", placeholder: "000 000 000"),
        CountryCodeModel(region: "CN", flag: "🇨🇳", code: "+86", mask: " ### #### ####", placeholder: "000 0000 0000"),
        CountryCodeModel(region: "IN", flag: "🇮🇳", code: "+91", mask: " #####-#####", placeholder: "00000-00000"),
        CountryCodeModel(region: "JP", flag: "🇯🇵", code: "+81", mask: " ##-####-####", placeholder: "00-0000-0000"),
        CountryCodeModel(region: "BR", flag: "🇧🇷", code: "+55", mask: " (##) #####-####", placeholder: "(00) 00000-0000"),
        CountryCodeModel(region: "AU", flag: "🇦🇺", code: "+61", mask: " #### ### ###", placeholder: "0000 000 000"),
    ]
    
    init(region: String, flag: String, code: String, mask: String, placeholder: String) {
        self.region = region
        self.flag = flag
        self.code = code
        self.mask = mask
        self.placeholder = placeholder
    }
    
    init?(code: String?) {
        let digits = code?.filter { $0.isNumber }
        
        guard digits.notNilNotEmpty else { return nil }
        
        let formattedCode = "+" + digits!
        
        if let matched = CountryCodeModel.countryCodes.first(where: { $0.code == formattedCode }) {
            self = matched
        } else {
            self.region = nil
            self.flag = nil
            self.code = formattedCode
            self.mask = CountryCodeModel.default.mask
            self.placeholder = CountryCodeModel.default.placeholder
        }
    }
}


