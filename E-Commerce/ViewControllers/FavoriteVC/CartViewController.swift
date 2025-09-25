final class CartViewController: UIViewController {

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

extension CartViewController: UITableViewDataSource, UITableViewDelegate {

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
