enum SceneType {
    
    case textFiedsScene
    case cornersButtonsScene
    case keyboardScene

    case verifyPhoneNumberScene
    
    var title: String {
        switch self {
        case .textFiedsScene: "TextFieds Scene"
        case .cornersButtonsScene: "CornersButtons Scene"
        case .keyboardScene: "Keyboard Scene"
        case .verifyPhoneNumberScene: "VerifyPhoneNumber Scene"
        }
    }
}

extension SceneType: CaseIterable {
    static var allCases: [SceneType] {
        return [.textFiedsScene, .cornersButtonsScene, .keyboardScene]
        [
            .textFiedsScene,
            .cornersButtonsScene,
            .verifyPhoneNumberScene,
        ]
    }
}
