//
//  UITabBarControllerExtensions.swift
//  
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation
import UIKit

public extension UITabBarController {
    func createAppearance() -> UITabBarAppearance {
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Helvetica", size: 12) ?? .systemFont(ofSize: 12),
            .foregroundColor: UIColor.secondaryLabel
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Helvetica", size: 12) ?? .systemFont(ofSize: 12),
            .foregroundColor: UIColor.brown
        ]

        let appearance = tabBar.standardAppearance

        let itemAppearance = appearance.inlineLayoutAppearance
        itemAppearance.normal.titleTextAttributes = normalTextAttributes
        itemAppearance.selected.titleTextAttributes = selectedTextAttributes
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.backgroundColor = .darkGray

        return appearance
    }
}
