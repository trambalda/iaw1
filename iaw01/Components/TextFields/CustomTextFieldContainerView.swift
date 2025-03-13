import UIKit

class CustomTextFieldContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerUI()
    }
    
    private func setupContainerUI() {
        backgroundColor = .light80
        layer.masksToBounds = true
        layer.cornerRadius = 13
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
