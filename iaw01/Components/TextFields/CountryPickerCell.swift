import UIKit

final class CountryPickerCell: UITableViewCell {
    
    private let flagAndCodeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let countryCodeLable: UILabel = {
        let label = UILabel()
        label.font = Font.body.font
        return label
    }()
    
    private let countryFlagLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayoutAndConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutAndConstraints() {
        contentView.addSubview(flagAndCodeStackView)
        flagAndCodeStackView.addArrangedSubview(countryCodeLable)
        flagAndCodeStackView.addArrangedSubview(countryFlagLabel)
        
        NSLayoutConstraint.activate([
            flagAndCodeStackView.topAnchor.constraint(equalTo: topAnchor),
            flagAndCodeStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            flagAndCodeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            flagAndCodeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func configure(with country: PhoneCountry) {
        countryFlagLabel.text = country.flag
        countryCodeLable.text = country.phoneCode
    }
}
