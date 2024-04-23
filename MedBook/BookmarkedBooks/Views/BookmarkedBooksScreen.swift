//
//  BookmarkedBooksScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import SwiftUI

struct BookmarkedBooksScreen: View {
    var body: some View {
        BookListView(books: .constant(BookListModel.mockBooks()))
    }
}

#Preview {
    BookmarkedBooksScreen()
}
