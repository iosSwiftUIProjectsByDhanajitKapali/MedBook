//
//  MedBookApp.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

@main
struct MedBookApp: App {
    
    @State private var path: NavigationPath = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                VStack(spacing: 0) {
                    if UserDefaults.standard.bool(forKey: "loginStatus") {
                        HomeScreen(path: $path)
                    } else {
                        LandingScreen(path: $path)
                    }
                }
                .navigationDestination(for: String.self, destination: { dest in
                    if dest == "signup" {
                        SignupScreen(path: $path)
                    } else if dest == "login" {
                        LoginScreen(path: $path)
                    } else if dest == "homeScreen" {
                        HomeScreen(path: $path)
                    } else if dest == "landing" {
                        LandingScreen(path: $path)
                    }
                })
            }
            
            .preferredColorScheme(.light)
        }
    }
}
