import UIKit

final class HeaderView: UIView {
    
    var model: RestaurantModel = .empty {
        didSet {
            imageView.image = model.image
            restaurantHeaderView.model = model
            restaurantInfoView.model = model
        }
    }
    
    let restaurantHeaderView = RestaurantHeaderView()
    let restaurantInfoView = RestaurantInfoView()
    
    var headerImageViewHeightConstraint: NSLayoutConstraint!
    var restaurantInfoViewHeightConstraint: NSLayoutConstraint!
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let restaurantStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        adjustForSmallScreens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        addSubview(mainStack)
        
        mainStack.addArrangedSubview(imageView)
        mainStack.addArrangedSubview(viewContainer)
        
        viewContainer.addSubview(restaurantStack)
        
        restaurantStack.addArrangedSubview(restaurantHeaderView)
        restaurantStack.addArrangedSubview(restaurantInfoView)
    }
    
    private func setupConstraints() {
        headerImageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 164)
        restaurantInfoViewHeightConstraint = restaurantInfoView.heightAnchor.constraint(equalToConstant: 109)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            viewContainer.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor),
            
            restaurantStack.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            restaurantStack.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor,constant: 16),
            restaurantStack.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -16),
            restaurantStack.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            
            headerImageViewHeightConstraint,
            restaurantInfoViewHeightConstraint
        ])
    }
    
    private func adjustForSmallScreens() {
        guard !Constans.isSE else {
            imageView.isHidden = true
            restaurantInfoView.isHidden = true
            return
        }
    }
}

/* РЕАЛИЗОВАТЬ ПОЗЖЕ ВО ВЬЮ
 
 extension RestaurantViewController: UIScrollViewDelegate {
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let offset = scrollView.contentOffset.y
         
         let newHeaderImageViewHeightConstraint = max(164 - offset, 0)
         let newRestaurantInfoViewHeightConstraint = max(109 - offset / 2, 0)
         
         restaurantView.headerView.headerImageViewHeightConstraint.constant = newHeaderImageViewHeightConstraint
         restaurantView.headerView.restaurantInfoViewHeightConstraint.constant = newRestaurantInfoViewHeightConstraint
         
         if newHeaderImageViewHeightConstraint == 0 {
             restaurantView.headerView.restaurantHeaderView.transform = CGAffineTransform(translationX: 0, y: -offset + 164)
             restaurantView.filtersView.menuTimeView.transform = CGAffineTransform(translationX: 0, y: -offset + 164)
             restaurantView.filtersView.menuCategoryView.transform = CGAffineTransform(translationX: 0, y: -offset + 164)
         } else {
             restaurantView.headerView.restaurantHeaderView.transform = .identity
             restaurantView.filtersView.menuTimeView.transform = .identity
             restaurantView.filtersView.menuCategoryView.transform = .identity
         }
     }
 }
 */
