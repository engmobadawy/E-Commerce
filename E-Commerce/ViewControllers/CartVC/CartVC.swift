//
//  CartViewController.swift
//  E-Commerce
//
//  Created by MohamedBadawi on 25/09/2025.
//


final class CartVC: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var items: [CartItem] = [
        CartItem(image: UIImage(named: "watch"),  name: "Apple W-series 6", price: 45000, quantity: 1),
        CartItem(image: UIImage(named: "headphones"), name: "Siberia 800",   price: 45000, quantity: 1),
        CartItem(image: UIImage(named: "shirt"), name: "Lycra Men’s shirt", price: 45000, quantity: 1),
        CartItem(image: UIImage(named: "sneakers"), name: "Nike/L v Airforce 1", price: 45000, quantity: 1)
    ]

    private let totalLabel = UILabel()
    private let buyButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My cart"
        view.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        setupTableView()
        setupBottomBar()
        updateTotal()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(CartItemCell.self, forCellReuseIdentifier: "cell")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -140)
        ])
    }

    private func setupBottomBar() {
        let bottomBar = UIView()
        view.addSubview(bottomBar)
        bottomBar.translatesAutoresizingMaskIntoConstraints = false

        totalLabel.font = .boldSystemFont(ofSize: 20)
        totalLabel.textColor = .orange
        bottomBar.addSubview(totalLabel)

        let totalTitle = UILabel()
        totalTitle.text = "Total"
        totalTitle.font = .systemFont(ofSize: 18, weight: .medium)
        bottomBar.addSubview(totalTitle)

        buyButton.setTitle("Buy Now", for: .normal)
        buyButton.backgroundColor = .orange
        buyButton.layer.cornerRadius = 12
        buyButton.setTitleColor(.white, for: .normal)
        bottomBar.addSubview(buyButton)

        [totalLabel, totalTitle, buyButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 140),

            totalTitle.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 12),
            totalTitle.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 24),

            totalLabel.centerYAnchor.constraint(equalTo: totalTitle.centerYAnchor),
            totalLabel.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -24),

            buyButton.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 24),
            buyButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -24),
            buyButton.bottomAnchor.constraint(equalTo: bottomBar.bottomAnchor, constant: -16),
            buyButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    private func updateTotal() {
        let total = items.map { $0.price * $0.quantity }.reduce(0, +)
        totalLabel.text = "؋ \(total)"
    }
}

extension CartVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int { items.count }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 8 }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 96 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CartItemCell else { return UITableViewCell() }
        cell.configure(with: items[indexPath.section])
        return cell
    }
}


final class CartItemCell: UITableViewCell {

    private let cardView = UIView()
    private let productImage = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let minusButton = UIButton(type: .system)
    private let qtyLabel = UILabel()
    private let plusButton = UIButton(type: .system)
    private lazy var stepperStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [minusButton, qtyLabel, plusButton])
        s.axis = .horizontal
        s.spacing = 4
        s.distribution = .equalCentering
        s.alignment = .center
        return s
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupViews() {
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.masksToBounds = false
        contentView.addSubview(cardView)

        productImage.contentMode = .scaleAspectFit
        cardView.addSubview(productImage)

        nameLabel.font = .systemFont(ofSize: 15, weight: .medium)
        nameLabel.numberOfLines = 2
        cardView.addSubview(nameLabel)

        priceLabel.font = .boldSystemFont(ofSize: 14)
        priceLabel.textColor = .black
        cardView.addSubview(priceLabel)

        minusButton.setTitle("–", for: .normal)
        plusButton.setTitle("+", for: .normal)
        qtyLabel.textAlignment = .center
        qtyLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true

        stepperStack.layer.borderColor = UIColor.orange.cgColor
        stepperStack.layer.borderWidth = 1
        stepperStack.layer.cornerRadius = 6
        cardView.addSubview(stepperStack)
    }

    private func setupConstraints() {
        [cardView, productImage, nameLabel, priceLabel, stepperStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            productImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            productImage.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            productImage.widthAnchor.constraint(equalToConstant: 60),
            productImage.heightAnchor.constraint(equalToConstant: 60),

            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: stepperStack.leadingAnchor, constant: -12),

            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            stepperStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            stepperStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            stepperStack.heightAnchor.constraint(equalToConstant: 32),
            stepperStack.widthAnchor.constraint(equalToConstant: 88)
        ])
    }

    func configure(with item: CartItem) {
        productImage.image = item.image
        nameLabel.text = item.name
        priceLabel.text = "؋ \(item.price)"
        qtyLabel.text = "\(item.quantity)"
    }
}


struct CartItem {
    let image: UIImage?
    let name: String
    let price: Int
    var quantity: Int
}
