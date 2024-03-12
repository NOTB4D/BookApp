//
//  BookDetailRouter.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation

protocol BookDetailRoutingLogic: AnyObject {}

protocol BookDetailDataPassing: AnyObject {
    var dataStore: BookDetailDataStore? { get }
}

final class BookDetailRouter: BookDetailRoutingLogic, BookDetailDataPassing {
    weak var viewController: BookDetailViewController?
    var dataStore: BookDetailDataStore?
}
