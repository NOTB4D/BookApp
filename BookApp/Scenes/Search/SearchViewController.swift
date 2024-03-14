//
//  SearchViewController.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Extensions
import UIKit

protocol SearchDisplayLogic: AnyObject {
    func displayCategories(viewModel: Search.FetchCategories.ViewModel)
    func displayBookList(viewModel: Search.FetchFilteredBooks.ViewModel)
}

final class SearchViewController: UIViewController {
    @IBOutlet var categoriesPicker: BPickerTextField!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    var interactor: SearchBusinessLogic?
    var router: (SearchRoutingLogic & SearchDataPassing)?
    var categories: Search.FetchCategories.ViewModel?
    var books: [Search.FetchFilteredBooks.Book] = []

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
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Arama"
        tableView.register(BookTableViewCell.self, bundle: Bundle.main)
        categoriesPicker.pickerDelegate = self
        categoriesPicker.isUserInteractionEnabled = false
        categoriesPicker.setRightIcon()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchBookList()
    }

    func fetchSearchBook() {
        interactor?.searchBook(
            request: Search.FetchFilteredBooks.Request(
                text: (searchBar.text).stringValue,
                categori: (categoriesPicker.text).stringValue
            )
        )
    }
}

// MARK: SearchDisplayLogic
