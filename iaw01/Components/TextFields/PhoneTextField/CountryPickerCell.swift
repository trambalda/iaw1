import UIKit

final class CountryPickerCell: UITableViewCell {
    
    static let cellIdentifier = "CountryPickerCell"
    
    var country: CountryCodeModel? {
        didSet {
            countryFlagLabel.text = country?.flag
            countryCodeLabel.text = country?.code
        }
    }
    
    private let flagAndCodeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 3
        return stack
    }()
    
    private let countryFlagLabel = UILabel()
    
    private let countryCodeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body.font
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
        flagAndCodeStackView.addArrangedSubview(countryFlagLabel)
        flagAndCodeStackView.addArrangedSubview(countryCodeLabel)
        
        NSLayoutConstraint.activate([
            flagAndCodeStackView.topAnchor.constraint(equalTo: topAnchor),
            flagAndCodeStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            flagAndCodeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
        ])
    }
}
