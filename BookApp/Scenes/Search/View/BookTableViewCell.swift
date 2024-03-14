//
//  BookTableViewCell.swift
//  BookApp
//
//  Created by Eser Kucuker on 14.03.2024.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var aurthorNameLabel: UILabel!
    @IBOutlet var publishedDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpCell(with model: Search.FetchFilteredBooks.Book) {
        selectionStyle = .none
        bookImageView.load(url: URL(string: (model.image).stringValue)!)
        bookNameLabel.text = model.bookName
        aurthorNameLabel.text = model.authorName
        publishedDateLabel.text = model.publised
    }

    override func prepareForReuse() {
        bookImageView.image = nil
        bookNameLabel.text = nil
        aurthorNameLabel.text = nil
        publishedDateLabel.text = nil
    }
}
