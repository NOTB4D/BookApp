//
//  LocalStorageManagerProtocol.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import CoreData
import Foundation

protocol LocalStorageManagerProtocol {
    var viewContext: NSManagedObjectContext { get }
    func setup()
    func fetchBook(withId bookId: String) -> Book?
    func fetchBooks() -> [Book]?
    func add(book: BookDataModel)
    func deleteBook(withId bookId: String)
    func removeAll()
}
