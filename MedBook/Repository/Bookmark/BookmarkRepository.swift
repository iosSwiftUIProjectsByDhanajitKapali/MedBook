//
//  BookRepository.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation
import CoreData

protocol BookmarkRepository {

    func create(book: Book)
    func getAll() -> [Book]?
}
