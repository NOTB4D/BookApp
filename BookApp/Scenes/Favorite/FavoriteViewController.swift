//
//  FavoriteViewController.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import UIKit

protocol FavoriteDisplayLogic: AnyObject {}

final class FavoriteViewController: UIViewController {
    var interactor: FavoriteBusinessLogic?
    var router: (FavoriteRoutingLogic & FavoriteDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = FavoriteInteractor()
        let presenter = FavoritePresenter()
        let router = FavoriteRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension FavoriteViewController: FavoriteDisplayLogic {}
