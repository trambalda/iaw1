import UIKit
import PhotosUI

final class ProfileViewController: UIViewController {
    
    private var profileModel = ProfileModel()
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView(frame: UIScreen.main.bounds)
        view.delegate = self
        view.onSaveButtonTapped = { [weak self] in
            self?.saveProfileData()
        }
        return view
    }()
    
    override func loadView() {
        view = profileView
    }
    
    private func saveProfileData() {
        profileModel.avatarImage = profileView.avatar
        profileModel.name = profileView.fullName
        profileModel.phoneNumber = profileView.phoneNumber
        print("Profile saved:", profileModel)
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func presentImagePicker(_ picker: PHPickerViewController) {
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let result = results.first else { return }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
            guard let image = object as? UIImage else { return }
            
            DispatchQueue.main.async {
                let cropVC = CropViewController(image: image) { croppedImage in
                    self?.profileView.updateAvatar(image: croppedImage)
                    self?.profileModel.avatarImage = croppedImage
                }
                self?.present(cropVC, animated: true)
            }
        }
    }
}
