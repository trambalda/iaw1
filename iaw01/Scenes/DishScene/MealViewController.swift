import UIKit

class MealViewController: UIViewController {
    
    private lazy var dishView: MealView = {
        let view = MealView(frame: UIScreen.main.bounds)

        return view
    }()
    
    override func loadView() {
        view = dishView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100
    }
}
