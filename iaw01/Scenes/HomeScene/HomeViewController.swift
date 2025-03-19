import UIKit

class HomeViewController: UIViewController {
    
    private lazy var homeView: HomeView = {
        let view = HomeView(frame: UIScreen.main.bounds)
        return view
    }()
    
    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func handleTap() {
        homeView.homeSearchBar.resignFirstResponder()
    }
    
}
