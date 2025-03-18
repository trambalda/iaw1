
import UIKit

struct Font {
    let font: UIFont
    let lettering: Double
    
    func compose(_ text: String, color: UIColor?) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes(
            [
                NSAttributedString.Key.font : self.font,
                NSAttributedString.Key.kern : self.lettering,
                NSAttributedString.Key.foregroundColor: color ?? .black,
            ],
            range: NSRange(location: 0, length: attributedString.length)
        )
        return attributedString
    }
}

extension Font {
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
}

extension Font {
    static let heading1 = Font(
        font: UIFont(name: Family.everettMedium.title, size: 96)!,
        lettering: -3
    )
    static let heading2 = Font(
        font: UIFont(name: Family.everettMedium.title, size: 60)!,
        lettering: -1.5
    )
    static let heading3 = Font(
        font: UIFont(name: Family.everettMedium.title, size: 48)!,
        lettering: -1
    )
    static let heading4 = Font(
        font: UIFont(name: Family.everettMedium.title, size: 36)!,
        lettering: -2
    )
    static let subtitle1 = Font(
        font: UIFont(name: Family.everettMedium.title, size: 24)!,
        lettering: -0
    )
    static let subtitle2 = Font(
        font: UIFont(name: Family.everettMedium.title, size: 21)!,
        lettering: -1
    )
    static let body = Font(
        font: UIFont(name: Family.everettRegular.title, size: 17)!,
        lettering: -1
    )
    static let caption = Font(
        font: UIFont(name: Family.everettMedium.title, size: 12)!,
        lettering: 2
    )
    static let button = Font(
        font: UIFont(name: Family.aeonikMedium.title, size: 18)!,
        lettering: 0
    )
}
