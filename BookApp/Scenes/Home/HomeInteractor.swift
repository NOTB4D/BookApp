//
//  HomeInteractor.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func fetchBooks()
    func fetchBook(request: Home.FetchBook.Request)
    func addOrDeleteBookToFavoriteBookList(with id: String)
}

protocol HomeDataStore: AnyObject {}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()

    var books: BooksResponse?

    func fetchBooks() {
        Task {
            let result = await worker.fetchBooks(request: .init())
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(response):
                    self?.books = response
                    self?.presenter?.presentBooks(
                        response: Home.FetchBooks.Response(
                            books: response.results.compactMap {
                                .init(
                                    id: $0.id,
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

    func fetchBook(request: Home.FetchBook.Request) {
        guard let model = books?.results[request.index] else { return }
        presenter?.presentBook(
            response: Home.FetchBook.Response(
                artistName: model.artistName,
                name: model.name,
                releaseDate: model.releaseDate,
                image: model.artworkUrl100
            )
        )
    }

    func addOrDeleteBookToFavoriteBookList(with id: String) {
        if isBookfavorite(with: id) {
            deleteBookToFavorite(with: id)
        } else {
            addBookToFavorite(with: id)
        }
    }

    func isBookfavorite(with id: String) -> Bool {
        let book = LocalStorageManager.shared.fetchBook(withId: id)
        return book != nil
    }

    func addBookToFavorite(with id: String) {
        guard let book = books?.results.first(where: { $0.id == id }) else { return }
        let model: BookDataModel = .init(
            id: book.id,
            name: book.name,
            publishDate: book.releaseDate,
            authorName: book.artistName,
            image: book.artworkUrl100
        )
        LocalStorageManager.shared.add(book: model)
        print("Favoriye Eklendi")
    }

    func deleteBookToFavorite(with id: String) {
        LocalStorageManager.shared.deleteBook(withId: id)
        print("Favoriden cıkartıldı")
    }
}
