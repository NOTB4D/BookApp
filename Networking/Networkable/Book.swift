//
//  Book.swift
//  BookApp
//
//  Created by Eser Kucuker on 11.03.2024.
//

import Foundation

public extension API {
    enum Book: Networkable {
        case getBooks(request: GetBooksRequest)

        public func request() async -> URLRequest {
            switch self {
            case let .getBooks(request):
                await get(path: "/api/v2/us/books/top-free/\(request.page)/books.json")
            }
        }
    }
}
