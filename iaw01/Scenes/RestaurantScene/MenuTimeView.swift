import UIKit

protocol MenuTimeViewDelegate: AnyObject {
    func didSelectMenu(_ menu: MenuModel)
}

final class MenuTimeView: UIView {
    weak var delegate: MenuTimeViewDelegate?
    
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
            let button = createButton(title: menu.title)
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        if let firstButton = buttons.first {
            selectButton(firstButton)
            
            underlineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
            underlineView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
            underlineView.widthAnchor.constraint(equalTo: firstButton.widthAnchor, constant: 6).isActive = true
            underlineLeadingConstraint = underlineView.leadingAnchor.constraint(equalTo: firstButton.leadingAnchor)
            underlineLeadingConstraint.isActive = true
        }
    }
    
    func createButton(title: String) -> UIButton {
        let button = UIButton(type: . system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.dark100, for: .selected)
        button.setTitleColor(.dark60, for: .normal)
        button.setTitleFont(Font.segment.font, for: .selected)
        button.setTitleFont(Font.body.font, for: .normal)
        button.titleLabel?.font = Font.body.font
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
        
        UIView.animate(withDuration: 0.25) {
            self.underlineLeadingConstraint.constant = button.frame.origin.x - self.stackView.frame.origin.x
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
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
}
