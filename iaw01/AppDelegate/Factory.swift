import UIKit

final class Factory {
    
    var appCoordinator: AppCoordinator?
    
    init(appCoordinator: AppCoordinator? = nil) {
        self.appCoordinator = appCoordinator
    }
    
    func createDummyScene() -> DummyViewController {
        let vc = DummyViewController()
        vc.appCoordinator = appCoordinator
        return vc
    }
    
    func createTextFieldsScene() -> TextFieldsViewController {
        let vc = TextFieldsViewController()
        return vc
    }
    
    func createCornersButtonsScene() -> CornersButtonsViewController {
        let vc = CornersButtonsViewController()
        return vc
    }
    
    func createChangeLocationScene() -> ChangeLocationViewController {
        let vc = ChangeLocationViewController()
        return vc
    }
}
