enum SceneType {
    
    case textFiedsScene
    case cornersButtonsScene
    case verifyPhoneNumberScene
    case mealScene
    
    var title: String {
        switch self {
        case .textFiedsScene: "TextFieds Scene"
        case .cornersButtonsScene: "CornersButtons Scene"
        case .verifyPhoneNumberScene: "VerifyPhoneNumber Scene"
        case .mealScene: "Meal Scene"
        }
    }
}

extension SceneType: CaseIterable {
    static var allCases: [SceneType] {
        [
            .textFiedsScene,
            .cornersButtonsScene,
            .verifyPhoneNumberScene,
            .mealScene,
        ]
    }
}
