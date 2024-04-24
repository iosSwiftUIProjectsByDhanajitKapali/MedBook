//
//  MedBookApp.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

@main
struct MedBookApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if UserDefaults.standard.bool(forKey: "loginStatus") {
                    HomeScreen()
                } else {
                    LandingScreen()
                }
            }
            .preferredColorScheme(.light)
        }
    }
}
