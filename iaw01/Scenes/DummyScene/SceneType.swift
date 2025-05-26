enum SceneType {
    
    case textFiedsScene
    case cornersButtonsScene
    case authorizationScene
    case verifyPhoneNumberScene
    case profileScene
    case restaurantScene
    case onboardingScene
    
    var title: String {
        switch self {
        case .textFiedsScene: "TextFieds Scene"
        case .cornersButtonsScene: "CornersButtons Scene"
        case .authorizationScene: "Authorization Scene"
        case .verifyPhoneNumberScene: "VerifyPhoneNumber Scene"
        case .profileScene: "Profile Scene"
        case .restaurantScene: "Restaurant Scene"
        case .onboardingScene: "Onboarding Scene"
        }
    }
}

extension SceneType: CaseIterable {
    static var allCases: [SceneType] {
        [
            .textFiedsScene,
            .cornersButtonsScene,
            .authorizationScene,
            .verifyPhoneNumberScene,
            .profileScene,
            .restaurantScene,
            .onboardingScene,
        ]
    }
}
