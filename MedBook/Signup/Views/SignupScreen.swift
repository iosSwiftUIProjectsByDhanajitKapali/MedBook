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
        VStack(spacing: 20) {
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
            TextField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
        }
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
            if viewModel.isEmailValid && viewModel.isPasswordValid {
                NavigationLink(destination: HomeScreen()) {
                    CustomButtonLabel(title: "Let's go ->")
                }
            } else {
                CustomDisabledButtonLabel(title: "Let's go ->")
            }
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        SignupScreen()
    }
}
