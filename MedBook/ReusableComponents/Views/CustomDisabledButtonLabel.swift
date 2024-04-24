//
//  CustomDisabledButtonLabel.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import SwiftUI

struct CustomDisabledButtonLabel: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .fontWeight(.medium)
            .padding()
            .foregroundColor(.gray)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
    }
}
