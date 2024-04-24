//
//  LoginScreenViewModel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import Foundation

class LoginScreenViewModel: ObservableObject {
    
    //MARK: - Published data members
    @Published var email = "dhanajit30@gmail.com" //TEST
    @Published var password = "#Dhanajit30" //TEST
    @Published var navigateToHome: Bool = false
    @Published var showAlert: Bool = false

    private let userManager: UserManagerProtocol
    
    init(userManager: UserManagerProtocol = UserManager()) {
        self.userManager = userManager
    }
}

//MARK: - Public methods
extension LoginScreenViewModel {
    
    func isValidUser() -> Bool {
        let user = User(email: email, password: password)
        return userManager.isValidUser(forUser: user)
    }
    
    func markUserAsLoggedIn() {
        UserDefaults.standard.set(true, forKey: "loginStatus")
    }
    
    func login() {
        if isValidUser() {
            markUserAsLoggedIn()
            navigateToHome = true
        } else {
            showAlert = true
        }
    }
}
