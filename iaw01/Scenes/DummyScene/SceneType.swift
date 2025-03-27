enum SceneType {
    
    case textFiedsScene
    case cornersButtonsScene
    case restaurantScene
    
    var title: String {
        switch self {
        case .textFiedsScene: "TextFieds Scene"
        case .cornersButtonsScene: "CornersButtons Scene"
        case .restaurantScene: "Restaurant Scene"
        }
    }
}

extension SceneType: CaseIterable {
    static var allCases: [SceneType] {
        return [.textFiedsScene, .cornersButtonsScene, .restaurantScene]
    }
}
