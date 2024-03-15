//
//  AlertViewController.swift
//  BookApp
//
//  Created by Eser Kucuker on 15.03.2024.
//

import Extensions
import Foundation
import UIKit

public final class Alert {
    public var completionHandler: (() -> Void)?

    var icon: UIImage?
    var title: String? = ""
    var message: String
    var titleFont: UIFont?
    var buttons: [BAlertButton] = []
    var attributedMessage: NSAttributedString?
    var messageTapHandler: (() -> Void)?

    public init(
        icon: UIImage? = nil,
        title: String? = "",
        message: String,
        titleFont: UIFont? = nil,
        attributedMessage: NSAttributedString? = nil,
        messageTapHandler: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.titleFont = titleFont
        self.attributedMessage = attributedMessage
        self.messageTapHandler = messageTapHandler
    }

    public func addAction(_ button: BAlertButton) {
        buttons.append(button)
    }

    public func present(over viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let controller = UIStoryboard(name: "Alert", bundle: .main)
            .instantiateInitialViewController() as? AlertViewController
        else {
            fatalError("AlertViewController could not be initialized")
        }
        controller.alertIcon = icon
        controller.alertTitle = title
        controller.alertMessage = message
        controller.titleFont = titleFont
        controller.alertButtons = buttons
        controller.attributedMessage = attributedMessage
        controller.alertMessageCompletionHandler = messageTapHandler
        controller.completionHandler = completionHandler
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        viewController.present(controller, animated: animated, completion: completion)
    }
}

final class AlertViewController: UIViewController {
    @IBOutlet private var contentHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var alertIconHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var alertIconImage: UIImageView!
    @IBOutlet private var alertTitleLabel: UILabel!
    @IBOutlet private var alertMessageLabel: UILabel!
    @IBOutlet private var buttonsStackView: UIStackView!
    @IBOutlet private var backgroundView: UIView!

    fileprivate var alertIcon: UIImage?
    fileprivate var alertTitle: String!
    fileprivate var titleFont: UIFont?
    fileprivate var alertMessage: String!
    fileprivate var alertButtons: [BAlertButton]!
    fileprivate var alertMessageCompletionHandler: (() -> Void)?
    fileprivate var attributedMessage: NSAttributedString?
    fileprivate var completionHandler: (() -> Void)?

    @IBInspectable private var imageContainerHeight: CGFloat = 94
    @IBInspectable private var buttonHeight: CGFloat = 40
    @IBInspectable private var buttonCornerRadius: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        alertIconHeightConstraint.constant = alertIcon == nil ? 0 : imageContainerHeight
        alertIconImage.image = alertIcon
        alertTitleLabel.text = alertTitle
        if let font = titleFont {
            alertTitleLabel.font = font
        }
        alertMessageLabel.text = alertMessage
        if let attributedMessage {
            alertMessageLabel.attributedText = attributedMessage
        }
        setButtons()
        contentView.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.setContentHeight()
        }
        if alertMessageCompletionHandler != nil {
            alertMessageLabel.isUserInteractionEnabled = true
            alertMessageLabel.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(submitMessage(_:)))
            )
        }
        assignTapGestureToBackground()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func assignTapGestureToBackground() {
        backgroundView.makeViewClickable(target: self, action: #selector(dismissView))
    }

    @objc private func dismissView() {
        dismiss(animated: true)
        completionHandler?()
    }

    func setContentHeight() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self else { return }
            contentView.alpha = 1.0
            let maxContentHeight = UIScreen.main.bounds.height - 50
            if scrollView.contentSize.height > maxContentHeight {
                contentHeightConstraint.constant = maxContentHeight
            } else {
                contentHeightConstraint.constant = scrollView.contentSize.height
            }
            if contentHeightConstraint.constant == 0 {
                print("contentHeightConstraint value found zero. Dismissing AlertViewController")
                dismiss(animated: false, completion: nil)
            }
        }
    }

    private func setButtons() {
        setAlertButtons(
            buttons: alertButtons,
            stackView: buttonsStackView,
            buttonHeight: buttonHeight,
            action: #selector(selectButton(_:)),
            buttonCornerRadius: buttonCornerRadius
        )
    }

    @objc func selectButton(_ button: UIButton) {
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            alertButtons[button.tag].action?(alertButtons[button.tag])
        }
    }

    @objc func submitMessage(_: UITapGestureRecognizer) {
        alertMessageCompletionHandler?()
    }
}
