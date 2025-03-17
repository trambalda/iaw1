final class Factory {
    
    func createHomeScene() -> HomeViewController {
        let homeViewController = HomeViewController()
        return homeViewController
    }
    
    func createDummyScene() -> DummyViewController {
        let vc = DummyViewController()
        return vc
    }
    
}
