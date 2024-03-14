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
            let categorie: Int
        }

        struct Response {
            let books: [Book]
        }

        struct ViewModel {
            let books: [Book]
        }

        struct Book {
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
}

// swiftlint:enable nesting
