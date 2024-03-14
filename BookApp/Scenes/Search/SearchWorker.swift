//
//  SearchWorker.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

protocol SearchWorkingLogic: AnyObject {
    func fetchBooks(request: GetBooksRequest) async -> Result<BooksResponse, Error>
}

final class SearchWorker: SearchWorkingLogic {
    func fetchBooks(request: GetBooksRequest) async -> Result<BooksResponse, Error> {
        await API.Book.getBooks(request: request).fetch(responseModel: BooksResponse.self)
    }
}
