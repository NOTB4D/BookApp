//
//  HomeViewController.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Extensions
import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayBooks(viewModel: Home.FetchBooks.ViewModel)
    func displayBook(viewModel: Home.FetchBook.ViewModel)
    func displayFavoriteBook(viewModel: Home.FetchFavoriteBook.ViewModel)
}

final class HomeViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    var books: [Home.Book]?

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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ana Sayfa"
        collectionView.register(BookCell.self, in: .main)
        interactor?.fetchBooks()
    }
}

// MARK: HomeDisplayLogic

extension HomeViewController: HomeDisplayLogic {
    func displayBooks(viewModel: Home.FetchBooks.ViewModel) {
        books = viewModel.books
        collectionView.reloadData()
    }

    func displayBook(viewModel: Home.FetchBook.ViewModel) {
        router?.routeToBookDetail(viewModel: viewModel)
    }

    func displayFavoriteBook(viewModel: Home.FetchFavoriteBook.ViewModel) {
        books = viewModel.books
        collectionView.reloadItems(at: viewModel.indexPath)
    }
}

// MARK: CollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.fetchBook(request: .init(index: indexPath.item))
    }
}

// MARK: CollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
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

extension HomeViewController: UICollectionViewDelegateFlowLayout {
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

extension HomeViewController: BookCellDelegate {
    func didSubmitFavoriteButton(at cellmodel: BookCellModel) {
        guard let id = cellmodel.id else { return }
        interactor?.addOrDeleteBookToFavoriteBookList(with: id)
    }
}
