//
//  FavoriteRouter.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

protocol FavoriteRoutingLogic: AnyObject {}

protocol FavoriteDataPassing: AnyObject {
    var dataStore: FavoriteDataStore? { get }
}

final class FavoriteRouter: FavoriteRoutingLogic, FavoriteDataPassing {
    weak var viewController: FavoriteViewController?
    var dataStore: FavoriteDataStore?
}
