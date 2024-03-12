//
//  BookCell.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import UIKit

class BookCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!

    var cellModel: Home.FetchBooks.ViewModel.Book?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpCell(model: Home.FetchBooks.ViewModel.Book?) {
        guard let model else {return}
        imageView.load(url: URL(string: model.image!)!)
        bookTitleLabel.text = model.artistName
    }

    override func prepareForReuse() {
        imageView.image = nil
        bookTitleLabel.text = nil
    }

}
