//
//  BookDetailModels.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation

// swiftlint:disable nesting
enum BookDetail {
    enum fetchBook {
        struct Request {}

        struct Response {
            let artistName: String?
            let name: String?
            let releaseDate: String?
            let image: String?
        }

        struct ViewModel {
            let artistName: String?
            let name: String?
            let releaseDate: String?
            let image: String
        }
    }
}

// swiftlint:enable nesting
