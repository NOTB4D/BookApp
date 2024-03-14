//
//  Response.swift
//  BookApp
//
//  Created by Eser Kucuker on 11.03.2024.
//

import Foundation

public struct Response<T: Decodable>: Decodable {
    public var error: String?
    public var feed: T?
}
