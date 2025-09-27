import UIKit



struct CartItem {
    let image: UIImage?
    let name: String
    let price: Int
    var quantity: Int
}

final class CartItemCell: UITableViewCell {


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
    
    // Quantity stepper components
    private let minusButton = UIButton(type: .system)
    private let qtyLabel = UILabel()
    private let plusButton = UIButton(type: .system)
    
    // Stack view containing minus button, quantity label, and plus button
    private lazy var stepperStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [minusButton, qtyLabel, plusButton])
        s.axis = .horizontal                           // Horizontal arrangement
        s.spacing = 4                                  // 4pt spacing between elements
        s.distribution = .fillEqually               // Equal spacing distribution
        s.alignment = .center                          // Center align items vertically
        return s
    }()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        ////////////
        backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }


    required init?(coder: NSCoder) { fatalError() }

    // MARK: - View Setup
    // Configure visual properties and hierarchy of all UI components
    private func setupViews() {
        // Main card container setup
        cardView.backgroundColor = .grayF8F8F8
        cardView.layer.cornerRadius = 12
        cardView.layer.masksToBounds = true
        contentView.addSubview(cardView)
        
        
        imageBackgroundView.layer.cornerRadius = 12
        imageBackgroundView.clipsToBounds = true
        cardView.addSubview(imageBackgroundView)

        
        
        productImage.contentMode = .scaleAspectFit
        imageBackgroundView.addSubview(productImage)
        

        
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameLabel.numberOfLines = 2
        nameLabel.textColor = .black
        cardView.addSubview(nameLabel)

        
        
        currencyIcon.image = UIImage(named: "currency")
        currencyIcon.contentMode = .scaleAspectFit
        
        
        
        priceLabel.font = .boldSystemFont(ofSize: 16)
        priceLabel.textColor = .black
        cardView.addSubview(priceStack)
        

        
        minusButton.setTitle("–", for: .normal)
        minusButton.setTitleColor(.orange, for: .normal)
        minusButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.orange, for: .normal)
        plusButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        
        
        qtyLabel.textAlignment = .center
        qtyLabel.font = .systemFont(ofSize: 12, weight: .medium)
        qtyLabel.textColor = .black
        
        
        stepperStack.layer.borderColor = UIColor.orange.cgColor
        stepperStack.layer.borderWidth = 1
        stepperStack.layer.cornerRadius = 8
        stepperStack.backgroundColor = .white
        cardView.addSubview(stepperStack)
    }

    
    // MARK: - Constraints Setup
    // Configure Auto Layout constraints for all UI components with 29pt spacing between cards
    private func setupConstraints() {
        // Disable autoresizing masks for all components (required for Auto Layout)
        [cardView, imageBackgroundView, productImage, nameLabel, priceStack, stepperStack, currencyIcon, priceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
   
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14.5),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14.5),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            

            
            imageBackgroundView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            imageBackgroundView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            imageBackgroundView.widthAnchor.constraint(equalToConstant: 110),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 87),
            
            

            // Product image - centered within background container
            productImage.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
            productImage.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            productImage.widthAnchor.constraint(equalToConstant: 60),
            productImage.heightAnchor.constraint(equalToConstant: 60),
            
            

            
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: stepperStack.leadingAnchor, constant: -12),

            
            
            // Price stack (currency icon + price) - positioned below name
            priceStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),            priceStack.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            
            currencyIcon.widthAnchor.constraint(equalToConstant: 16),
            currencyIcon.heightAnchor.constraint(equalToConstant: 16),

            
            stepperStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            stepperStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            stepperStack.heightAnchor.constraint(equalToConstant: 36),
            stepperStack.widthAnchor.constraint(equalToConstant: 67)
        ])
    }

    // MARK: - Cell Configuration
    // Configure cell with cart item data and set appropriate background colors
    func configure(with item: CartItem) {
        productImage.image = item.image
        nameLabel.text = item.name
        priceLabel.text = "\(item.price.formatted())"
        qtyLabel.text = "\(item.quantity)"
        
        imageBackgroundView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 215/255, alpha: 1)
        
    }
}

// MARK: - Cart View Controller
// Main view controller managing the shopping cart interface with white table view background
final class CartVC: UIViewController {

    // MARK: - Properties
    private let tableView = UITableView(frame: .zero, style: .plain)
    

    private var items: [CartItem] = [
        CartItem(image: UIImage(named: "Vector_1"), name: "Apple W-series 6", price: 45000, quantity: 2),
        CartItem(image: UIImage(named: "Vector_1"), name: "Siberia 800", price: 45000, quantity: 1),
        CartItem(image: UIImage(named: "Vector_1"), name: "Lycra Men's shirt", price: 45000, quantity: 99),
        CartItem(image: UIImage(named: "Vector_1"), name: "Nike/L v Airforce 1", price: 45000, quantity: 85568)
    ]

    // Bottom section UI components
    private let totalLabel = UILabel()
    private let buyButton = UIButton(type: .system)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My cart"
        
        
        view.backgroundColor = .white
        
        setupTableView()
        setupBottomBar()
        updateTotal()
    }

    // MARK: - Table View Setup
    // Configure table view properties and constraints with WHITE background
    private func setupTableView() {
        view.addSubview(tableView)                     // Add table view to main view
        tableView.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        tableView.dataSource = self                    // Set data source delegate
        tableView.delegate = self                      // Set table view delegate
        tableView.separatorStyle = .none               // Remove default cell separators
        
        // TABLE VIEW BACKGROUND: Explicitly set to WHITE (not gray)
        tableView.backgroundColor = .white             // Set table view background to WHITE
        
        tableView.register(CartItemCell.self, forCellReuseIdentifier: "cell") // Register custom cell

        // Table view constraints - full width, leaving space for bottom bar
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),      // Start below navigation
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),                  // Full width leading
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),               // Full width trailing
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -140) // Space for bottom bar
        ])
    }

    // MARK: - Bottom Bar Setup
    // Configure total display and buy button at bottom of screen

    private func setupBottomBar() {
        let bottomBar = UIView()
        bottomBar.backgroundColor = .white
        view.addSubview(bottomBar)
        bottomBar.translatesAutoresizingMaskIntoConstraints = false

        // Currency icon for total amount
        let currencyIcon = UIImageView()
        currencyIcon.image = UIImage(named: "orangeVector")  // Using orangeVector from assets
        currencyIcon.contentMode = .scaleAspectFit
        
        // Total amount label setup
        totalLabel.font = .boldSystemFont(ofSize: 20)
        totalLabel.textColor = .orange
        totalLabel.textAlignment = .left  // Left align for stack arrangement

        // Stack view containing currency icon and total amount
        let totalStack = UIStackView(arrangedSubviews: [currencyIcon, totalLabel])
        totalStack.axis = .horizontal
        totalStack.spacing = 4
        totalStack.alignment = .center
        bottomBar.addSubview(totalStack)

        // "Total" title label setup
        let totalTitle = UILabel()
        totalTitle.text = "Total"
        totalTitle.font = .systemFont(ofSize: 18, weight: .medium)
        totalTitle.textColor = .black  // Black color for "Total" text
        bottomBar.addSubview(totalTitle)

        // Buy button setup
        buyButton.setTitle("Buy Now", for: .normal)
        buyButton.backgroundColor = .orange
        buyButton.layer.cornerRadius = 12
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        bottomBar.addSubview(buyButton)

        // Disable autoresizing masks for Auto Layout
        [totalStack, totalTitle, buyButton, currencyIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        // Bottom bar constraints
        NSLayoutConstraint.activate([
            // Bottom bar positioning
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 120),

            // "Total" title positioning (left side)
            totalTitle.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 12),
            totalTitle.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 24),

            // Total stack positioning (right side with currency icon + amount)
            totalStack.centerYAnchor.constraint(equalTo: totalTitle.centerYAnchor),
            totalStack.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -24),
            
            // Currency icon size constraints
            currencyIcon.widthAnchor.constraint(equalToConstant: 16),
            currencyIcon.heightAnchor.constraint(equalToConstant: 16),

            // Buy button positioning
            buyButton.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 24),
            buyButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -24),
            buyButton.bottomAnchor.constraint(equalTo: bottomBar.bottomAnchor, constant: -16),
            buyButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }


    // MARK: - Helper Methods
    // Calculate and display total price of all items in cart

    private func updateTotal() {
        let total = items.map { $0.price * $0.quantity }.reduce(0, +)
        totalLabel.text = "\(total.formatted())"  // Remove currency symbol - now using orangeVector icon
    }

}


extension CartVC: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Data Source Methods
    // Return number of rows in single section (standard table view approach)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count                             // Return total number of cart items
    }

    // MARK: - Delegate Methods
    // Define fixed row height for all cells - includes 29pt spacing (14.5pt top + 14.5pt bottom margins)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144                                     // UPDATED: 115pt card height + 29pt spacing (14.5pt × 2)
    }

    // Configure and return cell for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CartItemCell
                
        else {
            return UITableViewCell()                   // Return default cell if casting fails
        }
 
        cell.configure(with: items[indexPath.row])     // Configure cell with cart item data using row index
        return cell
    }
}

