import UIKit

class MealView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .light100
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var mealDescriptionView: MealDescriptionView = {
        let view = MealDescriptionView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(mealDescriptionView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mealDescriptionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mealDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mealDescriptionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        
    }
}
