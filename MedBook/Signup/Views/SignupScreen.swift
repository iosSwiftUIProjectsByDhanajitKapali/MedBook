//
//  SignupScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

struct SignupScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = SignupScreenViewModel()
    
    @State private var navigateToHome: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            backButton()
                .padding(.leading, 10)
                .padding(.bottom, 20)
            
            welcomeTitle()
                .padding(.leading, 10)
            
            Spacer()
            emailPassword()
            Spacer()
            if $viewModel.countryList.count > 0 {
                countrySelector()
                    .frame(height: 140)
                    .padding(.top, 10)
                    .padding(.bottom, 50)
            }
            goButton()
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToHome, destination: {
            HomeScreen()
        })
        .onAppear {
            viewModel.getCountries()
        }
    }
    
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
            
            Text("sign up to continue")
                .fontWeight(.bold)
                .font(.system(size: 30))
                .foregroundStyle(.gray)
        }
    }
    
    @ViewBuilder func emailPassword() -> some View {
        EmailPasswordView(email: $viewModel.email, password: $viewModel.password)
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder func countrySelector() -> some View {
        Picker("Options", selection: $viewModel.selectedCountry) {
            ForEach(0 ..< $viewModel.countryList.count) { index in
                Text(viewModel.countryList[index])
            }
        }
        .pickerStyle(.wheel)
    }
    
    @ViewBuilder func goButton() -> some View {
        HStack {
            Spacer()
            
            Button(action: signUp) {
                if viewModel.isEmailValid && viewModel.isPasswordValid {
                    CustomButtonLabel(title: "Let's go ->")
                } else {
                    CustomDisabledButtonLabel(title: "Let's go ->")
                }
            }
            .disabled(!viewModel.isEmailValid && !viewModel.isPasswordValid)
            .padding()
            
            Spacer()
        }
    }
    
    private func signUp() {
        viewModel.saveUserCreds()
        if viewModel.isEmailValid && viewModel.isPasswordValid {
            viewModel.markUserAsLoggedIn()
            navigateToHome = true
        }
    }
}

struct EmailPasswordView: View {
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
            TextField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
        }
    }
}

#Preview {
    NavigationStack {
        SignupScreen()
    }
}
