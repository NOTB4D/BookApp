//
//  HomeInteractor.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func doSomething()
}

protocol HomeDataStore: AnyObject {}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()

    func doSomething() {
        Task {
            let result = await worker.fetchBooks(request: .init())
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(response):
                    self?.presenter?.presentBooks(
                        response: Home.FetchBooks.Response(
                            books: response.results.compactMap {
                                .init(
                                    artistName: $0.name,
                                    image: $0.artworkUrl100
                                )
                            }
                        )
                    )
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
