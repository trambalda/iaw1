import UIKit

class VerifyPhoneNumberView: UIView {
    
    var onVerifyButtonTapped: (() -> Void)?
    
    var onGetNewCodeButtonTapped: (() -> Void)?

    var keyboard: (height: CGFloat, duration: TimeInterval) = (0, 0) {
        didSet {
            keyboard.height > 0
            ? keyboardWillShow(keyboardHeight: keyboard.height, duration: keyboard.duration)
            : keyboardWillHide(duration: keyboard.duration)
        }
    }

    private var verifyButtonBottomConstraint: NSLayoutConstraint!
    
    private var keyboardPadding: CGFloat = 16
    
    private var phoneNumberInputView = PhoneNumberInputView()
    
    private var pincodeInputView = PincodeInputView()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var verifyHeaderLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.heading4.compose("Verify Phone Number", color: nil)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var verifyDescLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("We have sent you a 6 digit code. Please enter here to Verify your Number.", color: nil)
        label.textColor = .dark80
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var getNewCodeButton: LinkButton = {
        let button = LinkButton(style: .getNewCode)
        button.addTarget(self, action: #selector(getNewCodeDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var getNewCodeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("Didn't Receive Code?", color: nil)
        label.textColor = .dark80
        return label
    }()
    
    private lazy var verifyButton: CornersButton = {
        let button = CornersButton(style: .verifyButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(verifyButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    func activatePincodeInput() {
        pincodeInputView.firstTextFieldBecomeFirstResponder()
    }
    
    @objc private func verifyButtonDidTapped() {
        phoneNumberInputView.resignFirstResponder()
        onVerifyButtonTapped?()
    }
    
    @objc private func getNewCodeDidTapped() {
        onGetNewCodeButtonTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        let newCodeOuterStackView = UIStackView()
        newCodeOuterStackView.axis = .vertical
        newCodeOuterStackView.alignment = .center
        let newCodeInnerStackView = UIStackView()
        newCodeInnerStackView.spacing = 5
        let spacing: CGFloat = Constants.isSE ? 20 : 40
        
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(verifyHeaderLabel)
        mainStackView.addArrangedSubview(verifyDescLabel)
        mainStackView.addArrangedSubview(phoneNumberInputView)
        mainStackView.addArrangedSubview(pincodeInputView)
        mainStackView.addArrangedSubview(newCodeOuterStackView)
        newCodeOuterStackView.addArrangedSubview(newCodeInnerStackView)
        newCodeInnerStackView.addArrangedSubview(getNewCodeLabel)
        newCodeInnerStackView.addArrangedSubview(getNewCodeButton)
        addSubview(verifyButton)
        
        mainStackView.setCustomSpacing(spacing, after: phoneNumberInputView)
        mainStackView.setCustomSpacing(spacing, after: pincodeInputView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            pincodeInputView.heightAnchor.constraint(equalToConstant: 55),
            
            verifyButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            verifyButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
        verifyButtonBottomConstraint = verifyButton.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -(RootTabBarController.height + keyboardPadding)
        )
        verifyButtonBottomConstraint.isActive = true
    }
}

extension VerifyPhoneNumberView: UITextFieldDelegate{
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        string.count <= 1
    }
}

extension VerifyPhoneNumberView {
    
    private func keyboardWillShow(keyboardHeight: CGFloat, duration: TimeInterval) {
        let bottomPadding: CGFloat = -(keyboardHeight + keyboardPadding)
        changeVerifyButtonPosition(bottomPadding: bottomPadding, duration: duration)
    }
    
    private func keyboardWillHide(duration: TimeInterval) {
        let bottomPadding: CGFloat = -(RootTabBarController.height + keyboardPadding)
        changeVerifyButtonPosition(bottomPadding: bottomPadding, duration: duration + 0.2)
    }
    
    private func changeVerifyButtonPosition(bottomPadding: CGFloat, duration: TimeInterval) {
        verifyButtonBottomConstraint.constant = bottomPadding
        
        UIView.animate(withDuration: duration) {
            self.layoutIfNeeded()
        }
    }
}
