import UIKit

final class Factory {
    let appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func createHomeScene() -> HomeViewController {
        let homeViewController = HomeViewController()
        return homeViewController
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
    
}
