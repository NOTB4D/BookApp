//
//  BookCell.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import UIKit

protocol BookCellDelegate: AnyObject {
    func didSubmitFavoriteButton(at cellmodel: Home.FetchBooks.ViewModel.Book)
}

class BookCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!

    weak var delegate: BookCellDelegate?
    var cellModel: Home.FetchBooks.ViewModel.Book?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpCell(model: Home.FetchBooks.ViewModel.Book?) {
        guard let model else { return }
        cellModel = model
        imageView.load(url: URL(string: model.image!)!)
        bookTitleLabel.text = model.artistName
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
