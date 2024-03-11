//
//  Book.swift
//  BookApp
//
//  Created by Eser Kucuker on 11.03.2024.
//

import Foundation

public extension API {
    enum Book: Networkable {
        case getBooks

        public func request() async -> URLRequest {
            switch self {
            case .getBooks:
                return await get(path: "/api/v2/us/books/top-free/20/books.json")
            }
        }
    }
}
