final class Factory {
    
    func createDummyScene() -> DummyViewController {
        let vc = DummyViewController()
        return vc
    }
    
    func createAuthorizationScene() -> AuthorizationSceneViewController {
        let vc = AuthorizationSceneViewController()
        return vc
    }
}
