import UIKit

struct CountryCodes {
    let code: String
    let name: String
    let flag: UIImage
    
    static var countries: [CountryCodes] {
        return [
            CountryCodes(code: "+7", name: "Россия", flag: .ru),
            CountryCodes(code: "+93", name: "Афганистан", flag: .af),
            CountryCodes(code: "+355", name: "Албания", flag: .al),
            CountryCodes(code: "+213", name: "Алжир", flag: .dz),
            CountryCodes(code: "+376", name: "Андорра", flag: .ad),
            CountryCodes(code: "+244", name: "Ангола", flag: .ao),
            CountryCodes(code: "+1268", name: "Антигуа и Барбуда", flag: .ag),
            
        ]
    }
}
