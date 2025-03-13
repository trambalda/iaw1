final class Factory {
    
    func createDummyScene() -> DummyViewController {
        let vc = DummyViewController()
        return vc
    }
    
    // createVerifyScene() создан для теста сцены верификации #IAW-25
    func createVerifyScene() -> VerifyPhoneNumberViewController {
        let vc = VerifyPhoneNumberViewController()
        return vc
    }
}
