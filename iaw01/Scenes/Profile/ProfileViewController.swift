import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView(frame: UIScreen.main.bounds)
        return view
    }()

    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100
    }
}
