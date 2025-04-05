import UIKit

final class MenuTimeView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let menuOptions: [MenuModel] = [
        MenuModel(title: "Breakfast Menu"),
        MenuModel(title: "Lunch & Dinner"),
        MenuModel(title: "Overnight Menu")
    ]

    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: menuOptions.map { $0.title })
        control.selectedSegmentIndex = 1
        control.backgroundColor = .light80
        
        let attributesForSelected: [NSAttributedString.Key: Any] = [
            .font: Font.segment.font,
            .foregroundColor: UIColor.dark100
        ]
        let attributesForNormal: [NSAttributedString.Key: Any] = [
            .font: Font.body.font,
            .foregroundColor: UIColor.dark60
        ]
        
        control.setTitleTextAttributes(attributesForSelected, for: .selected)
        control.setTitleTextAttributes(attributesForNormal, for: .normal)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayoutAndConstraints() {
        scrollView.backgroundColor = .light80
        addSubview(scrollView)
        scrollView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 59),
            
            segmentedControl.topAnchor.constraint(equalTo: scrollView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            segmentedControl.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
}
