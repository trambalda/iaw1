import UIKit

final class Factory {
    

    let appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {

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
        vc.appCoordinator = appCoordinator
        return vc
    }
}
//

