import UIKit

final class CountryPickerView: UIView {
    
    var onCountrySelected: ((CountryCodeModel) -> Void)?
    
    private let phoneCountries = CountryCodeModel.countryCodes
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CountryPickerCell.self, forCellReuseIdentifier: "CountryPickerCell")
        table.rowHeight = 40
        table.backgroundColor = .light80
        table.showsVerticalScrollIndicator = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func configureView() {
        layer.cornerRadius = 16
        layer.borderColor = UIColor.light60.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
    }
}

extension CountryPickerView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        phoneCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryPickerCell", for: indexPath) as? CountryPickerCell
        else {
            return UITableViewCell()
        }
        
        let country = phoneCountries[indexPath.row]
        cell.configure(with: country)
        return cell
    }
}

extension CountryPickerView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onCountrySelected?(phoneCountries[indexPath.row])
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 20)
            self.alpha = 0
        }) { _ in
            self.isHidden = true
            self.transform = .identity
            self.alpha = 1
        }
    }
}
