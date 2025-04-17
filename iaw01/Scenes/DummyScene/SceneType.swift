enum SceneType {
    
    case textFiedsScene
    case cornersButtonsScene
    case verifyPhoneNumberScene
    case profileScene
    
    var title: String {
        switch self {
        case .textFiedsScene: "TextFieds Scene"
        case .cornersButtonsScene: "CornersButtons Scene"
        case .verifyPhoneNumberScene: "VerifyPhoneNumber Scene"
        case .profileScene: "Profile Scene"
        }
    }
}

extension SceneType: CaseIterable {
    static var allCases: [SceneType] {
        [
            .textFiedsScene,
            .cornersButtonsScene,
            .verifyPhoneNumberScene,
            .profileScene
        ]
    }
}
