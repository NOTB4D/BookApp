//
//  HomePresenter.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation
import UIKit

protocol HomePresentationLogic: AnyObject {
    func presentBooks(response: Home.FetchBooks.Response)
    func presentBook(response: Home.FetchBook.Response)
    func presentFavoriteBook(response: Home.FetchFavoriteBook.Response)
}

final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?

    func presentBooks(response: Home.FetchBooks.Response) {
        viewController?.displayBooks(
            viewModel: Home.FetchBooks.ViewModel(
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

    func presentBook(response: Home.FetchBook.Response) {
        viewController?.displayBook(
            viewModel: Home.FetchBook.ViewModel(
                id: response.id,
                artistName: response.artistName,
                name: response.name,
                releaseDate: response.releaseDate,
                image: response.image,
                isFavorite: response.isFavorite
            )
        )
    }

    func presentFavoriteBook(response: Home.FetchFavoriteBook.Response) {
        viewController?.displayFavoriteBook(
            viewModel: Home.FetchFavoriteBook.ViewModel(
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
