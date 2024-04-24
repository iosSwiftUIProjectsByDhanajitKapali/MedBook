//
//  HomeScreenViewModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    
    @Published var sortedBooks: [Book] = BookListModel.mockBooks()
    @Published var books: [Book] = BookListModel.mockBooks()
    @Published var selectedSegmentIndex = 0
    
    private let bookmarkManager = BookmarkManager()
    private var paginationCounter = 1
    
    func getBookListing(forTitle: String) {
        if forTitle.count < 3 {
            return
        }
        paginationCounter += 1
        let urlString = "https://openlibrary.org/search.json?title=\(forTitle)&limit=\(paginationCounter*10)"
        
        NetworkManager().getApiData(
            forUrl: URL(string: urlString),
            resultType: BookListModel.self) { res in
                switch res {
                case .success(let bookList):
                    DispatchQueue.main.async {
                        self.books = bookList.books
                    }
                case .failure(let failure):
                    print(failure)
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
    
    func updateBookMarkedBookStatus(book: Book) {
        bookmarkManager.updateBookmarkStatus(forbook: book)
        
        let bookmarkedBooks = bookmarkManager.fetchAllBooks()
        print(bookmarkedBooks)
    }
    
    func markUserAsLoggedOut() {
        UserDefaults.standard.set(false, forKey: "loginStatus")
    }
}


