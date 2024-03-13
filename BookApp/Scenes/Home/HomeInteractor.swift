//
//  HomeInteractor.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Extensions
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
                                    image: $0.artworkUrl100,
                                    isFavorite: (self?.isBookfavorite(with: ($0.id).stringValue)).falseValue
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
            refreshList(at: id, isFavorite: true)
        } else {
            addBookToFavorite(with: id)
            refreshList(at: id)
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

    func refreshList(at id: String, isFavorite: Bool = false) {
        guard let index = findBookIndex(at: id) else { return }
        presenter?.presentFavoriteBook(
            response: Home.FetchFavoriteBook.Response(
                books: books?.results.compactMap {
                    .init(
                        id: $0.id,
                        artistName: $0.name,
                        image: $0.artworkUrl100,
                        isFavorite: isBookfavorite(with: ($0.id).stringValue)
                    )
                } ?? [],
                indexPath: index
            )
        )
    }

    /// Finds the indexes of the updated item with the provided item ID.
    /// - Parameter itemId: The ID of the item to find.
    /// - Returns: An array of index paths for the updated item, or nil if not found.
    func findBookIndex(at id: String) -> [IndexPath]? {
        var itemIndexes: [IndexPath] = []
        guard let itemIndex = books?.results.firstIndex(where: { $0.id == id }) else { return nil }
        // Create an IndexPath for the item (in section 0) and append to itemIndexes
        let indexPath = IndexPath(item: itemIndex, section: 0)
        itemIndexes.append(indexPath)

        // Return nil if no indexes were found, otherwise return the indexes
        guard itemIndexes.count != 0 else { return nil }
        return itemIndexes
    }
}
