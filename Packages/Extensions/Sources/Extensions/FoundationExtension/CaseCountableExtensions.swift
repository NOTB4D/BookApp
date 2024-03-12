//
//  CaseCountableExtensions.swift
//
//
//  Created by Eser Kucuker on 11.03.2024.
//

import Foundation

import UIKit

public protocol CaseCountable {
    static var caseCount: Int { get }
}

public extension CaseCountable where Self: RawRepresentable, Self.RawValue == Int {
    static var caseCount: Int {
        var count = 0
        while let _ = Self(rawValue: count) {
            count += 1
        }
        return count
    }
}
