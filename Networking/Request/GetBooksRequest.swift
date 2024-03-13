//
//  GetBooksRequest.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation

public struct GetBooksRequest {
    public init(
        page: Int = 20
    ) {
        self.page = page
    }

    public let page: Int
}
