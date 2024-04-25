//
//  BookManager.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 25/04/24.
//

import Foundation

protocol BookManagerProtocol {
    func fetchBooks(forTitle: String,page: Int, completionHandler: @escaping((Result<BookListModel, Error>) -> Void))
}

struct BookManager: BookManagerProtocol {
    
    private let bookApiRepo = BookAPIRepository()
    
    func fetchBooks(forTitle: String, page: Int, completionHandler: @escaping((Result<BookListModel, Error>) -> Void)) {
        bookApiRepo.fetchBooks(forTitle: forTitle, page: page) { res in
            switch res {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
}
