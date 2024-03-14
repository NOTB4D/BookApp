//
//  BookDetailInteractor.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation

protocol BookDetailBusinessLogic: AnyObject {
    func fetchBookDetail()
    func changedFavoriteStatus()
}

protocol BookDetailDataStore: AnyObject {
    var book: BookDetail.fetchBook.Response? { get set }
}

final class BookDetailInteractor: BookDetailBusinessLogic, BookDetailDataStore {
    var presenter: BookDetailPresentationLogic?
    var worker: BookDetailWorkingLogic = BookDetailWorker()

    var book: BookDetail.fetchBook.Response?

    func fetchBookDetail() {
        guard let book else { return }
        presenter?.pressentBookDetail(response: book)
    }

    func changedFavoriteStatus() {
        var isFavorite = (book?.isFavorite).trueValue
        isFavorite.toggle()
        book?.isFavorite = isFavorite
        presenter?.presentChangedFavoriteStatus(
            response: BookDetail.fetchFavoriteStatus.Response(
                id: book?.id,
                isFavorite: isFavorite
            )
        )
    }
}
