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
            let bookId: String
        }

        struct Response {
            let id: String?
            let artistName: String?
            let name: String?
            let releaseDate: String?
            let image: String?
            let isFavorite: Bool
        }

        struct ViewModel {
            let id: String?
            let artistName: String?
            let name: String?
            let releaseDate: String?
            let image: String?
            let isFavorite: Bool
        }
    }

    enum FetchFavoriteBook {
        struct Request {}

        struct Response {
            let books: [Book]
        }

        struct ViewModel {
            let books: [Book]
        }
    }
}

extension Favorite.FetchBook.ViewModel {
    func getBookDetailModel() -> BookDetail.fetchBook.Response {
        .init(id: id, artistName: artistName, name: name, releaseDate: releaseDate, image: image, isFavorite: isFavorite)
    }
}

// swiftlint:enable nesting
