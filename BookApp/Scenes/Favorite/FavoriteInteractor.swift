//
//  FavoriteInteractor.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

protocol FavoriteBusinessLogic: AnyObject {
    func fetchBooks()
    func fetchBook(request: Favorite.FetchBook.Request)
    func deleteBookToFavoriteBookList(with id: String)
}

protocol FavoriteDataStore: AnyObject {}

final class FavoriteInteractor: FavoriteBusinessLogic, FavoriteDataStore {
    var presenter: FavoritePresentationLogic?
    var worker: FavoriteWorkingLogic = FavoriteWorker()

    var books: [Books]?

    func fetchBooks() {
        let model = LocalStorageManager.shared.fetchBooks()
        books = model?.map {
            Books(
                artistName: $0.authorName,
                id: $0.id,
                name: $0.name,
                releaseDate: $0.publishDate,
                artworkUrl100: $0.image
            )
        }
        presenter?.presentBooks(
            response: Favorite.FetchBooks.Response(
                books: books?.compactMap {
                    .init(
                        id: $0.id,
                        artistName: $0.name,
                        image: $0.artworkUrl100,
                        isFavorite: true
                    )
                } ?? []
            )
        )
    }

    func fetchBook(request: Favorite.FetchBook.Request) {
        guard let model = books?[request.index] else { return }
        presenter?.presentBook(
            response: Favorite.FetchBook.Response(
                artistName: model.artistName,
                name: model.name,
                releaseDate: model.releaseDate,
                image: model.artworkUrl100
            )
        )
    }

    func deleteBookToFavoriteBookList(with id: String) {
        deleteBookToFavorite(with: id)
        refreshList(at: id)
    }

    func deleteBookToFavorite(with id: String) {
        LocalStorageManager.shared.deleteBook(withId: id)
        print("Favoriden cıkartıldı")
    }

    func refreshList(at id: String) {
        guard let index = findBookIndex(at: id) else { return }
        books?.removeAll(where: { $0.id == id })
        presenter?.presentFavoriteBook(
            response: Favorite.FetchFavoriteBook.Response(
                books: books?.compactMap {
                    .init(
                        id: $0.id,
                        artistName: $0.name,
                        image: $0.artworkUrl100,
                        isFavorite: true
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
        guard let itemIndex = books?.firstIndex(where: { $0.id == id }) else { return nil }
        // Create an IndexPath for the item (in section 0) and append to itemIndexes
        let indexPath = IndexPath(item: itemIndex, section: 0)
        itemIndexes.append(indexPath)

        // Return nil if no indexes were found, otherwise return the indexes
        guard itemIndexes.count != 0 else { return nil }
        return itemIndexes
    }
}
