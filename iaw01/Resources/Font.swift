import UIKit

struct Font {
    let font: UIFont
    let lettering: Double
    
    func compose(_ text: String, color: UIColor? = .black) -> NSAttributedString {
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
            case .aeonikMedium:   "Aeonik-Medium"
            }
        }
    }
}

extension Font {
    static let heading4 = Font(
        font: UIFont(name: Family.everettMedium.title, size: 33)!, // original 36, -2
        lettering: -4
    )
    static let subtitle1 = Font(
        font: UIFont(name: Family.everettMedium.title, size: 22)!, // original 24, 0
        lettering: -1
    )
    static let subtitle2 = Font(
        font: UIFont(name: Family.everettMedium.title, size: 19)!, // original 21, -1
        lettering: -0.5
    )
    static let body = Font(
        font: UIFont(name: Family.everettRegular.title, size: 15.4)!, // original 17, -1
        lettering: -1
    )
    static let note = Font(
        font: UIFont(name: Family.everettRegular.title, size: 12)!, // original 13, -1
        lettering: -1
    )
    static let caption = Font(
        font: UIFont(name: Family.everettMedium.title, size: 10.9)!, // original 12, 2
        lettering: 0.5
    )
    static let button = Font(
        font: UIFont(name: Family.aeonikMedium.title, size: 18)!, // original the same
        lettering: 0
    )
}
