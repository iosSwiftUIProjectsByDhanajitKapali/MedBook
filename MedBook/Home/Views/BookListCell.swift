//
//  BookListCell.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookListCell: View {
    
    let book: Book
    
    var body: some View {
        HStack(spacing: 0) {
            bookCoverImage()
            VStack(alignment: .leading, spacing: 10) {
                bookTitle()
                HStack(spacing:0) {
                    authorName()
                    Spacer()
                    ratings()
                }
            }
            .padding()
            Spacer()
        }
        .background(.white)
        .cornerRadius(10)
        .frame(height: 65)
        
    }
    
    @ViewBuilder func bookCoverImage() -> some View {
        WebImage(url: URL(string: "https://covers.openlibrary.org/b/id/\(book.coverI)-M.jpg")) { image in
            image.resizable()
                .frame(width: 70, height: 70, alignment: .center)
        } placeholder: {
            ProgressView()
                .frame(width: 70, height: 70, alignment: .center)
        }
        .transition(.fade(duration: 0.5)) // Fade Transition with duration
        .scaledToFit()
        .cornerRadius(5)
        .padding(4)
        .border(Color.gray.opacity(0.6), width: 5)
        .frame(width: 70, height: 70, alignment: .center)
        .cornerRadius(10)
        .padding(.leading, 10)
    }
    
    @ViewBuilder func bookTitle() -> some View {
        Text(book.title)
            .fontWeight(.medium)
            .font(.title3)
    }
    
    @ViewBuilder func authorName() -> some View {
        Text("\(book.authorName.first ?? "")")
            .foregroundStyle(.gray)
            .font(.subheadline)
    }
    
    @ViewBuilder func ratings() -> some View {
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
