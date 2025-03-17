
import UIKit

struct Font {
    
    enum Name {
        case heading1
        case heading2
        case heading3
        case heading4
        case heading5
        case subtitle1
        case subtitle2
        case body
        case caption
        case button
    }
    
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
    static let heading5 = UIFont(name: Family.everettRegular.title, size: 36)
    static let subtitle1 = UIFont(name: Family.everettMedium.title, size: 24)
    static let subtitle2 = UIFont(name: Family.everettMedium.title, size: 21)
    static let body = UIFont(name: Family.everettRegular.title, size: 17)
    static let caption = UIFont(name: Family.everettMedium.title, size: 12)
    static let button = UIFont(name: Family.aeonikMedium.title, size: 18)
}

extension UILabel {
    
    func setTextAndFont(_ text: String, font: Font.Name) {
        self.text = text
        let lettering: Double
        switch font {
        case .heading1:
            self.font = Font.heading1
            lettering = -3
        case .heading2:
            self.font = Font.heading2
            lettering = -1.5
        case .heading3:
            self.font = Font.heading3
            lettering = -1
        case .heading4:
            self.font = Font.heading4
            lettering = -2
        case .heading5:
            self.font = Font.heading5
            lettering = -3 // при значении -5 текст просто слипается в одну кучу, так же обнаружил что TWKEverett-Regular и Everett-Regular разные шрифты и сам пока в фигме искал нужный все перекопал
        case .subtitle1:
            self.font = Font.subtitle1
            lettering = 0
        case .subtitle2:
            self.font = Font.subtitle2
            lettering = -1
        case .body:
            self.font = Font.body
            lettering = -1
        case .caption:
            self.font = Font.caption
            lettering = 2
        case .button:
            self.font = Font.button
            lettering = 0
        }
        
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(
            NSAttributedString.Key.kern,
            value: lettering,
            range: NSRange(location: 0, length: string.length - 1)
        )
        attributedText = string
    }
}
