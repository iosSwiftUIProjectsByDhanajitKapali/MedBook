//
//  EmailPasswordView.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import SwiftUI

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
