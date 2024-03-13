//
//  BookDetailViewController.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import UIKit

protocol BookDetailDisplayLogic: AnyObject {
    func displayBookDetail(viewModel: BookDetail.fetchBook.ViewModel)
    func displayChangedFavoriteStatus(viewModel: BookDetail.fetchFavoriteStatus.ViewModel)
}

protocol BookDetailViewControllerDelegate: AnyObject {
    func didFavoriteStatusChanged(at id: String)
}

final class BookDetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var BookTitleLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var publishDateLabel: UILabel!

    var interactor: BookDetailBusinessLogic?
    var router: (BookDetailRoutingLogic & BookDetailDataPassing)?
    var starBarButton = UIBarButtonItem()
    weak var delegate: BookDetailViewControllerDelegate?

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
        let interactor = BookDetailInteractor()
        let presenter = BookDetailPresenter()
        let router = BookDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        title = "Detay"
        interactor?.fetchBookDetail()
    }

    func setNavBar() {
        starBarButton = UIBarButtonItem(
            image: UIImage(systemName: "star.fill"),
            style: .done,
            target: self,
            action: #selector(changedFavoriteStatus)
        )
        navigationItem.rightBarButtonItem = starBarButton
    }

    @objc func changedFavoriteStatus() {
        interactor?.changedFavoriteStatus()
    }
}

// MARK: BookDetailDisplayLogic

extension BookDetailViewController: BookDetailDisplayLogic {
    func displayBookDetail(viewModel: BookDetail.fetchBook.ViewModel) {
        artistNameLabel.text = viewModel.artistName
        publishDateLabel.text = viewModel.releaseDate
        BookTitleLabel.text = viewModel.name
        imageView.load(url: URL(string: viewModel.image)!)
        starBarButton.tintColor = viewModel.isFavorite ? .yellow : .darkGray
    }

    func displayChangedFavoriteStatus(viewModel: BookDetail.fetchFavoriteStatus.ViewModel) {
        starBarButton.tintColor = viewModel.isFavorite ? .yellow : .darkGray
        guard let id = viewModel.id else { return }
        delegate?.didFavoriteStatusChanged(at: id)
    }
}
