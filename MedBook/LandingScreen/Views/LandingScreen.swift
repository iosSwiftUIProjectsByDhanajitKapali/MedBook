//
//  LandingScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

struct LandingScreen: View {
    @Binding var path: NavigationPath
    var body: some View {
        VStack {
            Spacer()
            imageBanner()
            Spacer()
            signupLoginButtons()
                .padding(.bottom, 20)
        }
        .navigationTitle("MedBook")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.large)
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
            
            Button(action: {
                path.append("signup")
            }, label: {
                CustomButtonLabel(title: "Signup")
            })
            .padding(.trailing, 10)
            
            Button(action: {
                path.append("login")
            }, label: {
                CustomButtonLabel(title: "Login")
            })
            
            Spacer()
        }
    }
}


#Preview {
    NavigationStack {
        LandingScreen(path: .constant(NavigationPath()))
    }
}
