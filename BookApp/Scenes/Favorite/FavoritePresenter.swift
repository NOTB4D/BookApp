//
//  FavoritePresenter.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

protocol FavoritePresentationLogic: AnyObject {}

final class FavoritePresenter: FavoritePresentationLogic {
    weak var viewController: FavoriteDisplayLogic?
}
