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
            let id: String?
            let artistName: String?
            let name: String?
            let releaseDate: String?
            let image: String?
            var isFavorite: Bool
        }

        struct ViewModel {
            let artistName: String?
            let name: String?
            let releaseDate: String?
            let image: String
            let isFavorite: Bool
        }
    }

    enum fetchFavoriteStatus {
        struct Request {}

        struct Response {
            let id: String?
            let isFavorite: Bool
        }

        struct ViewModel {
            let id: String?
            let isFavorite: Bool
        }
    }
}

// swiftlint:enable nesting
