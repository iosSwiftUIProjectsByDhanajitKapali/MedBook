//
//  BookmarkScreenViewModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

class BookmarkScreenViewModel: ObservableObject {
    
    //MARK:  Published data members
    @Published var books: [Book] = []
    
    //MARK:  Private data members
    private let bookmarkManager: BookmarkManagerProtocol
    
    init(bookmarkManager: BookmarkManagerProtocol = BookmarkManager()) {
        self.bookmarkManager = bookmarkManager
        updateBookmarkedBooks()
    }
}

//MARK: - Public methods
extension BookmarkScreenViewModel {
    /// Update the Bookmark status of the given book
    func updateBookMarkedBookStatus(book: Book) {
        bookmarkManager.updateBookmarkStatus(forbook: book)
        updateBookmarkedBooks()
    }
}

//MARK: - Private methods
private extension BookmarkScreenViewModel {
    func updateBookmarkedBooks() {
        self.books = bookmarkManager.fetchAllBooks() ?? []
        print(books)
    }
}
