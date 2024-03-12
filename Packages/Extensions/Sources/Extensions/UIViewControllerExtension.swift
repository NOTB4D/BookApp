//
//  UIViewControllerExtension.swift
//
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation
import SwiftUI

public extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        func makeUIViewController(context: Context) -> UIViewController { viewController }
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }

    var preview: some View { Preview(viewController: self) }
}
