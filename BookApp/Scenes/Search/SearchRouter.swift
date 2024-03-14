//
//  SearchRouter.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation
import UIKit

protocol SearchRoutingLogic: AnyObject {
    func routeToBookDetail(viewModel: Search.FetchBookDetail.ViewModel)
}

protocol SearchDataPassing: AnyObject {
    var dataStore: SearchDataStore? { get }
}

final class SearchRouter: SearchRoutingLogic, SearchDataPassing {
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?

    func routeToBookDetail(viewModel: Search.FetchBookDetail.ViewModel) {
        guard let viewController else { return }
        let detailViewController: BookDetailViewController = UIApplication.getViewController()
        detailViewController.router?.dataStore?.book = viewModel.getBookDetailModel()
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
