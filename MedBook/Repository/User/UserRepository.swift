//
//  UserRepository.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

protocol UserRepository {

    func create(user: User)
    func getAll() -> [User]?
}
