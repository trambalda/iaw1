import UIKit

struct CornersButtonStyle {
    let backgroundColor: UIColor
    let disabledBackgroundColor: UIColor
    let textColor: UIColor
}

extension CornersButtonStyle {
    static let blue = CornersButtonStyle(
        backgroundColor: UIColor(resource: .blue100),
        disabledBackgroundColor: UIColor(resource: .blue60),
        textColor: UIColor(resource: .light100)
    )
    
    static let pink = CornersButtonStyle(
        backgroundColor: UIColor(resource: .pink100),
        disabledBackgroundColor: UIColor(resource: .pink60),
        textColor: UIColor(resource: .light100)
    )
    
    static let dark = CornersButtonStyle(
        backgroundColor: UIColor(resource: .dark100),
        disabledBackgroundColor: UIColor(resource: .dark60),
        textColor: UIColor(resource: .light100)
    )
    
    static let light = CornersButtonStyle(
        backgroundColor: UIColor(resource: .light100),
        disabledBackgroundColor: UIColor(resource: .light80),
        textColor: UIColor(resource: .dark90)
    )
} 