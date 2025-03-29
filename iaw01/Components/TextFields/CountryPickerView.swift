import UIKit

final class CountryPickerView: UIView {
    
    var onCountrySelected: ((PhoneCountry) -> Void)?
    
    private let phoneCountries = PhoneCountry.allCountries
    
    private var selectedCountry: PhoneCountry?
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.blue120, for: .normal)
        button.titleLabel?.font = Font.body.font
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CountryPickerCell.self, forCellReuseIdentifier: "CountryPickerCell")
        table.rowHeight = 50
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .light80
        layer.cornerRadius = 16
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(tableView)
        addSubview(doneButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: topAnchor),
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            doneButton.heightAnchor.constraint(equalToConstant: 35),
            
            tableView.topAnchor.constraint(equalTo: doneButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func doneButtonTapped() {
        if let selectedCountry = selectedCountry {
            onCountrySelected?(selectedCountry)
        }
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
        selectedCountry = phoneCountries[indexPath.row]
    }
}
