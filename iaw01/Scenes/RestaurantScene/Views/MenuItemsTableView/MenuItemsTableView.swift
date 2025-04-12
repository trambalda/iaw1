import UIKit

final class MenuItemsTableView: UITableView {
    
    var models: [MenuItemListModel] = [] {
        didSet {
            reloadData()
        }
    }
    
    var cellHeight: CGFloat = 100 {
        didSet {
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        register(MenuItemsTableViewCell.self, forCellReuseIdentifier: MenuItemsTableViewCell.identifier)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuItemsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
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
        return cellHeight
    }
}
