//
//  HomeViewController.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import UIKit
import Extensions

protocol HomeDisplayLogic: AnyObject {
    func displayBook(viewModel: Home.FetchBooks.ViewModel)
}

final class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    var books: Home.FetchBooks.ViewModel?

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
        collectionView.register(BookCell.self, in: .main)
        interactor?.doSomething()
    }
}

// MARK: HomeDisplayLogic
extension HomeViewController: HomeDisplayLogic {
    func displayBook(viewModel: Home.FetchBooks.ViewModel) {
        books = viewModel
        collectionView.reloadData()
        guard let urlString = viewModel.books.first?.image else { return }
        //imageView.load(url: URL(string: urlString)!)
    }
}

// MARK: CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {

}

// MARK: CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        books?.books.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: BookCell.self, indexPath: indexPath)
        guard let model = books?.books[indexPath.item] else {return UICollectionViewCell() }
        cell.imageView.load(url: URL(string: model.image!)!)
        cell.bookTitleLabel.text = model.artistName
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (collectionView.frame.size.width - 30) / 2, height: 235)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
