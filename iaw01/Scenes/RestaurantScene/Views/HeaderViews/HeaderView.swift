import UIKit

final class HeaderView: UIStackView {
    
    var model: RestaurantModel = .empty {
        didSet {
            imageView.image = UIImage(named: model.image)
            restaurantHeaderView.model = model
            restaurantInfoView.model = model
        }
    }
    
    private let restaurantHeaderView = RestaurantHeaderView()
    private let restaurantInfoView = RestaurantInfoView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let restaurantInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let restaurantInfoContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        adjustForSmallScreens()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     imageView
     restaurantInfoContainer
        restaurantInfoStack
            restaurantHeaderView
            restaurantInfoView
     */
    
    private func configure() {
        axis = .vertical
        
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        addArrangedSubview(imageView)
        addArrangedSubview(restaurantInfoContainer)
        
        restaurantInfoContainer.addSubview(restaurantInfoStackView)
        
        restaurantInfoStackView.addArrangedSubview(restaurantHeaderView)
        restaurantInfoStackView.addArrangedSubview(restaurantInfoView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            restaurantInfoStackView.topAnchor.constraint(equalTo: restaurantInfoContainer.topAnchor, constant: 20),
            restaurantInfoStackView.leadingAnchor.constraint(equalTo: restaurantInfoContainer.leadingAnchor,constant: 16),
            restaurantInfoStackView.trailingAnchor.constraint(equalTo: restaurantInfoContainer.trailingAnchor, constant: -16),
            restaurantInfoStackView.bottomAnchor.constraint(equalTo: restaurantInfoContainer.bottomAnchor),
        ])
    }
    
    private func adjustForSmallScreens() {
        guard Constants.isSE else { return }
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
