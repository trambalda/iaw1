enum SceneType {
    
    case textFiedsScene
    case cornersButtonsScene
    case onboardingScene
    
    var title: String {
        switch self {
        case .textFiedsScene: "TextFieds Scene"
        case .cornersButtonsScene: "CornersButtons Scene"
        case .onboardingScene: "Onboarding Scene"
        }
    }
}

extension SceneType: CaseIterable {
    static var allCases: [SceneType] {
        return [.textFiedsScene, .cornersButtonsScene, .onboardingScene]
    }
}
