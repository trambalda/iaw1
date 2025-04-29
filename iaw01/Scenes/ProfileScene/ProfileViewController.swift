import UIKit

final class ProfileViewController: UIViewController {
    
    private var profileModel = ProfileModel()
    
    private var imagePickerManager: ImagePickerManager!
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView(frame: UIScreen.main.bounds)
        view.onSelectPhotoButtonTapped = { [weak self] in
            self?.presentPHPicker()
        }
        view.onSaveButtonTapped = {
            self.saveProfileData()
        }
        return view
    }()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerManager = ImagePickerManager(presentingViewController: self)
        imagePickerManager.delegate = self
    }
    
    private func presentPHPicker() {
        imagePickerManager.presentImagePicker()
    }
    
    private func saveProfileData() {
        profileModel.name = profileView.fullName
        profileModel.phoneNumber = profileView.phoneNumber
        print("Profile saved:", profileModel)
    }
}

extension ProfileViewController: ImagePickerManagerDelegate {
    func didSelectImage(_ image: UIImage) {
        profileView.updateAvatar(image: image)
        profileModel.avatarImage = image
    }
}
