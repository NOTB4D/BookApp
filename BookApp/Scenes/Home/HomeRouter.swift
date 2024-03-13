//
//  HomeRouter.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Extensions
import Foundation
import UIKit

protocol HomeRoutingLogic: AnyObject {
    func routeToBookDetail(viewModel: Home.FetchBook.ViewModel)
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?

    func routeToBookDetail(viewModel: Home.FetchBook.ViewModel) {
        guard let viewController else { return }
        let detailViewController: BookDetailViewController = UIApplication.getViewController()
        detailViewController.router?.dataStore?.book = viewModel.getBookDetailModel()
        detailViewController.delegate = viewController
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
