import UIKit

class HomeViewController: UIViewController {
    
    private var userName: String = "Luisa"
    private var timeOfDay: String = "Evening"
    
    private lazy var homeView: HomeView = {
        let view = HomeView(frame: UIScreen.main.bounds)
        return view
    }()
    
    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        updateGreeting()
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        homeView.homeSearchBar.resignFirstResponder()
    }
    
    func updateGreeting() {
            homeView.updateGreeting(timeOfDay: timeOfDay, name: userName)
    }
        
    func setUserName(_ name: String) {
            userName = name
            updateGreeting()
    }
        
    func setTimeOfDay(_ time: String) {
            timeOfDay = time
            updateGreeting()
    }
}
