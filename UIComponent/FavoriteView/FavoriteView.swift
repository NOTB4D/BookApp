//
//  FavoriteView.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Extensions
import UIKit

protocol FavoriteViewDelegate: AnyObject {
    func didChangeFavoriteStatus(at id: String)
}

class FavoriteView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet var favoriteButton: UIButton!
    var id: String? {
        didSet {
            isFavorite()
        }
    }

    weak var delegate: FavoriteViewDelegate?

    private let nibName: String = "FavoriteView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        view = loadViewFromNib(nibName, bundle: .main)
        addSubview(view)
    }

    @IBAction func submitFavoriteButton(_: Any) {
        guard let id else { return }
        let notification = Notification(
            name: Notification.Name("changedFavoriteStatus"),
            object: id,
            userInfo: nil
        )
        NotificationCenter.default.post(notification)
        delegate?.didChangeFavoriteStatus(at: id)
    }

    private func isFavorite() {
        guard let id else { return }
        let book = LocalStorageManager.shared.fetchBook(withId: id)
        favoriteButton.tintColor = book != nil ? .yellow : .darkGray
    }
}
