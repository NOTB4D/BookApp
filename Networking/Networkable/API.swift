//
//  API.swift
//  BookApp
//
//  Created by Eser Kucuker on 11.03.2024.
//

import Foundation

public enum API {
    static func prepareURL(withPath path: String) -> URL {
        guard let baseURL = Bundle.main.infoForKey("BASE_URL") else {
            fatalError("Could not init url")
        }
        guard let url = URL(string: "\(baseURL)\(path)") else {
            fatalError("Could not prepare url")
        }
        return url
    }
}
