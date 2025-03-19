import UIKit

struct CornersButtonStyle {
    let backgroundColor: UIColor
    let disabledBackgroundColor: UIColor
    let textColor: UIColor
    let iconPosition: IconPosition
    let title: String?
    let icon: UIImage?
}

extension CornersButtonStyle {

    static let skip = CornersButtonStyle(
        backgroundColor: UIColor(resource: .light100),
        disabledBackgroundColor: UIColor(resource: .light80),
        textColor: UIColor(resource: .dark90),
        iconPosition: .right,
        title: "Skip",
        icon: UIImage(named: "rightChevron")
    )

    static let next = CornersButtonStyle(
        backgroundColor: UIColor(resource: .blue100),
        disabledBackgroundColor: UIColor(resource: .blue60),
        textColor: UIColor(resource: .light100),
        iconPosition: .right,
        title: "Next",
        icon: UIImage(named: "rightChevron")
    )

     static let continueButton = CornersButtonStyle(
        backgroundColor: UIColor(resource: .blue100),
        disabledBackgroundColor: UIColor(resource: .blue60),
        textColor: UIColor(resource: .light100),
        iconPosition: .right,
        title: "Continue",
        icon: UIImage(named: "rightChevron")
    )   

    static let verify = CornersButtonStyle(
        backgroundColor: UIColor(resource: .blue100),
        disabledBackgroundColor: UIColor(resource: .blue60),
        textColor: UIColor(resource: .light100),
        iconPosition: .left,
        title: "Verify and Continue",
        icon: UIImage(named: "tickCircle")
    )    

    static let location = CornersButtonStyle(
        backgroundColor: UIColor(resource: .blue100),
        disabledBackgroundColor: UIColor(resource: .blue60),
        textColor: UIColor(resource: .light100),
        iconPosition: .left,
        title: "Use Current Location",
        icon: UIImage(named: "gps")
    )    

    static let login = CornersButtonStyle(
        backgroundColor: UIColor(resource: .blue100),
        disabledBackgroundColor: UIColor(resource: .blue60),
        textColor: UIColor(resource: .light100),
        iconPosition: .right,
        title: "Login",
        icon: UIImage(named: "rightChevron")
    )

    static let savePink = CornersButtonStyle(
        backgroundColor: UIColor(resource: .pink100),
        disabledBackgroundColor: UIColor(resource: .pink60),
        textColor: UIColor(resource: .light100),
        iconPosition: .left,
        title: "Save and Use",
        icon: UIImage(named: "tickCircle")
    )
    
    static let saveDark = CornersButtonStyle(
        backgroundColor: UIColor(resource: .dark100),
        disabledBackgroundColor: UIColor(resource: .dark60),
        textColor: UIColor(resource: .light100),
        iconPosition: .left,
        title: "Save",
        icon: UIImage(named: "tickCircle")
    )
    

} 
