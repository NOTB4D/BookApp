//
//  Book+CoreDataClass.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import CoreData
import Foundation

@objc(Book) class Book: NSManagedObject {
    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var publishDate: String?
    @NSManaged var authorName: String?
    @NSManaged var image: String?

    @nonobjc class func fetchRequest() -> NSFetchRequest<Book> {
        NSFetchRequest<Book>(entityName: String(describing: Self.self))
    }

    convenience init(context: NSManagedObjectContext, book: BookDataModel) {
        self.init(context: context)
        id = book.id
        name = book.name
        publishDate = book.publishDate
        authorName = book.authorName
        image = book.image
    }
}

extension Book: Identifiable {}

extension Book {
    var response: BookDataModel {
        .init(
            id: id,
            name: name,
            publishDate: publishDate,
            authorName: authorName,
            image: image
        )
    }
}
