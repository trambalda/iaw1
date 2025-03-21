enum SceneType {
    
    case textFiedsScene
    case cornersButtonsScene
    
    var title: String {
        switch self {
        case .textFiedsScene: "TextFieds Scene"
        case .cornersButtonsScene: "CornersButtons Scene"
        }
    }
}

extension SceneType: CaseIterable {
    static var allCases: [SceneType] {
        return [.textFiedsScene, .cornersButtonsScene]
    }
}
