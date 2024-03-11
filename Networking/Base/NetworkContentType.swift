//
//  NetworkContentType.swift
//  BookApp
//
//  Created by Eser Kucuker on 11.03.2024.
//

import Foundation

/// "Content-Type" values for network requests.
enum NetworkContentType {
    /// Content type used when expecting response  in JSON format.
    case json
    case multipartFormData(String)

    var rawValue: String {
        switch self {
        case .json: return "application/json"
        case let .multipartFormData(boundary): return "multipart/form-data; boundary=\(boundary)"
        }
    }
}

