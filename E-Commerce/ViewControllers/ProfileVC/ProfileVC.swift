//
//  ProfileVC.swift
//  E-Commerce
//
//  Created by MohamedBadawi on 14/09/2025.
//
import UIKit


class ProfileVC: UIViewController {
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 450
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Vector_1") // Add your product image
        return imageView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor(resource: .orangeF17547)
        return pageControl
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Apple Watch Series 6"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    private let barcodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "barcode")
        imageView.tintColor = .black
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "₹ 45,000"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let aboutTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "About"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let aboutDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The upgraded S6 SiP runs up to 20 percent faster, allowing apps to also launch 20 percent faster, while maintaining the same all-day 18-hour battery life."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(resource: .orangeF17547)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 25
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(productImageContainer)
        productImageContainer.addSubview(productImageView)
        contentView.addSubview(pageControl)
        contentView.addSubview(productTitleLabel)
        contentView.addSubview(ratingStackView)
        contentView.addSubview(barcodeImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(aboutTitleLabel)
        contentView.addSubview(aboutDescriptionLabel)
        contentView.addSubview(addToCartButton)
        
        setupRatingStars()
    }
    
    private func setupRatingStars() {
        // Add 5 star images to the rating stack view
        for _ in 0..<5 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: "star.fill")
            starImageView.tintColor = .systemYellow
            starImageView.contentMode = .scaleAspectFit
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
            ratingStackView.addArrangedSubview(starImageView)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll View - Changed to start from the very top
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Product Image Container - Increased top margin to account for status bar
            productImageContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -632),
            productImageContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            productImageContainer.widthAnchor.constraint(equalToConstant: 900),
            productImageContainer.heightAnchor.constraint(equalToConstant: 900),
            
            // Product Image View
            productImageView.centerXAnchor.constraint(equalTo: productImageContainer.centerXAnchor),
            productImageView.centerYAnchor.constraint(equalTo: productImageContainer.bottomAnchor, constant: -176),
            productImageView.widthAnchor.constraint(equalToConstant: 200),
            productImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Page Control
            pageControl.topAnchor.constraint(equalTo: productImageContainer.bottomAnchor, constant: -48),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // Product Title
            productTitleLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 30),
            productTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Rating Stack View
            ratingStackView.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 16),
            ratingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // Barcode Image
            barcodeImageView.topAnchor.constraint(equalTo: ratingStackView.centerYAnchor),
            barcodeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            barcodeImageView.widthAnchor.constraint(equalToConstant: 160),
            barcodeImageView.heightAnchor.constraint(equalToConstant: 40),
            
            // Price Label
            priceLabel.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // About Title
            aboutTitleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30),
            aboutTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // About Description
            aboutDescriptionLabel.topAnchor.constraint(equalTo: aboutTitleLabel.bottomAnchor, constant: 12),
            aboutDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            aboutDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Add to Cart Button
            addToCartButton.topAnchor.constraint(equalTo: aboutDescriptionLabel.bottomAnchor, constant: 40),
            addToCartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -120) // Added space for tab bar
        ])
    }
    
    private func setupActions() {
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func addToCartButtonTapped() {
        // Add your add to cart functionality here
        print("Add to cart button tapped")
        
        // Example: Show success message
        let alert = UIAlertController(title: "Success", message: "Product added to cart!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
