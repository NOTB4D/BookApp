//
//  FavoriteViewController.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import UIKit

protocol FavoriteDisplayLogic: AnyObject {
    func displayBooks(viewModel: Favorite.FetchBooks.ViewModel)
    func displayBook(viewModel: Favorite.FetchBook.ViewModel)
    func displayFavoriteBook(viewModel: Favorite.FetchFavoriteBook.ViewModel)
}

final class FavoriteViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    var interactor: FavoriteBusinessLogic?
    var router: (FavoriteRoutingLogic & FavoriteDataPassing)?
    var books: [Favorite.Book]?

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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favoriler"
        collectionView.register(BookCell.self, in: .main)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchBooks()
    }
}

// MARK: HomeDisplayLogic

extension FavoriteViewController: FavoriteDisplayLogic {
    func displayBooks(viewModel: Favorite.FetchBooks.ViewModel) {
        books = viewModel.books
        collectionView.reloadData()
    }

    func displayBook(viewModel: Favorite.FetchBook.ViewModel) {
        router?.routeToBookDetail(viewModel: viewModel)
    }

    func displayFavoriteBook(viewModel: Favorite.FetchFavoriteBook.ViewModel) {
        books = viewModel.books
        collectionView.reloadData()
    }
}

// MARK: CollectionViewDelegate

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.fetchBook(request: .init(index: indexPath.item))
    }
}

// MARK: CollectionViewDataSource

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        books?.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = books?[indexPath.item] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueCell(type: BookCell.self, indexPath: indexPath)
        cell.setUpCell(model: .init(model: model))
        cell.delegate = self
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        .init(width: (collectionView.frame.size.width - 30) / 2, height: 235)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        20
    }
}

// MARK: BookCellDelegate

extension FavoriteViewController: BookCellDelegate {
    func didSubmitFavoriteButton(at cellmodel: BookCellModel) {
        guard let id = cellmodel.id else { return }
        interactor?.deleteBookToFavoriteBookList(with: id)
    }
}
