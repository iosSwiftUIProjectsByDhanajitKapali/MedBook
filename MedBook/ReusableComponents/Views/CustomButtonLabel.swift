//
//  CustomButtonLabel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import SwiftUI

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

#Preview {
    CustomButtonLabel(title: "Login")
}
