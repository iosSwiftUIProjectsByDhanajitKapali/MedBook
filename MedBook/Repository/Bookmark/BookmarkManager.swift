//
//  BookmarkManager.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

protocol BookmarkManagerProtocol {
    func updateBookmarkStatus(forbook: Book)
    func fetchAllBooks() -> [Book]?
}

struct BookmarkManager: BookmarkManagerProtocol {
    
    private let bookRepo = BookmarkCoreDataRepository()
    
    func updateBookmarkStatus(forbook book: Book) {
        if bookRepo.bookExists(withCoverI: book.coverI) {
            // Book exists, so remove it
            bookRepo.removeBook(withCoverI: book.coverI)
            print("Removed book with coverI \(book.coverI) from bookmarks.")
        } else {
            // Book does not exist, so add it
            bookRepo.create(book: book)
            print("Added book with coverI \(book.coverI) to bookmarks.")
        }
    }

    func fetchAllBooks() -> [Book]? {
        return bookRepo.getAll()
    }
    
}
