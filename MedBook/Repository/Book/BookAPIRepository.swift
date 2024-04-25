//
//  BookAPIRepository.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 25/04/24.
//

import Foundation

class BookAPIRepository {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchBooks(forTitle: String, page: Int, completionHandler: @escaping((Result<BookListModel, Error>) -> Void)) {
        let url = URL(string: "https://openlibrary.org/search.json?title=\(forTitle)&limit=\(page)")
        networkManager.getApiData(
            forUrl: url,
            resultType: BookListModel.self) { res in
                switch res {
                case .success(let bookListData):
                    completionHandler(.success(bookListData))
                case .failure(let failure):
                    print(failure)
                    completionHandler(.failure(failure))
                }
            }
    }
}
