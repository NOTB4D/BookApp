//
//  BookDetailPresenter.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Extensions
import Foundation

protocol BookDetailPresentationLogic: AnyObject {
    func pressentBookDetail(response: BookDetail.fetchBook.Response)
    func presentChangedFavoriteStatus(response: BookDetail.fetchFavoriteStatus.Response)
}

final class BookDetailPresenter: BookDetailPresentationLogic {
    weak var viewController: BookDetailDisplayLogic?

    func pressentBookDetail(response: BookDetail.fetchBook.Response) {
        viewController?.displayBookDetail(
            viewModel: BookDetail.fetchBook.ViewModel(
                artistName: response.artistName,
                name: response.name,
                releaseDate: response.releaseDate,
                image: response.image.stringValue,
                isFavorite: response.isFavorite
            )
        )
    }

    func presentChangedFavoriteStatus(response: BookDetail.fetchFavoriteStatus.Response) {
        viewController?.displayChangedFavoriteStatus(
            viewModel: BookDetail.fetchFavoriteStatus.ViewModel(
                id: response.id,
                isFavorite: response.isFavorite
            )
        )
    }
}
