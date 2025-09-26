//
//  FavoriteItem.swift
//  E-Commerce
//
//  Created by MohamedBadawi on 27/09/2025.
//


import UIKit

// MARK: - Favorite Item Model
struct FavoriteItem {
    let image: UIImage?
    let name: String
    let price: Int
    var isFavorited: Bool
}

// MARK: - Favorite Item Cell
final class FavoriteItemCell: UITableViewCell {
    
    private let cardView = UIView()
    private let imageBackgroundView = UIView()
    private let productImage = UIImageView()
    private let nameLabel = UILabel()
    private let currencyIcon = UIImageView()
    private let priceLabel = UILabel()
    
    // Stack view containing currency icon and price label horizontally arranged
    private lazy var priceStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [currencyIcon, priceLabel])
        s.axis = .horizontal
        s.spacing = 4
        s.alignment = .center
        return s
    }()
    
    // Love/Heart button for favorites
    private let loveButton = UIButton(type: .system)
    
    // Callback for love button tap
    var onLoveButtonTapped: (() -> Void)?

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - View Setup
    private func setupViews() {
        // Main card container setup
        cardView.backgroundColor = .grayF8F8F8
        cardView.layer.cornerRadius = 12
        cardView.layer.masksToBounds = true
        contentView.addSubview(cardView)
        
        // Image background setup
        imageBackgroundView.layer.cornerRadius = 12
        imageBackgroundView.clipsToBounds = true
        cardView.addSubview(imageBackgroundView)
        
        // Product image setup
        productImage.contentMode = .scaleAspectFit
        imageBackgroundView.addSubview(productImage)
        
        // Name label setup
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameLabel.numberOfLines = 2
        nameLabel.textColor = .black
        cardView.addSubview(nameLabel)
        
        // Currency icon setup
        currencyIcon.image = UIImage(named: "currency")
        currencyIcon.contentMode = .scaleAspectFit
        
        // Price label setup
        priceLabel.font = .boldSystemFont(ofSize: 16)
        priceLabel.textColor = .black
        cardView.addSubview(priceStack)
        
        // Love button setup
        setupLoveButton()
    }
    
    private func setupLoveButton() {
        // Configure love button with heart symbols
        loveButton.tintColor = .red
        loveButton.backgroundColor = .white
        loveButton.layer.cornerRadius = 18 // Circular button
        loveButton.layer.borderWidth = 1
        loveButton.layer.borderColor = UIColor.red.cgColor
        
        // Add target for button tap
        loveButton.addTarget(self, action: #selector(loveButtonTapped), for: .touchUpInside)
        
        cardView.addSubview(loveButton)
    }
    
    @objc private func loveButtonTapped() {
        // Toggle button state with animation
        UIView.animate(withDuration: 0.1, animations: {
            self.loveButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.loveButton.transform = CGAffineTransform.identity
            }
        }
        
        // Call callback
        onLoveButtonTapped?()
    }
    
    // MARK: - Constraints Setup
    private func setupConstraints() {
        // Disable autoresizing masks for all components
        [cardView, imageBackgroundView, productImage, nameLabel, priceStack, loveButton, currencyIcon, priceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            // Card view constraints
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14.5),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14.5),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Image background constraints
            imageBackgroundView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            imageBackgroundView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            imageBackgroundView.widthAnchor.constraint(equalToConstant: 110),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 87),
            
            // Product image constraints
            productImage.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
            productImage.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            productImage.widthAnchor.constraint(equalToConstant: 60),
            productImage.heightAnchor.constraint(equalToConstant: 60),
            
            // Name label constraints
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: loveButton.leadingAnchor, constant: -12),
            
            // Price stack constraints
            priceStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceStack.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            // Currency icon size
            currencyIcon.widthAnchor.constraint(equalToConstant: 16),
            currencyIcon.heightAnchor.constraint(equalToConstant: 16),
            
            // Love button constraints
            loveButton.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            loveButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            loveButton.heightAnchor.constraint(equalToConstant: 36),
            loveButton.widthAnchor.constraint(equalToConstant: 36)
        ])
    }

    // MARK: - Cell Configuration
    func configure(with item: FavoriteItem) {
        productImage.image = item.image
        nameLabel.text = item.name
        priceLabel.text = "\(item.price.formatted())"
        
        // Configure love button based on favorite state
        updateLoveButtonAppearance(isFavorited: item.isFavorited)
        
        // Set image background color
        imageBackgroundView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 215/255, alpha: 1)
    }
    
    private func updateLoveButtonAppearance(isFavorited: Bool) {
        if isFavorited {
            // Filled heart for favorited items
            loveButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            loveButton.backgroundColor = .red
            loveButton.tintColor = .white
        } else {
            // Empty heart for non-favorited items
            loveButton.setImage(UIImage(systemName: "heart"), for: .normal)
            loveButton.backgroundColor = .white
            loveButton.tintColor = .red
        }
    }
}

// MARK: - Favorite View Controller
final class FavoriteVC: UIViewController {

    // MARK: - Properties
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var favoriteItems: [FavoriteItem] = [
        FavoriteItem(image: UIImage(named: "Vector_1"), name: "Apple W-series 6", price: 45000, isFavorited: true),
        FavoriteItem(image: UIImage(named: "Vector_1"), name: "Siberia 800", price: 45000, isFavorited: false),
        FavoriteItem(image: UIImage(named: "Vector_1"), name: "Lycra Men's shirt", price: 45000, isFavorited: true),
        FavoriteItem(image: UIImage(named: "Vector_1"), name: "Nike/L v Airforce 1", price: 45000, isFavorited: false)
    ]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        
        view.backgroundColor = .white
        
        setupTableView()
    }

    // MARK: - Table View Setup
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        tableView.register(FavoriteItemCell.self, forCellReuseIdentifier: "favoriteCell")

        // Table view constraints - full screen (no bottom bar)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Helper Methods
    private func toggleFavorite(at index: Int) {
        favoriteItems[index].isFavorited.toggle()
        
        // Reload specific cell with animation
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
        
        // Here you could also save to UserDefaults, Core Data, or send to server
        print("Item \(favoriteItems[index].name) favorite state: \(favoriteItems[index].isFavorited)")
    }
}

// MARK: - Table View Data Source & Delegate
extension FavoriteVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144 // Same height as cart cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteItemCell else {
            return UITableViewCell()
        }
        
        let item = favoriteItems[indexPath.row]
        cell.configure(with: item)
        
        // Set up love button callback
        cell.onLoveButtonTapped = { [weak self] in
            self?.toggleFavorite(at: indexPath.row)
        }
        
        return cell
    }
}
