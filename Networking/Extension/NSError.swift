//
//  NSError.swift
//  BookApp
//
//  Created by Eser Kucuker on 11.03.2024.
//

import Foundation

import Foundation

public extension NSError {
    static func withLocalizedInfo(_ info: String) -> Error {
        NSError(domain: "API", code: -92, userInfo: [NSLocalizedDescriptionKey: info])
    }

    static var generic: Error {
        withLocalizedInfo("Error occured while loading. Try again later.")
    }
}
