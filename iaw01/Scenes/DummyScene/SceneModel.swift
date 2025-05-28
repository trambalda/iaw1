struct SceneModel {
    
    let sceneType: SceneType
    let parameters: [String: Any?]
}

extension SceneModel {
    
    static var models: [SceneModel] {
        [
            SceneModel(sceneType: .textFiedsScene, parameters: [:]),
            SceneModel(sceneType: .cornersButtonsScene, parameters: [:]),
            SceneModel(sceneType: .authorizationScene, parameters: [:]),
            SceneModel(sceneType: .verifyPhoneNumberScene, parameters: [:]),
            SceneModel(sceneType: .profileScene, parameters: [:]),
            SceneModel(sceneType: .restaurantScene, parameters: [:]),
            SceneModel(sceneType: .onboardingScene, parameters: [:]),
        ]
    }
}
