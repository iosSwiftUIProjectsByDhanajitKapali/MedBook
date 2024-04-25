//
//  SignupScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

struct SignupScreen: View {
    @Binding var path: NavigationPath
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = SignupScreenViewModel()

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
            if $viewModel.countryList.count > 0 {
                countrySelector()
                    .frame(height: 140)
                    .padding(.top, 10)
                    .padding(.bottom, 50)
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 140)
            }
            goButton()
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.getCountries()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Alert"), message: Text("Invalid user/password"), dismissButton: .default(Text("OK")))
        }
    }
    
}

//MARK: - Viewbuilders
extension SignupScreen {
    
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
        Picker("Options", selection: $viewModel.selectedCountryIndex) {
            ForEach(0 ..< $viewModel.countryList.count) { index in
                Text(viewModel.countryList[index])
            }
        }
        .pickerStyle(.wheel)
    }
    
    @ViewBuilder func goButton() -> some View {
        HStack {
            Spacer()
            
            Button(action: {
                if viewModel.isEmailValid && viewModel.isPasswordValid {   
                    path.append("homeScreen")
                }
                viewModel.signUp()
            }, label: {
                CustomButtonLabel(title: "Let's go ->")
            })
            .padding()
            
            Spacer()
        }
    }
}


#Preview {
    NavigationStack {
        SignupScreen(path: .constant(NavigationPath()))
    }
}
