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
                        image: $0.image
                    )
                }
            )
        )
    }

    func presentBook(response: Home.FetchBook.Response) {
        viewController?.displayBook(
            viewModel: Home.FetchBook.ViewModel(
                artistName: response.artistName,
                name: response.name,
                releaseDate: response.releaseDate,
                image: response.image
            )
        )
    }
}
