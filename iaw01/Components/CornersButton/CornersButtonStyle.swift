import UIKit

struct CornersButtonStyle {
    let backgroundColor: UIColor
    let disabledBackgroundColor: UIColor
    let textColor: UIColor
    let iconPosition: CornersButton.IconPosition
    let title: String?
    let icon: UIImage?
}

extension CornersButtonStyle {

    static let skipButton = CornersButtonStyle(
        backgroundColor: .light100,
        disabledBackgroundColor: .light80,
        textColor: .dark90,
        iconPosition: .right,
        title: "Skip",
        icon: UIImage(named: "rightChevron")
    )

    static let nextButton = CornersButtonStyle(
        backgroundColor: .blue100,
        disabledBackgroundColor: .blue60,
        textColor: .light100,
        iconPosition: .right,
        title: "Next",
        icon: UIImage(named: "rightChevron")
    )

    static let verifyButton = CornersButtonStyle(
        backgroundColor: .blue100,
        disabledBackgroundColor: .blue60,
        textColor: .light100,
        iconPosition: .left,
        title: "Verify and Continue",
        icon: UIImage(named: "transpCircle")
    )

    static let locationButton = CornersButtonStyle(
        backgroundColor: .blue100,
        disabledBackgroundColor: .blue60,
        textColor: .light100,
        iconPosition: .left,
        title: "Use Current Location",
        icon: UIImage(named: "gps")
    )    

    static let loginButton = CornersButtonStyle(
        backgroundColor: .blue100,
        disabledBackgroundColor: .blue60,
        textColor: .light100,
        iconPosition: .right,
        title: "Login",
        icon: UIImage(named: "rightChevron")
    )

    static let savePinkButton = CornersButtonStyle(
        backgroundColor: .pink100,
        disabledBackgroundColor: .pink60,
        textColor: .light100,
        iconPosition: .left,
        title: "Save and Use",
        icon: UIImage(named: "tickCircle")
    )
    
    static let saveDarkButton = CornersButtonStyle(
        backgroundColor: .dark100,
        disabledBackgroundColor: .dark60,
        textColor: .light100,
        iconPosition: .left,
        title: "Save",
        icon: UIImage(named: "tickCircle")
    )
    
    static let addressButton = CornersButtonStyle(
        backgroundColor: .peach60.withAlphaComponent(0.5),
        disabledBackgroundColor: .blue60,
        textColor: .peach100,
        iconPosition: .left,
        title: "32, Test Ln.",
        icon: UIImage(named: "locationPin")
    )
}
