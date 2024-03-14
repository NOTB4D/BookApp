//
//  Networkable.swift
//  BookApp
//
//  Created by Eser Kucuker on 11.03.2024.
//

import Foundation

public protocol Networkable {
    func request() async -> URLRequest
}

extension Networkable {
    func get(queryItems: [String: String] = [:], path: String) async -> URLRequest {
        await prepareRequest(
            withPath: path,
            queryItems: queryItems,
            method: .get,
            contentType: .json
        )
    }

    private func prepareRequest(
        withPath path: String,
        queryItems: [String: String] = [:],
        method: RequestMethod,
        contentType: NetworkContentType,
        headers: [String: String] = [:]
    ) async -> URLRequest {
        let url = API.prepareURL(withPath: path).adding(parameters: queryItems)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        var headers = headers
        headers.updateValue(contentType.rawValue, forKey: "Content-Type")

        request.allHTTPHeaderFields = headers
        return request
    }
}

public extension Networkable {
    func fetch<T: Decodable>(
        responseModel model: T.Type
    ) async -> Result<T, Error> {
        //  guard !UnitTestStubs.canResponse(type, completion: completion) else { return }

        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            let result = await UnitTestStubs.canResponse(model)
            return result
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request(), delegate: nil)

            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            {
                print("\n\n\n---Networking Received Response---")
                print(String(decoding: jsonData, as: UTF8.self))
                print("---Networking Received Response---\n\n\n")
            }

            if model.self is Data.Type {
                return .success(data as! T)
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedResponse = try decoder.decode(Response<T>.self, from: data)
            if let body = decodedResponse.feed {
                return .success(body)
            } else {
                return .failure(NSError.withLocalizedInfo(decodedResponse.error ?? "Somehing on the way..."))
            }
        } catch {
            return .failure(NSError.generic)
        }
    }
}
