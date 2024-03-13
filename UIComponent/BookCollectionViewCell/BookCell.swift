//
//  BookCell.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import UIKit

protocol BookCellDelegate: AnyObject {
    func didSubmitFavoriteButton(at cellmodel: BookCellModel)
}

class BookCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var favoriteView: FavoriteView!

    weak var delegate: BookCellDelegate?
    var cellModel: BookCellModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpCell(model: BookCellModel?) {
        guard let model else { return }
        cellModel = model
        favoriteView.delegate = self
        favoriteView.id = model.id
        imageView.load(url: URL(string: model.image!)!)
        bookTitleLabel.text = model.artistName
    }

    override func prepareForReuse() {
        imageView.image = nil
        bookTitleLabel.text = nil
    }
}

extension BookCell: FavoriteViewDelegate {
    func didChangeFavoriteStatus(at _: String) {
        guard let cellModel else { return }
        delegate?.didSubmitFavoriteButton(at: cellModel)
    }
}

public struct BookCellModel {
    let id: String?
    let artistName: String?
    let image: String?
    let isFavorite: Bool

    init(model: Home.Book) {
        id = model.id
        artistName = model.artistName
        image = model.image
        isFavorite = model.isFavorite
    }

    init(model: Favorite.Book) {
        id = model.id
        artistName = model.artistName
        image = model.image
        isFavorite = model.isFavorite
    }
}
