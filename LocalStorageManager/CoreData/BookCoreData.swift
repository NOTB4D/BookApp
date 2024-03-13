//
//  BookCoreData.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import CoreData
import Foundation

final class BookCoreData: LocalStorageManagerProtocol {
    func setup() {
        _ = persistentContainer
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookCoreData")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func add(book: BookDataModel) {
        _ = Book(context: persistentContainer.viewContext, book: book)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Error while saving to context: \(error.localizedDescription)")
        }
    }

    func deleteBook(withId bookId: String) {
        let context = persistentContainer.viewContext
        do {
            guard let record = fetchBook(withId: bookId, in: context) else { return }
            context.delete(record)

            try context.save()
        } catch {
            print("Error while saving to context: \(error.localizedDescription)")
        }
    }

    func fetchBook(withId bookId: String) -> Book? {
        fetchBook(withId: bookId, in: persistentContainer.viewContext)
    }

    func fetchBook(withId bookId: String, in context: NSManagedObjectContext) -> Book? {
        let fetchRequest = Book.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = '\(bookId)'")
        return try? context.fetch(fetchRequest).first
    }

    func removeAll() {
        let context = persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Book.fetchRequest())

        do {
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            print("Failed to delete all data: \(error)")
        }
    }

    func fetchBooks() -> [Book]? {
        let fetchRequest = Book.fetchRequest()

        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error occured while fetching from storage: \(error.localizedDescription)")
            return []
        }
    }
}
