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

    func searchBook(request: Search.FetchFilteredBooks.Request) {
        filterRequest = request
        let filteredBook = filter(models: books ?? [], text: request.text, filterByCategori: request.categori)
        presentBookList(at: filteredBook)
    }

    /**
     Filters the given array of books based on the provided search text and category filter.

     - Parameters:
        - models: An array of `Books` objects to filter.
        - text: The search text used to filter the books by their names.
        - filterByCategory: The category used to filter the books. If set to "All", no filtering by category is applied.

     - Returns: An array of `Books` objects that match the search text and category filter.
     */
    private func filter(models: [Books], text: String, filterByCategori: String) -> [Books] {
        /**
         Filters the given array of books based on the provided category.

         - Parameters:
            - models: An array of `Books` objects to filter.
            - category: The category used to filter the books. If set to "All", no filtering by category is applied.

         - Returns: An array of `Books` objects that match the category filter.
         */
        func filter(models: [Books], categori: String) -> [Books] {
            if categori == "All" {
                return models
            } else {
                let books = models.filter { ($0.genres ?? []).contains(where: { item in
                    item.name == categori
                }) }
                return books
            }
        }
        if !text.isEmpty {
            let textLowercased = text.lowercased()
            let tempModels = models.filter { model in
                (model.name).stringValue.lowercased().contains(textLowercased)
            }
            return filter(models: tempModels, categori: filterByCategori)
        }
        return filter(models: models, categori: filterByCategori)
    }
}
