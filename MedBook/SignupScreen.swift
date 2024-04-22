//
//  SignupScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

struct SignupScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var email = ""
    @State var password = ""
    
    let countries = ["Option 1", "Option 2", "Option 3"]

       // State variable to keep track of the selected option
    @State private var selectedCountry = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            backButton()
                .padding(.top, 50)
            
            welcomeTitle()
            
            Spacer()
            
            emailPassword()
            
            Spacer()
            countrySelector()
            .padding()
            
            goButton()
            
        }
        .navigationBarBackButtonHidden(true)
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
        TextField("Email", text: $email)
            
        
        TextField("Password", text: $password)
    }
    
    @ViewBuilder func countrySelector() -> some View {
        Picker("Options", selection: $selectedCountry) {
            ForEach(0 ..< countries.count) {
                Text(self.countries[$0])
            }
        }
        .pickerStyle(.wheel)
    }
    
    @ViewBuilder func goButton() -> some View {
        HStack {
            Spacer()
            NavigationLink(destination: HomeScreen()) {
                CustomButtonLabel(title: "Let's go ->")
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
