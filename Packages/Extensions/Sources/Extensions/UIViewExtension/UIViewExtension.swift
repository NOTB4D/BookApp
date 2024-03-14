//
//  UIViewExtension.swift
//
//
//  Created by Eser Kucuker on 12.03.2024.
//

import UIKit

public extension UIView {
    class var identifier: String {
        String(describing: self)
    }

    func loadNib(in bundle: Bundle, nibName: String) {
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = (nib.instantiate(withOwner: self, options: nil).first as? UIView)
        else { return }
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib(_ nibName: String, bundle: Bundle) -> UIView {
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = (nib.instantiate(withOwner: self, options: nil)[0] as? UIView)
        else { return UIView() }
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        return view
    }

    static func loadViewFromNib(in bundle: Bundle = Bundle.main) -> UIView? {
        let nib = UINib(nibName: String(describing: self), bundle: bundle)
        let nibObjects = nib.instantiate(withOwner: nil, options: nil)
        guard let view = nibObjects.first as? UIView else { return nil }
        return view
    }

    /// Adds a tap gesture recognizer to make the view clickable.
    ///
    /// - Parameters:
    ///   - target: The target object that the action will be sent to when the view is tapped.
    ///   - action: The action to be performed when the view is tapped.
    ///
    /// Example usage:
    /// ```
    /// let myView = UIView()
    /// myView.makeViewClickable(target: self, action: #selector(viewTapped))
    /// ```
    func makeViewClickable(target: Any, action: Selector?) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tap)
    }

    /// Corner radius of view
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    /// Border width of view
    @IBInspectable var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// Border color of view
    @IBInspectable var borderColor: UIColor {
        get {
            UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    /// Adds rounded corners to the view.
    /// - Parameters:
    ///   - corners: The corners of a rectangle.
    ///   - radius: Radius to be applied.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        var masked = CACornerMask()

        if corners.contains(.topLeft) {
            masked.insert(.layerMinXMinYCorner)
        }

        if corners.contains(.topRight) {
            masked.insert(.layerMaxXMinYCorner)
        }

        if corners.contains(.bottomLeft) {
            masked.insert(.layerMinXMaxYCorner)
        }

        if corners.contains(.bottomRight) {
            masked.insert(.layerMaxXMaxYCorner)
        }

        layer.maskedCorners = masked
    }
}
