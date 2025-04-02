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
       
        let headerStack = UIStackView(arrangedSubviews: [headerImageView, restaurantHeaderView, restaurantInfoView])
        headerStack.axis = .vertical
        headerStack.spacing = 22
        headerStack.alignment = .center
        
        let filtersStack = UIStackView(arrangedSubviews: [menuTimeView, menuCategoryView])
        filtersStack.axis = .vertical
        filtersStack.spacing = 18
        filtersStack.alignment = .center
        
        let mainStack = UIStackView(arrangedSubviews: [headerStack, filtersStack, menuItemListView])
        mainStack.axis = .vertical
        mainStack.setCustomSpacing(18, after: headerStack)
        mainStack.setCustomSpacing(9, after: filtersStack)
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.addSubview(mainStack)
        
        headerImageViewHeightConstraint = headerImageView.heightAnchor.constraint(equalToConstant: 164)
        restaurantInfoViewHeightConstraint = restaurantInfoView.heightAnchor.constraint(equalToConstant: 109)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
           
            
            mainStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 21),
            mainStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -21),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -21*2),
            mainStack.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
   
            ///headerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            ///headerImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            ///headerImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
    }
    
    func adjustForSmallScreens() {
        if UIScreen.main.bounds.height < 670 {
            headerImageView.isHidden = true
            headerImageViewHeightConstraint.constant = 0
        }
    }
}
/*
 func setupLayoutAndConstraints() {
         backgroundColor = .light100
         
         let headerStack = UIStackView(arrangedSubviews: [restaurantHeaderView, restaurantInfoView])
         headerStack.axis = .vertical
         headerStack.spacing = 22
         headerStack.alignment = .center
         headerStack.setCustomSpacing(18, after: restaurantInfoView)
         
         let filtersStack = UIStackView(arrangedSubviews: [menuTimeView, menuCategoryView])
         filtersStack.axis = .vertical
         filtersStack.spacing = 18
         filtersStack.alignment = .center
         filtersStack.translatesAutoresizingMaskIntoConstraints = false
         filtersStack.setCustomSpacing(9, after: menuCategoryView)
         
         scrollView.showsVerticalScrollIndicator = false
         scrollView.translatesAutoresizingMaskIntoConstraints = false
         addSubview(scrollView)
         scrollView.addSubview(headerImageView)
         scrollView.addSubview(headerStack)
         scrollView.addSubview(filtersStack)
         
         headerImageViewHeightConstraint = headerImageView.heightAnchor.constraint(equalToConstant: 164)
         restaurantInfoViewHeightConstraint = restaurantInfoView.heightAnchor.constraint(equalToConstant: 109)
         
         NSLayoutConstraint.activate([
             scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
             scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
             scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
             
             headerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
             headerImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
             headerImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
             headerImageView.heightAnchor.constraint(equalToConstant: 164),
             
             headerStack.topAnchor.constraint(equalTo: headerImageView.bottomAnchor),
             headerStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 21),
             headerStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -21),
             ///headerStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
             
             filtersStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor),
             filtersStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
             filtersStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
         ])
     }
 */
