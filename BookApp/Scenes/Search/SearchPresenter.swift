//
//  SearchPresenter.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

protocol SearchPresentationLogic: AnyObject {
    func presentBookList(response: Search.FetchFilteredBooks.Response)
    func presentCategories(response: Search.FetchCategories.Response)
    func presentBook(response: Search.FetchBookDetail.Response)
}

final class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?

    func presentBookList(response: Search.FetchFilteredBooks.Response) {
        viewController?.displayBookList(
            viewModel: Search.FetchFilteredBooks.ViewModel(
                books: response.books
            )
        )
    }

    func presentCategories(response: Search.FetchCategories.Response) {
        viewController?.displayCategories(viewModel: Search.FetchCategories.ViewModel(categories: response.categories))
    }

    func presentBook(response: Search.FetchBookDetail.Response) {
        viewController?.displayBook(
            viewModel: Search.FetchBookDetail.ViewModel(
                id: response.id,
                artistName: response.artistName,
                name: response.name,
                releaseDate: response.releaseDate,
                image: response.image,
                isFavorite: response.isFavorite
            )
        )
    }
}
