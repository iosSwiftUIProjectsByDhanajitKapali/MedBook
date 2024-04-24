//
//  UserManager.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

struct UserManager {
    
    private let userRepo = UserDataRepository()
    
    func createUser(user: User) {
        userRepo.create(user: user)
    }

    func fetchAllUsers() -> [User]? {
        return userRepo.getAll()
    }

    func isValidUser(forUser: User) -> Bool {
        let users = self.fetchAllUsers()
        guard let users = users else { return false }
        for user in users {
            if user.email == forUser.email {
                return true
            }
        }
        return false
    }
    
    
}
