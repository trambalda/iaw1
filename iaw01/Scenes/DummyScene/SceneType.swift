enum SceneType {
    
    case textFiedsScene
    case cornersButtonsScene
    case keyboardScene

    var title: String {
        switch self {
        case .textFiedsScene: "TextFieds Scene"
        case .cornersButtonsScene: "CornersButtons Scene"
        case .keyboardScene: "Keyboard Scene"
        }
    }
}

extension SceneType: CaseIterable {
    static var allCases: [SceneType] {
        return [.textFiedsScene, .cornersButtonsScene, .keyboardScene]
    }
}
