enum SceneType {
    
    case textFiedsScene
    case cornersButtonsScene
    case verifyPhoneNumberScene
    case restaurantScene
    
    var title: String {
        switch self {
        case .textFiedsScene: "TextFieds Scene"
        case .cornersButtonsScene: "CornersButtons Scene"
        case .verifyPhoneNumberScene: "VerifyPhoneNumber Scene"
        case .restaurantScene: "Restaurant Scene"
        }
    }
}

extension SceneType: CaseIterable {
    static var allCases: [SceneType] {
        [
            .textFiedsScene,
            .cornersButtonsScene,
            .verifyPhoneNumberScene,
        ]
        return [.textFiedsScene, .cornersButtonsScene, .restaurantScene]
    }
}
