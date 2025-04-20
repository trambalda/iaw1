struct PhoneNumber {
    let number: String?
    let countryCode: CountryCodeModel?
    
    var fullNumber: String {
        [countryCode?.code, number].compactMap { $0 }.joined()
    }
    
    static let `default` = PhoneNumber(number: nil, countryCode: .default)
    
    init?(_ fullString: String) {
        let digitsOnly = fullString.filter { $0.isNumber }
        
        guard digitsOnly.count >= 11 else {
            return nil
        }
        
        let numberPart = String(digitsOnly.suffix(10))
        let codePart = String(digitsOnly.prefix(digitsOnly.count - 10))
        
        guard let code = CountryCodeModel(code: codePart) else {
            return nil
        }
        
        self.number = numberPart
        self.countryCode = code
    }

    init?(code: String, number: String) {
        let cleanedCode = code.filter { $0.isNumber }
        let cleanedNumber = number.filter { $0.isNumber }
        
        guard !cleanedCode.isEmpty, !cleanedNumber.isEmpty else {
            return nil
        }
        
        guard let countryCode = CountryCodeModel(code: cleanedCode) else {
            return nil
        }
        
        self.number = cleanedNumber
        self.countryCode = countryCode
    }
    
    private init(number: String?, countryCode: CountryCodeModel?) {
        self.number = number
        self.countryCode = countryCode
    }
}


