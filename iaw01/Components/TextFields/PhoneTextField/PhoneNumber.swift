struct PhoneNumber {
    
    let number: String?
    let countryCode: CountryCodeModel?
    
    var fullNumber: String {
        [countryCode?.code, number].compactMap { $0 }.joined()
    }
    
    static let `default` = PhoneNumber(number: nil, countryCode: .default)
    
    init(number: String?, countryCode: CountryCodeModel?) {
        self.number = number
        self.countryCode = countryCode
    }
    
    init?(fullString: String) {
        let digitsOnly = fullString.filter { $0.isNumber }
        
        let numberPart = String(digitsOnly.suffix(10))
        let codePart = String(digitsOnly.prefix(max(0, digitsOnly.count - 10)))
        
        self.init(code: codePart, number: numberPart)
    }
    
    init?(code: String?, number: String?) {
        guard
            number.notNilNotEmpty,
            let code = code,
            let countryCode = CountryCodeModel(code: code)
        else { return nil }
        
        let cleanedNumber = number!.filter { $0.isNumber }
        
        self.init(number: cleanedNumber, countryCode: countryCode)
    }
}
