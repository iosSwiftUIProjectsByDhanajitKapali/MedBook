//
//  BookListModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import Foundation

struct BookListModel: Codable {
    var books: [Book]

    enum CodingKeys: String, CodingKey {
        case books = "docs"
    }

}

struct Book: Codable {
    let title: String
    let ratingsAverage: Double
    let ratingsCount: Int
    let authorName: [String]
    let coverI: Int
    var isBookmarked = false

    enum CodingKeys: String, CodingKey {
        case title
        case ratingsAverage = "ratings_average"
        case ratingsCount = "ratings_count"
        case authorName = "author_name"
        case coverI = "cover_i"
    }
}


//MARK: - Mock methods
extension BookListModel {
    static func mockBookListModels() -> [BookListModel] {
        let book1 = Book(title: "Book 1", ratingsAverage: 4.5, ratingsCount: 100, authorName: ["Author 1"], coverI: 1)
        let book2 = Book(title: "Book 2", ratingsAverage: 3.8, ratingsCount: 80, authorName: ["Author 2"], coverI: 2)
        let book3 = Book(title: "Book 3", ratingsAverage: 4.0, ratingsCount: 4890, authorName: ["Author 3"], coverI: 3)
        
        let bookList1 = BookListModel(books: [book1])
        let bookList2 = BookListModel(books: [book2])
        let bookList3 = BookListModel(books: [book3])
        
        return [bookList1, bookList2, bookList3]
    }
    
    static func mockBooks() -> [Book] {
        let book1 = Book(title: "Book 1", ratingsAverage: 4.5, ratingsCount: 100, authorName: ["Author 1 Author 1"], coverI: 1)
        let book2 = Book(title: "Book 2", ratingsAverage: 3.8, ratingsCount: 80, authorName: ["Author 2"], coverI: 2)
        let book3 = Book(title: "Book 3", ratingsAverage: 4.0, ratingsCount: 120, authorName: ["Author 3"], coverI: 3)
        
        return [book1, book2, book3]
    }
}

