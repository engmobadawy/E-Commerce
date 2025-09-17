//
//  DataSource.swift
//  Task1
//
//  Created by ME-MAC on 11/14/22.
//

import UIKit

// MARK: - Models

struct Category {
    let name: String
    let icon: UIImage
    let products: [Product]
}

/// Richer product model (backward-compatible with your UI)
struct Product {
    let id: String
    let name: String
    let subtitle: String
    let image: UIImage
    let price: Double
    let currency: String
    let rating: Double         // 0.0 – 5.0
    let reviewsCount: Int
    let inStock: Bool
    let description: String

    var formattedPrice: String {
        // customize currency formatting if needed
        String(format: "%.2f %@", price, currency)
    }
}

// (Unused in current UI, kept if referenced elsewhere)
struct Meal {
    let description : String
    let mealPhoto : UIImage
    let brandPhoto : UIImage
}

// MARK: - DataSource

class DataSource: NSObject {

    // Slider images unchanged
    var arrOffers = [
        UIImage(named: "img_offers2")!,
        UIImage(named: "img_offers2")!
    ]

    // Helper to quickly generate many products per category
    private func makeProducts(count: Int,
                              baseName: String,
                              baseSubtitle: String,
                              image: UIImage,
                              basePrice: Double) -> [Product] {
        guard count > 0 else { return [] }
        return (1...count).map { i in
            let price = basePrice + Double(i) * 5.0
            let rating = 3.5 + Double(i % 4) * 0.5   // 3.5, 4.0, 4.5, 5.0 loop
            let reviews = 25 + i * 7
            let inStock = (i % 5 != 0)               // every 5th item out of stock

            return Product(
                id: "\(baseName.lowercased())-\(i)",
                name: "\(baseName) \(i)",
                subtitle: baseSubtitle,
                image: image,
                price: price,
                currency: "USD",
                rating: min(rating, 5.0),
                reviewsCount: reviews,
                inStock: inStock,
                description:
"""
\(baseName) \(i) — premium quality. 
• Material: High-grade components
• Warranty: 12 months
• Notes: Sample seed data for demo UI
"""
            )
        }
    }

    // ▶️ Each category now has 12 products
    lazy var arrTopCategories: [Category] = [
        Category(
            name: "Watches",
            icon: UIImage(resource: .vector1),
            products: makeProducts(
                count: 12,
                baseName: "Watch",
                baseSubtitle: "Stainless steel, water resistant",
                image: UIImage(resource: .pro1),
                basePrice: 79.0
            )
        ),
        Category(
            name: "Tshirts",
            icon: UIImage(resource: .vector2),
            products: makeProducts(
                count: 12,
                baseName: "T-Shirt",
                baseSubtitle: "100% cotton, regular fit",
                image: UIImage(resource: .pro2),
                basePrice: 19.0
            )
        ),
        Category(
            name: "Bags",
            icon: UIImage(resource: .vector3),
            products: makeProducts(
                count: 12,
                baseName: "Bag",
                baseSubtitle: "Durable fabric, multi-pocket",
                image: UIImage(resource: .pro3),
                basePrice: 39.0
            )
        ),
        Category(
            name: "Shoes",
            icon: UIImage(resource: .vector4),
            products: makeProducts(
                count: 12,
                baseName: "Shoe",
                baseSubtitle: "Breathable, cushioned sole",
                image: UIImage(resource: .pro4),
                basePrice: 49.0
            )
        ),
        Category(
            name: "Glasses",
            icon: UIImage(resource: .vector5),
            products: makeProducts(
                count: 12,
                baseName: "Glasses",
                baseSubtitle: "UV protected, lightweight",
                image: UIImage(resource: .pro5),
                basePrice: 29.0
            )
        )
    ]
    
    
    //MARK: - example for @escaping
    func loadData(completion: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            sleep(2)
            DispatchQueue.main.async {
                completion("Done")
            }
        }
    }
    
    //MARK: - example for @discardableResult
    @discardableResult
    func saveData(_ data: String) -> Bool {
        print("Data saved: \(data)")
        return true
    }
    
}
