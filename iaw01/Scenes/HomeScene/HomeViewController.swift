import UIKit

class HomeViewController: UIViewController {
    
    lazy var homeView: HomeView = {
        let view = HomeView(frame: UIScreen.main.bounds)
        return view
    }()
    
    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGesture()
        homeView.configure(with: "Good Evening Luisa")
        homeView.homeAddressView.configureAddress(title: "32, Kingston Ln.")
        homeView.homeAddressView.onAddressButtonTap = { [weak self] in
            self?.handleAddressButtonTap()
        }
    }
    
    private func handleAddressButtonTap() {
            print("Address button tapped")
        }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        homeView.homeSearchView.homeSearchBar.resignFirstResponder()
    }
}
