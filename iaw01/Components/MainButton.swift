//
//  MainButton.swift
//  iaw01
//
//  Created by Евгений on 14.03.25.
//

import UIKit

// Перечисление для доступных SF Symbols иконок
enum ButtonIcon {
    case checkmarkCircleFill
    case checkmarkCircle
    case chevronRight
    case dotScope
    
    var image: UIImage? {
        switch self {
        case .checkmarkCircleFill: return UIImage(systemName: "checkmark.circle.fill")
        case .checkmarkCircle: return UIImage(systemName: "checkmark.circle")
        case .chevronRight: return UIImage(systemName: "chevron.right")
        case .dotScope: return UIImage(systemName: "dot.scope")
        }
    }
}

// Перечисление для стилей кнопок
enum ButtonStyle {
    case blue
    case pink
    case dark
    case light
    
    // Цвет фона кнопки
    var backgroundColor: UIColor {
        switch self {
        case .blue: return UIColor(resource: .blue100)
        case .pink: return UIColor(resource: .pink100)
        case .dark: return UIColor(resource: .dark100)
        case .light: return UIColor(resource: .light100)
        }
    }
    
    // Цвет фона кнопки в неактивном состоянии
    var disabledBackgroundColor: UIColor {
        switch self {
        case .blue: return UIColor(resource: .blue60)
        case .pink: return UIColor(resource: .pink60)
        case .dark: return UIColor(resource: .dark60)
        case .light: return UIColor(resource: .light80)
        }
    }
    
    // Цвет текста кнопки
    var textColor: UIColor {
        switch self {
        case .light: return UIColor(resource: .dark90)
        default: return UIColor(resource: .light100)
        }
    }
}

// Перечисление для позиций иконки в кнопке
enum IconPosition {
    case left
    case right
}

class MainButton: UIButton {
    // Свойство для хранения изображения
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Свойство для хранения текста кнопки
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.font = Font.button
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Свойство вьюхи
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // Свойство для хранения текущего стиля кнопки
    private var currentStyle: ButtonStyle = .blue
    
    // Инициализация кнопки
    init(style: ButtonStyle = .blue,
         title: String,
         icon: ButtonIcon? = nil,
         iconPosition: IconPosition = .right,
         isEnabled: Bool = true) {
        super.init(frame: .zero)
        self.currentStyle = style
        setupButton(style: style, title: title, icon: icon, iconPosition: iconPosition)
        self.isEnabled = isEnabled
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // настройка кнопки
    private func setupButton(style: ButtonStyle,
                           title: String,
                           icon: ButtonIcon?,
                           iconPosition: IconPosition) {
        backgroundColor = style.backgroundColor
        layer.cornerRadius = 18
        
        setupStackView()
        setupTitleLabel(title: title, style: style)
        
        if let icon = icon {
            setupIcon(icon: icon, style: style, position: iconPosition)
        }
        
        setupConstraints()
    }

    private func setupStackView() {
        addSubview(stackView)
    }
    
    // настройка текста кнопки
    private func setupTitleLabel(title: String, style: ButtonStyle) {
        buttonLabel.text = title
        buttonLabel.textColor = style.textColor
        stackView.addArrangedSubview(buttonLabel)
    }
    
    // настройка иконки кнопки
    private func setupIcon(icon: ButtonIcon, style: ButtonStyle, position: IconPosition) {
        iconImageView.image = icon.image
        iconImageView.tintColor = style.textColor
        
        switch position {
        case .left:
            stackView.insertArrangedSubview(iconImageView, at: 0)
        case .right:
            stackView.addArrangedSubview(iconImageView)
        }
    }
    
    // настройка констрейнтов
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    // настройка текста кнопки
    func setTitle(_ title: String) {
        buttonLabel.text = title
    }
    
    // настройка иконки кнопки
    func setIcon(_ icon: ButtonIcon?, position: IconPosition = .left) {
        iconImageView.image = icon?.image
        iconImageView.isHidden = icon == nil
        
        if icon != nil {
            // Удаляем иконку из текущей позиции
            iconImageView.removeFromSuperview()
            
            // Добавляем в новую позицию
            switch position {
            case .left:
                stackView.insertArrangedSubview(iconImageView, at: 0)
            case .right:
                stackView.addArrangedSubview(iconImageView)
            }
        }
    }
    
    // настройка стиля кнопки
    func setStyle(_ style: ButtonStyle) {
        currentStyle = style
        updateAppearance()
    }
    
    // активность кнопки
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    private func updateAppearance() {
        backgroundColor = isEnabled ? currentStyle.backgroundColor : currentStyle.disabledBackgroundColor
        // Цвет текста и иконки не меняется при неактивном состоянии
        alpha = isEnabled ? 1.0 : 0.6
    }
}
