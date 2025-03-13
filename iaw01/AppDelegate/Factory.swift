final class Factory {
    
    func createDummyScene() -> DummyViewController {
        let vc = DummyViewController()
        return vc
    }
    
    func createVerifyPhoneNumberViewController() -> VerifyPhoneNumberViewController {
        let vc = VerifyPhoneNumberViewController()
        return vc
    }
}
