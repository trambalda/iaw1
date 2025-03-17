final class Factory {
    
    func createDummyScene() -> DummyViewController {
        let vc = DummyViewController()
        return vc
    }
    
    func createTestTFScene() -> TextFieldsViewController {
        let vc = TextFieldsViewController()
        return vc
    }
}
