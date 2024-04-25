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
                    if UserDefaults.standard.bool(forKey: UserDefaults.Keys.loginStatus) {
                        HomeScreen(path: $path)
                    } else {
                        LandingScreen(path: $path)
                    }
                }
                .navigationDestination(for: NavigationDestination.self, destination: { dest in
                    if dest == NavigationDestination.signupScreen {
                        SignupScreen(path: $path)
                    } else if dest == NavigationDestination.loginScreen {
                        LoginScreen(path: $path)
                    } else if dest == NavigationDestination.homeScreen {
                        HomeScreen(path: $path)
                    } else if dest == NavigationDestination.landingScreen {
                        LandingScreen(path: $path)
                    }
                })
            }
            
            .preferredColorScheme(.light)
        }
    }
}

enum NavigationDestination {
    case signupScreen
    case loginScreen
    case homeScreen
    case landingScreen
}
