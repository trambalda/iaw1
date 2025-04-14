import UIKit

class CircleButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if shouldHighlight {
                updateAppearance()
            }
        }
    }
    
    private var shouldHighlight: Bool = true {
        didSet {
            updateAppearance()
        }
    }
    
    private var onTap: (() -> Void)?
    
    func configureButtonWith(image: UIImage, shouldHighlight: Bool, action: (() -> Void)?) {
        setImage(image, for: .normal)
        self.onTap = action
        self.shouldHighlight = shouldHighlight
    }
    
    private func setupButton() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        onTap?()
    }
    
    private func updateAppearance() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = self.isHighlighted ? 0.7 : 1.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
