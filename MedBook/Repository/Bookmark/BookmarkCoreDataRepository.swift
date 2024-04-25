//
//  BookmarkCoreDataRepository.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 25/04/24.
//

import CoreData

class BookmarkCoreDataRepository: BookmarkRepository {
    func create(book: Book) {
        // Check if a user with the same email already exists
        guard !bookExists(withCoverI: book.coverI) else {
            print("Book with coverI \(book.coverI) already exists. Skipping creation.")
            return
        }
        
        // Create a new entity of CDBook type
        let cdBook = CDBook(context: PersistentStorage.shared.context)
        
        // Fill the data of the entity with the data from our model
        cdBook.title = book.title
        cdBook.ratingsAverage = book.ratingsAverage
        cdBook.ratingsCount = Int64(book.ratingsCount)
        cdBook.authorName = book.authorName.first ?? "Nil"
        cdBook.coverI = Int64(book.coverI)
        
        // Save the context
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Book]? {
        let result = PersistentStorage.shared.fetchManagedObjects(managedObject: CDBook.self)
        
        // Convert the result to [User] type
        var books: [Book] = []
        result?.forEach({ (cdBook) in
            books.append(cdBook.convertToBook())
        })
        
        return books
    }
    
    // Method to remove a book with the given coverI
    func removeBook(withCoverI coverI: Int) {
        // Fetch all books with the given coverI
        let predicate = NSPredicate(format: "coverI == %ld", Int64(coverI))
        let request: NSFetchRequest<CDBook> = CDBook.fetchRequest()
        request.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(request)
            // Delete all fetched books with the given coverI
            result.forEach { book in
                PersistentStorage.shared.context.delete(book)
            }
            // Save the context
            PersistentStorage.shared.saveContext()
        } catch {
            print("Error removing book with coverI \(coverI): \(error)")
        }
    }
    
    func bookExists(withCoverI coverI: Int) -> Bool {
        // Fetch all books with the given coverI
        let predicate = NSPredicate(format: "coverI == %ld", Int64(coverI))
        let request: NSFetchRequest<CDBook> = CDBook.fetchRequest()
        request.predicate = predicate
        
        do {
            let count = try PersistentStorage.shared.context.count(for: request)
            return count > 0
        } catch {
            print("Error checking if book exists: \(error)")
            return false
        }
    }
}
