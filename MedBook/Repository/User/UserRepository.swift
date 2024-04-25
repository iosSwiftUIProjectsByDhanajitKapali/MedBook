//
//  UserRepository.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation
import CoreData

protocol UserRepository {

    func create(user: User)
    func getAll() -> [User]?
}

class UserCoreDataRepository: UserRepository {
    func create(user: User) {
        // Check if a user with the same email already exists
        guard !userExists(withEmail: user.email) else {
            print("User with email \(user.email ?? "") already exists. Skipping creation.")
            return
        }
        
        // Create a new entity of CDUser type
        let cdUser = CDUser(context: PersistentStorage.shared.context)
        
        // Fill the data of the entity with the data from our model
        cdUser.email = user.email
        cdUser.password = user.password
        
        // Save the context
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [User]? {
        let result = PersistentStorage.shared.fetchManagedObjects(managedObject: CDUser.self)
        
        // Convert the result to [User] type
        var users: [User] = []
        result?.forEach({ (cdUser) in
            users.append(cdUser.convertToUser())
        })
        
        return users
    }
    
    private func userExists(withEmail email: String?) -> Bool {
        guard let email = email else { return false }
        
        // Fetch all users with the given email
        let predicate = NSPredicate(format: "email == %@", email)
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        request.predicate = predicate
        
        do {
            let count = try PersistentStorage.shared.context.count(for: request)
            return count > 0
        } catch {
            print("Error checking if user exists: \(error)")
            return false
        }
    }
}


struct User {
    var email, password: String?
}
