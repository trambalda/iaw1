import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView(frame: UIScreen.main.bounds)
        view.onSafeButtonTapped = {
            print("Safe button tapped")
        }
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
