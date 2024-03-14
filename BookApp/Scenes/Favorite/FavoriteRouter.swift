//
//  FavoriteRouter.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Extensions
import Foundation
import UIKit

protocol FavoriteRoutingLogic: AnyObject {
    func routeToBookDetail(viewModel: Favorite.FetchBook.ViewModel)
}

protocol FavoriteDataPassing: AnyObject {
    var dataStore: FavoriteDataStore? { get }
}

final class FavoriteRouter: FavoriteRoutingLogic, FavoriteDataPassing {
    weak var viewController: FavoriteViewController?
    var dataStore: FavoriteDataStore?

    func routeToBookDetail(viewModel: Favorite.FetchBook.ViewModel) {
        guard let viewController else { return }
        let detailViewController: BookDetailViewController = UIApplication.getViewController()
        detailViewController.router?.dataStore?.book = viewModel.getBookDetailModel()
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
