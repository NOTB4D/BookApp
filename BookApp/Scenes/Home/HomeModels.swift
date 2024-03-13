//
//  HomeModels.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation
import UIKit

// swiftlint:disable nesting
enum Home {
    enum FetchBooks {
        struct Request {}

        struct Response {
            let books: [Book]

            struct Book {
                let id: String?
                let artistName: String?
                let image: String?
            }
        }

        struct ViewModel {
            let books: [Book]

            struct Book {
                let id: String?
                let artistName: String?
                let image: String?
            }
        }
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
}

extension Home.FetchBook.ViewModel {
    func getBookDetailModel() -> BookDetail.fetchBook.Response {
        .init(artistName: artistName, name: name, releaseDate: releaseDate, image: image)
    }
}

// swiftlint:enable nesting
