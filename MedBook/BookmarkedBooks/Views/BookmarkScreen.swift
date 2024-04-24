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
        BookListView(
            books: $viewModel.books
        ) { book in
            viewModel.updateBookMarkedBookStatus(book: book)
        }
        .navigationTitle("Bookmark")
    }
}

#Preview {
    NavigationStack {
        BookmarkScreen()
    }
}
