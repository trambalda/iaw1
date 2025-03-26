import UIKit

struct OnboardingPage {
    let image: UIImage?
    let title: String
    let description: String
}

extension OnboardingPage {
    static let pages: [OnboardingPage] = [
        OnboardingPage(
            image: UIImage(named: "testphoto07"),
            title: "Wide range of Food Categories & more",
            description: "Browse through our extensive list of restaurants and dishes, and when you're ready to order, simply add your desired items to your cart and checkout. It's that easy!"
        ),
        OnboardingPage(
            image: UIImage(named: "testphoto02"),
            title: "Free Deliveries for ONE MONTH!!",
            description: "Get your favorite meals delivered to your doorstep for free with our online food delivery app - enjoy a whole month of complimentary delivery!"
        ),
        OnboardingPage(
            image: UIImage(named: "testphoto03"),
            title: "Get started on Ordering your Food",
            description: "Please create an account or sign in to your existing account to start browsing our selection of delicious meals from your favorite restaurants."
        ),
        OnboardingPage(
            image: UIImage(named: "testphoto04"),
            title: "Ordering your Food",
            description: "It's that easy! Just browse through our selection of delicious meals from your favorite restaurants."
        )
    ]
    
    static var count: Int {
        pages.count
    }
    
    static func isLastPage(_ index: Int) -> Bool {
        index == pages.count - 1
    }
} 
