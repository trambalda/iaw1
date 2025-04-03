import UIKit

final class RestaurantView: UIView {
    let scrollView = UIScrollView()
    
    let headerImageView = HeaderImageView()
    let restaurantHeaderView = RestaurantHeaderView()
    let restaurantInfoView = RestaurantInfoView()
    let menuTimeView = MenuTimeView()
    let menuCategoryView = MenuCategoryView()
    let menuItemListView = MenuItemListView()
    
    var headerImageViewHeightConstraint: NSLayoutConstraint!
    var restaurantInfoViewHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
        adjustForSmallScreens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: RestaurantModel) {
        headerImageView.imageView.image = model.image
        restaurantHeaderView.configure(with: model)
        restaurantInfoView.configure(with: model)
    }
    
    /*
     mainStack
        headerStack
            headerImageView
            restaurantHeaderView
            restaurantInfoView
        filtersStack
            menuTimeView
            menuCategoryView
        menuItemListView
     */
    
    func setupLayoutAndConstraints() {
        backgroundColor = .light100
        
        let headerStack = UIStackView(arrangedSubviews: [headerImageView])
        headerStack.axis = .vertical
        headerStack.translatesAutoresizingMaskIntoConstraints = false
       
        let restaurantStack = UIStackView(arrangedSubviews: [restaurantHeaderView, restaurantInfoView])
        restaurantStack.axis = .vertical
        restaurantStack.spacing = 22
        restaurantStack.alignment = .center
        restaurantStack.translatesAutoresizingMaskIntoConstraints = false
        
        let filtersStack = UIStackView(arrangedSubviews: [menuTimeView, menuCategoryView])
        filtersStack.axis = .vertical
        filtersStack.spacing = 18
        filtersStack.alignment = .center
        filtersStack.translatesAutoresizingMaskIntoConstraints = false
        
        let itemListStack = UIStackView(arrangedSubviews: [menuItemListView])
        itemListStack.axis = .vertical
        itemListStack.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.addSubview(headerStack)
        scrollView.addSubview(restaurantStack)
        scrollView.addSubview(filtersStack)
        scrollView.addSubview(itemListStack)
        
        headerImageViewHeightConstraint = headerImageView.heightAnchor.constraint(equalToConstant: 164)
        restaurantInfoViewHeightConstraint = restaurantInfoView.heightAnchor.constraint(equalToConstant: 109)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headerStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
           
            restaurantStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 18),
            restaurantStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 21),
            restaurantStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -21),
            restaurantStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -21*2),
            
            filtersStack.topAnchor.constraint(equalTo: restaurantStack.bottomAnchor, constant: 18),
            filtersStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            filtersStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
        ])
    }
    
    func adjustForSmallScreens() {
        if UIScreen.main.bounds.height < 670 {
            headerImageView.isHidden = true
            headerImageViewHeightConstraint.constant = 0
        }
    }
}
