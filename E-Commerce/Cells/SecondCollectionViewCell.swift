//
//  SecondCollectionViewCell.swift
//  task2
//
//  Created by Mohammed on 11/16/22.
//  Copyright © 2025 mohammed. All rights reserved.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var outImage: UIImageView!
    @IBOutlet weak var largeView: UIView!

    
    @IBOutlet weak var Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        largeView.layer.cornerRadius = 15
        outImage.layer.cornerRadius = 15
        
        
    }

    func configure(with product: Product) {
            // Images
            outImage.image = product.image
//            innerImage.image = product.image

            // Attributed multi-line text (name, subtitle, rating, price, stock)
            Label.attributedText = makeDetailsText(for: product)
        }

        // MARK: - Attributed text builder
        private func makeDetailsText(for p: Product) -> NSAttributedString {
            let title = "\(p.name)\n"
            let subtitle = p.subtitle.isEmpty ? "" : "\(p.subtitle)\n"

            // Rating: ★★★★☆ + reviews count
            let stars = starString(rating: p.rating)
            let reviews = " • \(p.reviewsCount)"
            let ratingLine = "\(stars)\(reviews)\n"

            let price = p.formattedPrice
            let stock = p.inStock ? "In stock" : "Out of stock"

            let s = NSMutableAttributedString()

            s.append(NSAttributedString(string: title,
                                        attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold),
                                                     .foregroundColor: UIColor.label]))

            if !subtitle.isEmpty {
                s.append(NSAttributedString(string: subtitle,
                                            attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                         .foregroundColor: UIColor.secondaryLabel]))
            }

            s.append(NSAttributedString(string: ratingLine,
                                        attributes: [.font: UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .medium),
                                                     .foregroundColor: UIColor.systemYellow]))

            // Price (accent) + Stock (green/red)
            let priceAttr = NSAttributedString(string: price,
                                               attributes: [.font: UIFont.systemFont(ofSize: 13, weight: .semibold),
                                                            .foregroundColor: UIColor.systemBlue])
            let stockColor: UIColor = p.inStock ? .systemGreen : .systemRed
            let stockAttr = NSAttributedString(string: "  •  \(stock)",
                                               attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .medium),
                                                            .foregroundColor: stockColor])

            s.append(priceAttr)
            s.append(stockAttr)

            return s
        }

        private func starString(rating: Double) -> String {
            // Simple star renderer using Unicode stars
            let clamped = max(0.0, min(5.0, rating))
            let full = Int(clamped.rounded(.down))
            let hasHalf = (clamped - Double(full)) >= 0.5
            let empty = 5 - full - (hasHalf ? 1 : 0)

            return String(repeating: "★", count: full)
                 + (hasHalf ? "☆" : "")
                 + String(repeating: "✩", count: empty)
        }

}




extension UIView{
    func custom(anyview : UIView,image:UIImageView){
        
        image.layer.cornerRadius = image.frame.size.width/2
        anyview.layer.cornerRadius = anyview.frame.size.width/2
          let gradient  = CAGradientLayer()
              gradient.frame = anyview.bounds
              gradient.colors = [UIColor.brown.cgColor,UIColor.white.cgColor]
              anyview.layer.addSublayer(gradient)
        
            gradient.cornerRadius = anyview.frame.size.width/2

           anyview.addSubview(image)
        
    }
    
}
