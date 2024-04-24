//
//  LoginScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

struct LoginScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = LoginScreenViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            backButton()
                .padding(.leading, 10)
                .padding(.bottom, 20)
            
            welcomeTitle()
                .padding(.leading, 10)
                    
            emailPassword()
                .padding(.top, 60)
            
            Spacer()
            loginButton()
        }
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Alert"), message: Text("Invalid user/password"), dismissButton: .default(Text("OK")))
            }
        .navigationDestination(isPresented: $viewModel.navigateToHome, destination: {
            HomeScreen()
        })
    }
    
    
}

//MARK: - ViewBuilders
extension LoginScreen {
    
    @ViewBuilder func backButton() -> some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 20, height: 30)
                .fontWeight(.bold)
                .foregroundStyle(.black)
        }
    }
    
    @ViewBuilder func welcomeTitle() -> some View {
        VStack(alignment: .leading) {
            Text("Welcome")
                .fontWeight(.bold)
                .font(.system(size: 30))
                .foregroundStyle(.black)
            
            Text("log in to continue")
                .fontWeight(.bold)
                .font(.system(size: 30))
                .foregroundStyle(.gray)
        }
    }
    
    @ViewBuilder func emailPassword() -> some View {
        EmailPasswordView(email: $viewModel.email, password: $viewModel.password)
        .padding(.horizontal, 15)
    }
    
    
    @ViewBuilder func loginButton() -> some View {
        HStack {
            Spacer()
            
            Button(action: viewModel.login) {
                CustomButtonLabel(title: "Login ->")
            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
    }
}
