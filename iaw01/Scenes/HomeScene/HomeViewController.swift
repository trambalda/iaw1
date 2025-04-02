import UIKit

class HomeViewController: UIViewController {
    
    lazy var homeView: HomeView = {
        let view = HomeView(frame: UIScreen.main.bounds)
        view.title = Font.heading5.compose("Good Evening Luisa", color: .dark100)
        view.addressTitle = "32, Kingston Ln."
        view.onAddressButtonTap = { [weak self] in
            self?.handleAddressButtonTap()
        }
        return view
    }()
    
    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGesture()
    }
    
    private func handleAddressButtonTap() {
        print("Address button tapped")
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        homeView.dismissKeyboard()
    }
}
