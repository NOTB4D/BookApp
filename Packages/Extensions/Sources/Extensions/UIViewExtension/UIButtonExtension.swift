//
//  UIButtonExtension.swift
//
//
//  Created by Eser Kucuker on 15.03.2024.
//

import UIKit

public extension UIButton {
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
