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
}
