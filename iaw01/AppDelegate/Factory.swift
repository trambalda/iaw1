final class Factory {
    
    func createDummyScene() -> DummyViewController {
        let vc = DummyViewController()
        return vc
    }
    
    func createTextFieldsScene() -> TextFieldsViewController {
        let vc = TextFieldsViewController()
        return vc
    }
}
