//
//  UserManager.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

protocol UserManagerProtocol {
    func createUser(user: User)
    func fetchAllUsers() -> [User]?
    func isValidUser(forUser: User) -> Bool
}

struct UserManager: UserManagerProtocol {
    
    private let userRepo = UserCoreDataRepository()
    
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
            if user.email == forUser.email && user.password == forUser.password {
                return true
            }
        }
        return false
    }
    
    
}
