//
//  BoolExtensions.swift
//
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

public extension Bool? {
    var trueValue: Bool {
        self ?? true
    }

    var falseValue: Bool {
        self ?? false
    }
}
