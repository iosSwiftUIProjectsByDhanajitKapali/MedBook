//
//  BookListCell.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import SwiftUI

struct BookListCell: View {
    
    let book: Book
    
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/id/\(book.coverI)-M.jpg")) { image in
                image
                    .resizable()
                
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
            }
            .aspectRatio(1.0, contentMode: .fit)
            //.background(.red)
            .frame(height: 70)
            .border(Color.gray.opacity(0.6), width: 5)
            .cornerRadius(5)
            .padding(.leading, 10)
                    
            
            VStack(alignment: .leading, spacing: 10) {
                Text(book.title)
                    .fontWeight(.medium)
                    .font(.title3)
                
                HStack(spacing:0) {
                    
                    Text("\(book.authorName.first ?? "")")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .background(.red)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.orange)
                        Text(String(format: "%.1f", book.ratingsAverage))
                            .font(.subheadline)
                    }
                    .padding(.trailing, 5)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "doc.plaintext")
                            .foregroundStyle(.orange)
                        Text("\(book.ratingsCount)")
                            .font(.subheadline)
                    }
                    .frame(width: 51)
                }
            }
            .padding()
            //.background(.pink)
            
            Spacer()
        }
        .background(.white)
        .cornerRadius(10)
        .frame(height: 65)
        
    }
}

#Preview {
    BookListCell(
        book: Book(
            title: "A Game Of You",
            ratingsAverage: 4.0,
            ratingsCount: 120,
            authorName: ["Neil Gaiman"],
            coverI: 3
        )
    )
}
