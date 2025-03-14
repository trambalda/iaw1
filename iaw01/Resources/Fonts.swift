import UIKit

enum Font {
    
    enum Family {
        case everettMedium
        case everettRegular
        case aeonikMedium
        
        var title: String {
            switch self {
            case .everettMedium:  "TWKEverett-Medium"
            case .everettRegular: "TWKEverett-Regular"
            case .aeonikMedium:  "Aeonik-Medium"
            }
        }
    }
    
    static let heading1 = UIFont(name: Family.everettMedium.title, size: 96)
    static let heading2 = UIFont(name: Family.everettMedium.title, size: 60)
    static let heading3 = UIFont(name: Family.everettMedium.title, size: 48)
    static let heading4 = UIFont(name: Family.everettMedium.title, size: 36)
    static let subtitle1 = UIFont(name: Family.everettMedium.title, size: 24)
    static let subtitle2 = UIFont(name: Family.everettMedium.title, size: 21)
    static let body = UIFont(name: Family.everettRegular.title, size: 17)
    static let note = UIFont(name: Family.everettRegular.title, size: 13)
    static let caption = UIFont(name: Family.everettMedium.title, size: 12)
    static let button = UIFont(name: Family.aeonikMedium.title, size: 18)
}
