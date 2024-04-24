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
        VStack {
            if viewModel.books.count > 0 {
                BookListView(
                    books: $viewModel.books,
                    bookmarkedBook: { book in
                        viewModel.updateBookMarkedBookStatus(book: book)
                    },
                    isLoading: .constant(false)
                )
            } else {
                Text("No Bookmars")
            }
        }
        .navigationTitle("Bookmark")
    }
}

#Preview {
    NavigationStack {
        BookmarkScreen()
    }
}
