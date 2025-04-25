import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView(frame: UIScreen.main.bounds)
        view.onSelectPhotoButtonTapped = {
            print("Select photo button tapped")
        }
        view.onSaveButtonTapped = {
            print("Save button tapped")
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = profileView
    }
}
