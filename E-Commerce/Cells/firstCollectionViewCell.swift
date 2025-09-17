//
//  firstCollectionViewCell.swift
//  task2
//
//  Created by Mohammed on 11/16/22.
//  Copyright © 2025 mohammed. All rights reserved.
//

import UIKit

class firstCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
        contentView.layer.cornerRadius = 10
        contentView.layer.backgroundColor = UIColor(resource: .grayF2F2F2).cgColor
        icon.tintColor = .black.withAlphaComponent(0.4)
        contentView.layer.borderColor = UIColor(resource: .grayD8D3D3).cgColor
        contentView.layer.borderWidth = 0.1
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.layer.backgroundColor = UIColor(resource: .orangeF17547).cgColor
                icon.tintColor = .white
                contentView.layer.borderColor = UIColor.clear.cgColor

            } else {
                contentView.layer.backgroundColor = UIColor(resource: .grayF2F2F2).cgColor
                icon.tintColor = .black.withAlphaComponent(0.4)
                contentView.layer.borderColor = UIColor(resource: .grayD8D3D3).cgColor

            }
            
        }
    }
}


