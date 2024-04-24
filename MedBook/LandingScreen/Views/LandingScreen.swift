//
//  LandingScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

struct LandingScreen: View {
    
    var body: some View {
        VStack {
            Spacer()
            imageBanner()
            Spacer()
            signupLoginButtons()
                .padding(.bottom, 20)
        }
        .navigationTitle("MedBook")
        .navigationDestination(for: String.self) { dest in
            if dest == "Signup" {
                SignupScreen()
            } else {
                LoginScreen()
            }
        }
    }
}

//MARK: - ViewBuilders
extension LandingScreen {
    
    @ViewBuilder func imageBanner() -> some View {
        Image("onlineDoctor")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
    
    @ViewBuilder func signupLoginButtons() -> some View {
        HStack {
            Spacer()
            
            NavigationLink(value: "Signup") {
                CustomButtonLabel(title: "Signup")
            }
            .padding(.trailing, 10)
            NavigationLink(value: "Login") {
                CustomButtonLabel(title: "Login   ")
            }
            Spacer()
        }
    }
}


#Preview {
    NavigationStack {
        LandingScreen()
    }
}
