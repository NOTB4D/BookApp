//
//  LocalStorageManager.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

public final class LocalStorageManager {
    public static var shared: LocalStorageManager = .init()

    var localStore: LocalStorageManagerProtocol = BookCoreData()

    func setup() {
        localStore.setup()
    }

    func fetchBook(withId bookId: String) -> Book? {
        localStore.fetchBook(withId: bookId)
    }

    func add(book: BookDataModel) {
        localStore.add(book: book)
    }

    func deleteBook(withId bookId: String) {
        localStore.deleteBook(withId: bookId)
    }

    func removeAll() {
        localStore.removeAll()
    }

    func fetchBooks() -> [Book]? {
        localStore.fetchBooks()
    }
}
