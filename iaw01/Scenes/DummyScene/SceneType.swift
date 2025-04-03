enum SceneType {
    
    case textFiedsScene
    case cornersButtonsScene
    case authorizationScene
    
    var title: String {
        switch self {
        case .textFiedsScene: "TextFieds Scene"
        case .cornersButtonsScene: "CornersButtons Scene"
        case .authorizationScene: "Authorization Scene"
        }
    }
}

extension SceneType: CaseIterable {
    static var allCases: [SceneType] {
        return [
            .textFiedsScene,
            .cornersButtonsScene,
            .authorizationScene,
        ]
    }
}
