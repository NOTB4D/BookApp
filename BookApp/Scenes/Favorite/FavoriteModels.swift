//
//  FavoriteModels.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

// swiftlint:disable nesting
enum Favorite {
    enum FetchBooks {
        struct Request {}

        struct Response {
            let books: [Book]
        }

        struct ViewModel {
            let books: [Book]
        }
    }

    struct Book {
        let id: String?
        let artistName: String?
        let image: String?
        let isFavorite: Bool
    }

    enum FetchBook {
        struct Request {
            let index: Int
        }

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
            let image: String?
        }
    }

    enum FetchFavoriteBook {
        struct Request {}

        struct Response {
            let books: [Book]
            let indexPath: [IndexPath]
        }

        struct ViewModel {
            let books: [Book]
            let indexPath: [IndexPath]
        }
    }
}

extension Favorite.FetchBook.ViewModel {
    func getBookDetailModel() -> BookDetail.fetchBook.Response {
        .init(artistName: artistName, name: name, releaseDate: releaseDate, image: image)
    }
}

// swiftlint:enable nesting
