//
//  BookManager.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 25/04/24.
//

import Foundation

protocol BookManagerProtocol {
    func fetchBooks(forTitle: String,page: Int, completionHandler: @escaping(([Book]?) -> Void))
}

struct BookManager: BookManagerProtocol {
    
    private let bookApiRepo = BookAPIRepository()
    
    func fetchBooks(forTitle: String, page: Int, completionHandler: @escaping(([Book]?) -> Void)) {
        bookApiRepo.fetchBooks(forTitle: forTitle, page: page) { res in
            switch res {
            case .success(let bookListData):
                completionHandler(bookListData.books)
            case .failure(let failure):
                completionHandler(nil)
            }
        }
    }
}
