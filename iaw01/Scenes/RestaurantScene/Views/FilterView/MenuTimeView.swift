import UIKit

protocol MenuTimeViewDelegate: AnyObject {
    
    func didSelectMenu(_ menu: MenuModel)
}

final class MenuTimeView: UIView {
    
    weak var delegate: MenuTimeViewDelegate?
    
    var model: RestaurantModel = .empty {
        didSet {
            configure(with: model.menu)
        }
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 29
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .dark100
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var menuOptions: [MenuModel] = []
    private var buttons: [UIButton] = []
    private var selectedButton: UIButton?
    private var underlineLeadingConstraint: NSLayoutConstraint!
    private var underlineWidthConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with menus: [MenuModel]) {
        self.menuOptions = menus
        
        buttons.forEach { $0.removeFromSuperview()}
        buttons.removeAll()
        
        for menu in menus {
            let button = createButton(title: menu.name)
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        if let defaultButton = buttons.dropFirst().first {
            scrollView.addSubview(underlineView)
            
            underlineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
            underlineView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
            
            underlineLeadingConstraint = underlineView.leadingAnchor.constraint(equalTo: defaultButton.leadingAnchor, constant: -3)
            underlineLeadingConstraint.isActive = true
            
            underlineWidthConstraint = underlineView.widthAnchor.constraint(equalTo: defaultButton.widthAnchor, constant: 6)
            underlineWidthConstraint.isActive = true
            
            selectButton(defaultButton)
        }
    }
    
    func createButton(title: String) -> UIButton {
        var config = UIButton.Configuration.plain()
        
        config.baseForegroundColor = .dark60
        config.background.backgroundColor = .clear
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer().font(Font.body.font))
       
        let button = UIButton(configuration: config)
        
        button.configurationUpdateHandler = { btn in
            var newConfig = btn.configuration
            newConfig?.baseForegroundColor = btn.isSelected ? .dark100 : .dark60
            newConfig?.attributedTitle = AttributedString(
                title,
                attributes: AttributeContainer().font(btn.isSelected ? Font.segment.font : Font.body.font)
            )
            btn.configuration = newConfig
        }
        
        button.addTarget(self, action: #selector(menuTapped(_:)), for: .touchUpInside)
        
        return button
    }

    @objc func menuTapped(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else { return }
        selectButton(sender)
        delegate?.didSelectMenu(menuOptions[index])
    }
    
    func selectButton(_ button: UIButton) {
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
        
        buttons.forEach { $0.setTitleColor(.dark60, for: .normal) }
        button.setTitleColor(.dark100, for: .normal)
        
        underlineLeadingConstraint.isActive = false
        underlineWidthConstraint.isActive = false
        
        underlineLeadingConstraint = underlineView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: -3)
        underlineLeadingConstraint.isActive = true
        
        underlineWidthConstraint = underlineView.widthAnchor.constraint(equalTo: button.widthAnchor, constant: 6)
        underlineWidthConstraint.isActive = true
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
    
    func setupLayoutAndConstraints() {
        scrollView.backgroundColor = .light80
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(underlineView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 59),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            stackView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor)
        ])
    }
}
