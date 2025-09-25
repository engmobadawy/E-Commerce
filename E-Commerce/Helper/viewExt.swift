//
//  viewExt.swift
//  MagdyTask
//
//  Created by AMNY on 23/08/2025.
//

import UIKit

extension UIView {
    /// Adds a tap gesture to the view to dismiss the keyboard when tapped anywhere outside input fields.
    func addKeyboardDismissTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(_dismissKeyboardForView))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func _dismissKeyboardForView() {
        self.endEditing(true)
    }
}
