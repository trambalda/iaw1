import UIKit

struct CornersButtonStyle {
    // MARK: - Static Properties
    static let blue = CornerButtonStyle(
        backgroundColor: UIColor(resource: .blue100),
        disabledBackgroundColor: UIColor(resource: .blue60),
        textColor: UIColor(resource: .light100)
    )
    
    static let pink = CornerButtonStyle(
        backgroundColor: UIColor(resource: .pink100),
        disabledBackgroundColor: UIColor(resource: .pink60),
        textColor: UIColor(resource: .light100)
    )
    
    static let dark = CornerButtonStyle(
        backgroundColor: UIColor(resource: .dark100),
        disabledBackgroundColor: UIColor(resource: .dark60),
        textColor: UIColor(resource: .light100)
    )
    
    static let light = CornerButtonStyle(
        backgroundColor: UIColor(resource: .light100),
        disabledBackgroundColor: UIColor(resource: .light80),
        textColor: UIColor(resource: .dark90)
    )
    
    // MARK: - Stored Properties
    let backgroundColor: UIColor
    let disabledBackgroundColor: UIColor
    let textColor: UIColor
} 