//
//  HomeScreenViewModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    
    @Published var books: [Book] = BookListModel.mockBooks()
    
    func getBookListing(forTitle: String) {
        let urlString = "https://openlibrary.org/search.json?title=\(forTitle)&limit=10"
        
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
}


