//
//  HomeScreenViewModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    
    @Published var sortedBooks: [Book] = BookListModel.mockBooks() //TEST
    @Published var books: [Book] = BookListModel.mockBooks() //TEST
    @Published var selectedSegmentIndex = 0
    
    private var lastSearch: String = ""
    @Published var searchText: String = "game" { //TEST
        didSet {
            // Check if searchText count is greater than 3
            if searchText.count > 3 {
                // Call your function here
                self.getBookListing(forTitle: searchText)
            }
        }
    }
    @Published var isSearching: Bool = false
    
    @Published var isBooksLoading = false
    
    private let bookmarkManager = BookmarkManager()
    private var paginationCounter = 0
    
    func getBookListing(forTitle: String, newSearch: Bool = false) {
        if lastSearch == forTitle && newSearch == true {
            return
        } else {
            lastSearch = forTitle
        }
        if newSearch {
            paginationCounter = 0
        }
        isBooksLoading = true
        if forTitle.count < 3 {
            isBooksLoading = false
            return
        }
        paginationCounter += 1
        let urlString = "https://openlibrary.org/search.json?title=\(forTitle)&limit=\(paginationCounter*10)"
        
        NetworkManager().getApiData(
            forUrl: URL(string: urlString),
            resultType: BookListModel.self) { res in
                switch res {
                case .success(let bookListData):
                    DispatchQueue.main.async {
                        self.updateBooksWithBookmarks(bookListData: bookListData)
                    }
                case .failure(let failure):
                    print(failure)
                    DispatchQueue.main.async {
                        self.isBooksLoading = false
                    }
                }
            }
    }
    
    func sortBooks(by sortType: BooksSortType) {
        switch sortType {
        case .title:
            books.sort { $0.title > $1.title }
        case .average:
            books.sort { $0.ratingsAverage > $1.ratingsAverage }
        case .hits:
            books.sort { $0.ratingsCount > $1.ratingsCount }
        }
    }
    
    private func updateBooksWithBookmarks(bookListData: BookListModel) {
        var bookList = bookListData
        // Get the bookmarked books
        let bookmarkedBooks = self.bookmarkManager.fetchAllBooks() ?? []
        
        for index in 0..<bookList.books.count {
            let book = bookList.books[index]
            
            // Check if the book's coverI exists in bookmarkedBooks
            if let _ = bookmarkedBooks.first(where: { $0.coverI == book.coverI }) {
                // If found, mark the book as bookmarked
                bookList.books[index].isBookmarked = true
            }
        }

        // Set self.books to bookList.books
        self.books = bookList.books
        self.isBooksLoading = false
    }
    
    func updateBookMarkedBookStatus(book: Book) {
        bookmarkManager.updateBookmarkStatus(forbook: book)
        
        let bookmarkedBooks = bookmarkManager.fetchAllBooks()
        print(bookmarkedBooks)
    }
    
    func markUserAsLoggedOut() {
        UserDefaults.standard.set(false, forKey: "loginStatus")
    }
}


