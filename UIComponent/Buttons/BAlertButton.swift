//
//  BAlertButton.swift
//  BookApp
//
//  Created by Eser Kucuker on 15.03.2024.
//

import Foundation

import Foundation
import UIKit

public struct BAlertButton {
    public var title: String
    public var type: BAlertButton.ActionType
    public var defaultTitleColor: UIColor?
    public var action: AlertAction?
    public var borderColor: UIColor?
    public var backgroundColor: UIColor?

    public init(
        title: String,
        type: BAlertButton.ActionType,
        titleColor: UIColor? = .systemGray,
        borderColor: UIColor? = .clear,
        backgroundColor: UIColor? = .clear,
        action: AlertAction? = nil
    ) {
        self.title = title
        self.type = type
        defaultTitleColor = titleColor
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.action = action
    }

    public enum ActionType {
        case `default`, destructive, custom
    }

    public typealias AlertAction = (BAlertButton) -> Void
}
