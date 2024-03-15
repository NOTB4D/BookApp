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
    func displayBook(viewModel: Search.FetchBookDetail.ViewModel)
    func displayError(message: String)
    func displayLoader(hide: Bool)
}

final class SearchViewController: UIViewController {
    @IBOutlet var categoriesPicker: BPickerTextField!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loader: UIActivityIndicatorView!

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
        categoriesPicker.setRightIcon()
        tableView.keyboardDismissMode = .onDrag
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayLoader(hide: false)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        categoriesPicker.isUserInteractionEnabled = false
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

    @objc private func dismissKeyboard() {
        view.endEditing(false)
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

    func displayBook(viewModel: Search.FetchBookDetail.ViewModel) {
        router?.routeToBookDetail(viewModel: viewModel)
    }

    func displayError(message: String) {
        showErrorMessage(message)
    }

    func displayLoader(hide: Bool) {
        loaderHide(hide, with: loader)
    }
}

// MARK: UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = books[indexPath.row].id else { return }
        interactor?.fetcBook(request: .init(bookId: id))
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
