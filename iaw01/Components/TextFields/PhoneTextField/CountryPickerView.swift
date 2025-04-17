import UIKit

final class CountryPickerView: UITableView {
    
    var onCountrySelected: ((CountryCodeModel) -> Void)?
    
    private let phoneCountries = CountryCodeModel.countryCodes
    
    init() {
        super.init(frame: .zero, style: .plain)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        rowHeight = 40
        backgroundColor = .light80
        dataSource = self
        delegate = self
        layer.cornerRadius = 16
        layer.borderColor = UIColor.light60.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        register(CountryPickerCell.self, forCellReuseIdentifier: CountryPickerCell.cellIdentifier)
    }
}

extension CountryPickerView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        phoneCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryPickerCell.cellIdentifier, for: indexPath) as? CountryPickerCell
        else {
            return UITableViewCell()
        }
        
        cell.country = phoneCountries[indexPath.row]
        return cell
    }
}

extension CountryPickerView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onCountrySelected?(phoneCountries[indexPath.row])
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(translationX: 0, y: 20)
            self.alpha = 0
        } completion: { _ in
            self.isHidden = true
            self.transform = .identity
            self.alpha = 1
        }
    }
}
