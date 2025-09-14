//
//  uISearchBar.swift
//
//  Created by noura on 23/11/2022.
//

import UIKit
extension UISearchBar {
  func changeSearchBarColor(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContext(self.frame.size)
        color.setFill()
        UIBezierPath(rect: self.frame).fill()
        let bgImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.setSearchFieldBackgroundImage(bgImage, for: .normal)
    }
}
