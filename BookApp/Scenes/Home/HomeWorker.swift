//
//  HomeWorker.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func fetchBooks(request: GetBooksRequest) async -> Result<BooksResponse, Error>
}

final class HomeWorker: HomeWorkingLogic {
    func fetchBooks(request: GetBooksRequest) async -> Result<BooksResponse, Error> {
        await API.Book.getBooks(request: request).fetch(responseModel: BooksResponse.self)
    }
}
