//
//  BookCell.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import UIKit

protocol BookCellDelegate: AnyObject {
    func didSubmitFavoriteButton(at cellmodel: Home.Book)
}

class BookCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!

    weak var delegate: BookCellDelegate?
    var cellModel: Home.Book?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpCell(model: Home.Book?) {
        guard let model else { return }
        cellModel = model
        imageView.load(url: URL(string: model.image!)!)
        bookTitleLabel.text = model.artistName
        favoriteButton.tintColor = model.isFavorite ? .yellow : .darkGray
    }

    override func prepareForReuse() {
        imageView.image = nil
        bookTitleLabel.text = nil
    }

    @IBAction func submitfavorite(_: Any) {
        guard let cellModel else { return }
        delegate?.didSubmitFavoriteButton(at: cellModel)
    }
}
