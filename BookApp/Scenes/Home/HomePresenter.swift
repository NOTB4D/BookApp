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
}

final class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?

    func presentBooks(response: Home.FetchBooks.Response) {
        viewController?.displayBook(
            viewModel: Home.FetchBooks.ViewModel(
                books: response.books.compactMap {
                    .init(
                        artistName: $0.artistName,
                        image: $0.image
                    )
                }
            )
        )
    }
}
