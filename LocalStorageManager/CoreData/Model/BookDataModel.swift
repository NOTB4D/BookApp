//
//  BookDataModel.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

struct BookDataModel {
    var id: String?
    var name: String?
    var publishDate: String?
    var authorName: String?
    var image: String?

    init(
        id: String? = nil,
        name: String? = nil,
        publishDate: String? = nil,
        authorName: String? = nil,
        image: String? = nil
    ) {
        self.id = id
        self.name = name
        self.publishDate = publishDate
        self.authorName = authorName
        self.image = image
    }
}
