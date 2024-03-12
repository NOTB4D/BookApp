//
//  BookDetailInteractor.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation

protocol BookDetailBusinessLogic: AnyObject {}

protocol BookDetailDataStore: AnyObject {}

final class BookDetailInteractor: BookDetailBusinessLogic, BookDetailDataStore {
    var presenter: BookDetailPresentationLogic?
    var worker: BookDetailWorkingLogic = BookDetailWorker()
}
