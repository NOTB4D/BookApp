//
//  FavoritePresenter.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

protocol FavoritePresentationLogic: AnyObject {
    func presentBooks(response: Favorite.FetchBooks.Response)
    func presentBook(response: Favorite.FetchBook.Response)
    func presentFavoriteBook(response: Favorite.FetchFavoriteBook.Response)
}

final class FavoritePresenter: FavoritePresentationLogic {
    weak var viewController: FavoriteDisplayLogic?

    func presentBooks(response: Favorite.FetchBooks.Response) {
        viewController?.displayBooks(
            viewModel: Favorite.FetchBooks.ViewModel(
                books: response.books.compactMap {
                    .init(
                        id: $0.id,
                        artistName: $0.artistName,
                        image: $0.image,
                        isFavorite: $0.isFavorite
                    )
                }
            )
        )
    }

    func presentBook(response: Favorite.FetchBook.Response) {
        viewController?.displayBook(
            viewModel: Favorite.FetchBook.ViewModel(
                id: response.id,
                artistName: response.artistName,
                name: response.name,
                releaseDate: response.releaseDate,
                image: response.image,
                isFavorite: response.isFavorite
            )
        )
    }

    func presentFavoriteBook(response: Favorite.FetchFavoriteBook.Response) {
        viewController?.displayFavoriteBook(
            viewModel: Favorite.FetchFavoriteBook.ViewModel(
                books: response.books.compactMap {
                    .init(
                        id: $0.id,
                        artistName: $0.artistName,
                        image: $0.image,
                        isFavorite: $0.isFavorite
                    )
                },
                indexPath: response.indexPath
            )
        )
    }
}
