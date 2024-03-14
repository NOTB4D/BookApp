//
//  XCTestCaseExtensions.swift
//  BookAppTests
//
//  Created by Eser Kucuker on 14.03.2024.
//

@testable import BookApp
import XCTest

extension XCTestCase {
    func getJson<V: Decodable>(name: String) -> V? {
        guard let data = getDataOf(fileName: name),
              let json = try? JSONDecoder().decode(Response<V>.self, from: data) else { return nil }
        return json.feed
    }

    func getJsonArray(name: String) -> [String: Any]? {
        guard let data = getDataOf(fileName: name),
              let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
              let json = jsonArray.first else { return nil }
        return json
    }

    private func getDataOf(fileName: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
}
