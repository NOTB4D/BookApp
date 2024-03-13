//
//  FavoriteInteractor.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

protocol FavoriteBusinessLogic: AnyObject {}

protocol FavoriteDataStore: AnyObject {}

final class FavoriteInteractor: FavoriteBusinessLogic, FavoriteDataStore {
    var presenter: FavoritePresentationLogic?
    var worker: FavoriteWorkingLogic = FavoriteWorker()
}
