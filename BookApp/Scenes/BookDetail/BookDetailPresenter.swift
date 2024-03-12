//
//  BookDetailPresenter.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation

protocol BookDetailPresentationLogic: AnyObject {}

final class BookDetailPresenter: BookDetailPresentationLogic {
    weak var viewController: BookDetailDisplayLogic?
}
