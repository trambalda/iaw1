import UIKit

class VerifyPhoneNumberViewController: UIViewController {

    var keyboardService: KeyboardServiceProtocol?

    private lazy var verifyPhoneNumberView: VerifyPhoneNumberView = {
        let view = VerifyPhoneNumberView(frame: UIScreen.main.bounds)
        view.onVerifyButtonTapped = {
            print("Verify button tapped")
        }
        view.onGetNewCodeButtonTapped = {
            print("\"Get a new one\" button tapped")
        }
        return view
    }()
    
    override func loadView() {
        view = verifyPhoneNumberView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100
        
        keyboardService?.isEnabled = true
        keyboardService?.onKeyboardChanged = { [weak self] height, duration in
            self?.verifyPhoneNumberView.keyboard = (height, duration)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        verifyPhoneNumberView.activatePincodeInput()
    }
}
