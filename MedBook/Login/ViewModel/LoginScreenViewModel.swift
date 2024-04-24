//
//  LoginScreenViewModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

class LoginScreenViewModel: ObservableObject {
    
    
    @Published var email = "dhanajit30@gmail.com"
    
    @Published var password = "#Dhanajit30"
    
    private let userManager = UserManager()
    
    func isValidUser() -> Bool {
        let user = User(email: email, password: password)
        return userManager.isValidUser(forUser: user)
    }
    
    func markUserAsLoggedIn() {
        UserDefaults.standard.set(true, forKey: "loginStatus")
    }
}
