import UIKit

class MealView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alwaysBounceHorizontal = false
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mealDescriptionView: MealDescriptionView = {
        let view = MealDescriptionView()
        return view
    }()
    
    private lazy var expandableViewsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .light100
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var sideItemView: ExpandableView = {
        let view = ExpandableView(labelName: "Side Item", isRequiredLabel: true)
        return view
    }()
    
    private lazy var drinksView: ExpandableView = {
        let view = ExpandableView(labelName: "Drinks", isRequiredLabel: true)
        return view
    }()
    
    private lazy var editCheeseBurgerView: ExpandableView = {
        let view = ExpandableView(labelName: "Edit Cheeseburger", isRequiredLabel: true)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .light100
        setupScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(mealDescriptionView)
        containerView.addSubview(expandableViewsStackView)
        expandableViewsStackView.addArrangedSubview(sideItemView)
        expandableViewsStackView.addArrangedSubview(drinksView)
        expandableViewsStackView.addArrangedSubview(editCheeseBurgerView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            mealDescriptionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            mealDescriptionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mealDescriptionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            expandableViewsStackView.topAnchor.constraint(equalTo: mealDescriptionView.bottomAnchor, constant: 25),
            expandableViewsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            expandableViewsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            expandableViewsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
    }
}
