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

extension SearchViewController: SearchDisplayLogic {
    func displayCategories(viewModel: Search.FetchCategories.ViewModel) {
        categories = viewModel
        categoriesPicker.reloadInputViews()
        categoriesPicker.isUserInteractionEnabled = true
        categoriesPicker.selectedRow = 0
    }

    func displayBookList(viewModel: Search.FetchFilteredBooks.ViewModel) {
        books = viewModel.books
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        //
    }
}

// MARK: UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: BookTableViewCell.self, indexPath: indexPath)
        cell.setUpCell(with: books[indexPath.row])
        return cell
    }
}

// MARK: BPickerTextFieldDelegate

extension SearchViewController: BPickerTextFieldDelegate {
    func pickerTextFieldNumberOfRows(_: BPickerTextField) -> Int {
        categories?.categories.count ?? .zero
    }

    func pickerTextField(_: BPickerTextField, titleForRow row: Int) -> String? {
        categories?.categories[row]
    }

    func pickerTextField(_: BPickerTextField, didSelectRow _: Int) {
        fetchSearchBook()
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    public func searchBar(_: UISearchBar, textDidChange _: String) {
        fetchSearchBook()
    }
}
