//
//  HomeScreenViewModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    
    func getBookListing(forTitle: String) -> [BookListModel] {
    let urlString = "https://openlibrary.org/search.json?title=\(forTitle)&limit=10"
        
        NetworkManager().getApiData(
            forUrl: URL(string: urlString),
            resultType: BookListModel.self) { res in
                switch res {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
        return []
    }
}


