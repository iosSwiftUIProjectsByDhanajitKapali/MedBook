//
//  BookmarkScreenViewModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

class BookmarkScreenViewModel: ObservableObject {
    
    @Published var books: [Book] = []
    
    private let bookmarkManager = BookmarkManager()
    
    init() {
        updateBookmarkedBooks()
    }
    
    func updateBookMarkedBookStatus(book: Book) {
        bookmarkManager.updateBookmarkStatus(forbook: book)
        updateBookmarkedBooks()
    }
    
    private func updateBookmarkedBooks() {
        self.books = bookmarkManager.fetchAllBooks() ?? []
        print(books)
    }
}
