import UIKit

final class DummyView: UIView {
    
    var scenes: [SceneModel] = []
    var route: ((SceneType) -> Void)?

    private lazy var scenesTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ScenesTableViewCell.self, forCellReuseIdentifier: ScenesTableViewCell.cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        backgroundColor = .light100
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        addSubview(scenesTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scenesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scenesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scenesTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            scenesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension DummyView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        route?(scenes[indexPath.row].sceneType)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

extension DummyView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scenes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScenesTableViewCell.cellId, for: indexPath) as? ScenesTableViewCell else { return UITableViewCell() }
        cell.model = scenes[indexPath.row]
        return cell
    }
}
