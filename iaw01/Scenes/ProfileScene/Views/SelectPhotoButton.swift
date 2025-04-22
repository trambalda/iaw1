import UIKit

class SelectPhotoButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        self.imageView?.contentMode = .scaleAspectFit
        setImage(.selectAvatarButton, for: .normal)
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    @objc private func onTap() {
        print("Select photo")
    }
}
