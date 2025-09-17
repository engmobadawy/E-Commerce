//
//  ScrollingCollectionViewCell.swift
//  task2
//
//  Created by Mohammed on 11/19/22.
//  Copyright © 2025 mohammed. All rights reserved.
//

import UIKit

class ScrollingCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var image3: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       image3.layer.cornerRadius = 10
        
    }

}
