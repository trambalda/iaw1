import UIKit

class SelectCheckBox: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setImage(UIImage(named: "ellipse"), for: .normal)
        tintColor = .pink100
        addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
    }
    
    @objc func selectButtonAction() {
        setImage(UIImage(named: "ellipse-fill"), for: .normal)
    }
}
