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

class UserDataRepository: UserRepository {
    func create(user: User) {
        //create a new entity of CDUser type
        let cdUser = CDUser(context: PersistentStorage.shared.context)
        
        //fill the data of the entity with the data from our model
        cdUser.id = user.id
        cdUser.email = user.email
        cdUser.password = user.password
        
        //save the context
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [User]? {
        let result = PersistentStorage.shared.fetchManagedObjects(managedObject: CDUser.self)
        
        //convert the result to [User] type
        var users : [User] = []
        result?.forEach({ (cdUser) in
            users.append(cdUser.convertToUser())
        })
        
        return users
    }

}

struct User {
    var email, password: String?
    var id: UUID?
}
