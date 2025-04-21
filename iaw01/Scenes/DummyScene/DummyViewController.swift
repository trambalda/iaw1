import UIKit

final class DummyViewController: UIViewController {
    
    var coordinator: HomeScenesCoordinatorProtocol?

    private lazy var dummyView: DummyView = {
        let view = DummyView(frame: .zero)
        view.scenes = SceneModel.models
        view.route = { sceneType in
            self.route(to: sceneType)
        }
        return view
    }()
    
    override func loadView() {
        view = dummyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        navigationItem.title = "Scenes"
    }
    
    private func route(to sceneType: SceneType) {
        switch sceneType {
        case .textFiedsScene:
            coordinator?.showTextFieldScene()
        case .cornersButtonsScene:
            coordinator?.showCornersButtonsScene()
        case .verifyPhoneNumberScene:
            coordinator?.showVerifyPhoneNumberScene()
        case .profileScene:
            coordinator?.showProfileScene()
        }
    }
}
