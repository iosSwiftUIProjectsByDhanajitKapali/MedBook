//
//  LandingScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI
import CoreData

struct LandingScreen: View {
    
    var body: some View {
        VStack {
            
            Spacer()
            Image(systemName: "person")
            Spacer()
            
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




#Preview {
    NavigationStack {
        LandingScreen()
    }
}

struct CustomButton: View {
    
    let title: String
    var buttonTapped: () -> Void
    
    var body: some View {
        Button(action: {
            buttonTapped()
        }) {
            Text(title)
                .fontWeight(.medium)
                .padding()
                .foregroundColor(.black)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
    }
}


struct CustomButtonLabel: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .fontWeight(.medium)
            .padding()
            .foregroundColor(.black)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}
