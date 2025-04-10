import UIKit

class MealViewController: UIViewController {
    
    private lazy var mealView: MealView = {
        let view = MealView(frame: UIScreen.main.bounds)

        return view
    }()
    
    override func loadView() {
        view = mealView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
