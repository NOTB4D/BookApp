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
    func routeToSort()
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
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }

    func routeToSort() {
        guard let viewController else { return }
        let actionSheet = UIAlertController(title: "Sırala", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Tümü", style: .default, handler: { [weak self] _ in
            guard self != nil else { return }
            viewController.fetcSortedList(.all)
        }))
        actionSheet.addAction(UIAlertAction(title: "Yeniden eskiye", style: .default, handler: { [weak self] _ in
            guard self != nil else { return }
            viewController.fetcSortedList(.newToOld)
        }))
        actionSheet.addAction(UIAlertAction(title: "Eskiden yeniye", style: .default, handler: { [weak self] _ in
            guard self != nil else { return }
            viewController.fetcSortedList(.oldToNew)
        }))
        actionSheet.addAction(UIAlertAction(title: "Sadece beğenilenler", style: .default, handler: { [weak self] _ in
            guard self != nil else { return }
            viewController.fetcSortedList(.favorites)
        }))
        actionSheet.addAction(UIAlertAction(title: "Vazgeç", style: .cancel))
        viewController.present(actionSheet, animated: true)
    }
}
