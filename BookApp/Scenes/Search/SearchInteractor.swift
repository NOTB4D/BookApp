//
//  SearchInteractor.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

protocol SearchBusinessLogic: AnyObject {
    func fetchBookList()
    func searchBook(request: Search.FetchFilteredBooks.Request)
}

protocol SearchDataStore: AnyObject {}

final class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    var presenter: SearchPresentationLogic?
    var worker: SearchWorkingLogic = SearchWorker()
    var books: [Books]?
    var categories = [Genre]()
    var filterRequest = Search.FetchFilteredBooks.Request(text: "", categori: "All")

    func fetchBookList() {
        Task {
            let result = await worker.fetchBooks(request: .init(page: AppConstants.Search.paginationSize))
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(response):
                    self?.books = response.results
                    self?.presentCategories(with: response.results)
                    self?.presentBookList(at: response.results)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    func presentCategories(with book: [Books]) {
        book.forEach { book in
            guard let genres = book.genres else { return }
            let newGenres = genres.filter { genre in
                !(categories.contains { $0.genreID == genre.genreID })
            }
            categories.append(contentsOf: newGenres)
        }
        categories.insert(.init(genreID: "", name: "All", url: ""), at: 0)
        presenter?.presentCategories(
            response: Search.FetchCategories.Response(
                categories: categories.compactMap(\.name)
            )
        )
    }

    func presentBookList(at books: [Books]?) {
        presenter?.presentBookList(
            response: Search.FetchFilteredBooks.Response(
                books: books?.compactMap {
                    .init(
                        id: $0.id,
                        image: $0.artworkUrl100,
                        bookName: $0.name,
                        authorName: $0.artistName,
                        publised: $0.releaseDate
                    )
                } ?? []
            )
        )
    }
}
