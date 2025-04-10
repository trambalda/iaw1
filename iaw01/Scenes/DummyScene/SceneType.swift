enum SceneType {
    
    case textFiedsScene
    case cornersButtonsScene
    case authorizationScene
    case verifyPhoneNumberScene
    
    var title: String {
        switch self {
        case .textFiedsScene: "TextFieds Scene"
        case .cornersButtonsScene: "CornersButtons Scene"
        case .authorizationScene: "Authorization Scene"
        case .verifyPhoneNumberScene: "VerifyPhoneNumber Scene"
        }
    }
}

extension SceneType: CaseIterable {
    static var allCases: [SceneType] {
        [
            .textFiedsScene,
            .cornersButtonsScene,
            .authorizationScene,
            .textFiedsScene,
            .cornersButtonsScene,
            .verifyPhoneNumberScene,
        ]
    }
}
