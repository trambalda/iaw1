import UIKit

final class MenuItemsTableView: UITableView {
    
    var models: [MenuItemListModel] = [] {
        didSet {
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)
        configure()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        delegate = self
        dataSource = self
        register(MenuItemsTableViewCell.self, forCellReuseIdentifier: MenuItemsTableViewCell.identifier)
    }
}

extension MenuItemsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MenuItemsTableViewCell.identifier,
            for: indexPath
        ) as? MenuItemsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.model = models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MenuItemsTableViewCell.cellHeight
    }
}
