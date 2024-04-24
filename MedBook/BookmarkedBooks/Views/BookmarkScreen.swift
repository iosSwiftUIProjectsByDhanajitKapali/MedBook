//
//  BookmarkScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import SwiftUI

struct BookmarkScreen: View {
    
    @StateObject var viewModel = BookmarkScreenViewModel()
    
    var body: some View {
//        BookListView(
//            books: $viewModel.books
//        ) { book in
//            viewModel.updateBookMarkedBookStatus(book: book)
//        }
        BookListView(
            books: $viewModel.books,
            bookmarkedBook: { book in
                viewModel.updateBookMarkedBookStatus(book: book)
            },
            isLoading: .constant(false)
        )
        .navigationTitle("Bookmark")
    }
}

#Preview {
    NavigationStack {
        BookmarkScreen()
    }
}
