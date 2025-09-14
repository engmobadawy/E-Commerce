//
//  FontNameProtocol.swift
//  MagdyTask
//
//  Created by AMNY on 21/08/2025.
//


import SwiftUI

protocol FontNameProtocol {
  var fontName: String { get }
}

enum Poppins: String, FontNameProtocol {
    case bold = "Bold"
    case extraBold = "ExtraBold"
    case semiBold = "SemiBold"
    case medium = "Medium"
    case light = "Light"
    case extraLight = "ExtraLight"
    case regular = "Regular"
    
    var fontName: String {
      "Poppins-\(self.rawValue.capitalizeFirstLetter)"
    }
}


import UIKit

extension UILabel {
    func setTextFont(_ font: FontNameProtocol, size: CGFloat = 14, color: UIColor = .black) {
        self.font = UIFont(name: font.fontName, size: size)
        self.textColor = color
    }
}

extension UITextField {
    func setTextFont(_ font: FontNameProtocol, size: CGFloat = 14, color: UIColor = .black) {
        self.font = UIFont(name: font.fontName, size: size)
        self.textColor = color
    }
}

extension UITextView {
    func setTextFont(_ font: FontNameProtocol, size: CGFloat = 14, color: UIColor = .black) {
        self.font = UIFont(name: font.fontName, size: size)
        self.textColor = color
    }
}

extension UIButton {
    func setTextFont(_ font: FontNameProtocol, size: CGFloat = 14, color: UIColor = .black) {
        self.titleLabel?.font = UIFont(name: font.fontName, size: size)
        self.setTitleColor(color, for: .normal)
    }
}
extension UIView{
    //MARK:- storyBoard additions features for view
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue; layer.masksToBounds = newValue > 0 }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable var borderWidth : CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
}
