import UIKit

final class NewAndTrendingView: UIView {
    
    var imageService: ImageServiceProtocol?
    
    var model: [NewAndTrendingModel] = [] {
        didSet {
            newsAndTradingCollection.reloadData()
            updateEmptyState()
        }
    }
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 14
        return stack
    }()
    
    private let newsAndTradingLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.subtitle2.compose("New & Trending", color: .dark100)
        return label
    }()
    
    private lazy var newsAndTradingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 18
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 202, height: 158)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.layer.cornerRadius = 8
        collection.dataSource = self
        collection.delegate = self
        collection.register(NewAndTrendingViewCell.self, forCellWithReuseIdentifier: NewAndTrendingViewCell.cellIdentifier)
        return collection
    }()
    
    init() {
        super.init(frame: .zero)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(newsAndTradingLabel)
        containerStackView.addArrangedSubview(newsAndTradingCollection)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            newsAndTradingCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsAndTradingCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsAndTradingCollection.heightAnchor.constraint(equalToConstant: 158),
        ])
    }
    
    private func updateEmptyState() {
        let isEmpty = model.isEmpty
        containerStackView.isHidden = isEmpty
    }
}

extension NewAndTrendingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewAndTrendingViewCell.cellIdentifier, for: indexPath) as? NewAndTrendingViewCell else {
            return UICollectionViewCell()
        }
        cell.model = model[indexPath.item]
        cell.imageService = imageService
        return cell
    }
}

extension NewAndTrendingView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(model[indexPath.item])
    }
}
