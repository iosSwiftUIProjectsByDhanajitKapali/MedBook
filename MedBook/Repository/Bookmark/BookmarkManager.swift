//
//  BookmarkManager.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

struct BookmarkManager {
    
    private let bookRepo = BookDataRepository()
    
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
