//
//  UIViewControllerExtension.swift
//  BookApp
//
//  Created by Eser Kucuker on 15.03.2024.
//

import Extensions
import UIKit

public extension UIViewController {
    func showErrorMessage(_ error: Error) {
        showMessage(title: "Uyarı", message: error.localizedDescription, actionTitle: "Tamam")
    }

    func showErrorMessage(_ message: String) {
        showMessage(title: "Uyarı", message: message, actionTitle: "Tamam")
    }

    func showMessage(
        title: String,
        message: String,
        actionTitle: String,
        action: BAlertButton.AlertAction? = nil
    ) {
        let alert = Alert(title: title, message: message)
        alert.addAction(.init(title: actionTitle, type: .destructive, action: action))
        alert.present(over: self)
    }

    func setAlertButtons(
        buttons: [BAlertButton],
        stackView: UIStackView,
        buttonHeight: CGFloat,
        action: Selector,
        buttonCornerRadius: CGFloat
    ) {
        for (index, alertButton) in buttons.enumerated() {
            let button = UIButton(frame: .init(origin: .zero, size: .init(
                width: stackView.frame.width,
                height: buttonHeight
            )))
            button.layer.cornerRadius = buttonCornerRadius
            button.setTitle(alertButton.title, for: .normal)
            button.titleLabel?.font = UIFont(name: "Helvetica", size: 15) ?? .systemFont(ofSize: 15)
            button.tag = index
            button.addTarget(self, action: action, for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
            if alertButton.type == .default {
                button.backgroundColor = .clear
                button.setTitleColor(alertButton.defaultTitleColor, for: .normal)
            } else if alertButton.type == .custom {
                button.backgroundColor = alertButton.backgroundColor
                button.setBorder(width: 1, color: alertButton.borderColor ?? .clear)
                button.setTitleColor(alertButton.defaultTitleColor, for: .normal)
            } else {
                button.backgroundColor = .systemGray
                button.setTitleColor(.white, for: .normal)
            }
            stackView.addArrangedSubview(button)
        }
    }
}
