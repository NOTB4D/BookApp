//
//  SearchModels.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

// swiftlint:disable nesting
enum Search {
    enum FetchFilteredBooks {
        struct Request {
            let text: String
            let categori: String
        }

        struct Response {
            let books: [Book]
        }

        struct ViewModel {
            let books: [Book]
        }

        struct Book {
            let id: String?
            let image: String?
            let bookName: String?
            let authorName: String?
            let publised: String?
        }
    }

    enum FetchCategories {
        struct Response {
            let categories: [String]
        }

        struct ViewModel {
            let categories: [String]
        }
    }

    enum FetchBookDetail {
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
}

extension Search.FetchBookDetail.ViewModel {
    func getBookDetailModel() -> BookDetail.fetchBook.Response {
        .init(id: id, artistName: artistName, name: name, releaseDate: releaseDate, image: image, isFavorite: isFavorite)
    }
}

// swiftlint:enable nesting
