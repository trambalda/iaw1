import Foundation

struct CountryCodes {
    let code: String
    let name: String
    let flag: String
    
    static var countries: [CountryCodes] {
        return [
            CountryCodes(code: "+93", name: "Афганистан", flag: "🇦🇫"),
            CountryCodes(code: "+355", name: "Албания", flag: "🇦🇱"),
            CountryCodes(code: "+213", name: "Алжир", flag: "🇩🇿"),
            CountryCodes(code: "+376", name: "Андорра", flag: "🇦🇩"),
            CountryCodes(code: "+244", name: "Ангола", flag: "🇦🇴"),
            CountryCodes(code: "+1268", name: "Антигуа и Барбуда", flag: "🇦🇬"),
            CountryCodes(code: "+7", name: "Россия", flag: "🇷🇺"),
        ]
    }
}
