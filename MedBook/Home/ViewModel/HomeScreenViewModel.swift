//
//  HomeScreenViewModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    
    //MARK: - Published data members
    @Published var sortedBooks: [Book] = BookListModel.mockBooks() //TEST
    @Published var books: [Book] = BookListModel.mockBooks() //TEST
    @Published var selectedSegmentIndex = 0
    @Published var selectedSegment: BooksSortType = .title
    @Published var searchText: String = "game" { //Test
        didSet {
            debounceSearch()
        }
    }
    @Published var isSearching: Bool = false
    @Published var isBooksLoading = false
    
    //MARK: - Private data members
    private var lastSearch: String = ""
    private var debounceTimer: Timer?
    private var paginationCounter = 1
    private let bookmarkManager: BookmarkManagerProtocol
    private let bookManager: BookManagerProtocol
    
    init(bookmarkManager: BookmarkManagerProtocol = BookmarkManager(), bookManager: BookManagerProtocol = BookManager()) {
        self.bookmarkManager = bookmarkManager
        self.bookManager = bookManager
    }
}

//MARK: - Public methods
extension HomeScreenViewModel {
    
    func getBookListing(forTitle: String) {
        if lastSearch == forTitle {
            return
        } else {
            lastSearch = forTitle
        }
        if forTitle.count < 3 {
            return
        }
        isBooksLoading = true
        books = []  // Reset the search results
        paginationCounter = 1
        fetchBooks(forTitle: searchText, page: 10)
    }
    
    func paginateBookListing() {
        isBooksLoading = true
        paginationCounter += 1
        fetchBooks(forTitle: searchText, page: paginationCounter*10)
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
    
    func updateBookMarkedBookStatus(book: Book) {
        bookmarkManager.updateBookmarkStatus(forbook: book)
        
        let bookmarkedBooks = bookmarkManager.fetchAllBooks()
        print(bookmarkedBooks)
    }
    
    func markUserAsLoggedOut() {
        UserDefaults.standard.set(false, forKey: "loginStatus")
    }
    
    func logout() {
        markUserAsLoggedOut()
    }
}


//MARK: - Private methods
extension HomeScreenViewModel {
    
    private func debounceSearch() {
        // Cancel the previous debounce timer
        debounceTimer?.invalidate()
        debounceTimer = nil
        
        // Start a new debounce timer
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            // Check if searchText count is greater than 3
            if self.searchText.count > 3 {
                self.getBookListing(forTitle: self.searchText)
            } else {
                self.books = []
            }
        }
    }
    
    private func fetchBooks(forTitle: String, page: Int) {
        bookManager.fetchBooks(
            forTitle: forTitle,
            page: page
        ) { res in
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
}
