//
//  BookListView.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//

import SwiftUI

struct BookListView: View {
    @Binding var books: [Book]
    
    var bookmarkedBook: ((Book) -> Void)? = nil
    var loadMoreContent: (() -> Void)? = nil
    
    @Binding var isLoading: Bool
    
    var body: some View {
        List {
            Section {
                ForEach(0..<books.count, id: \.self) { i in
                    BookListCell(book: books[i])
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .swipeActions(edge: .trailing) {
                            if books[i].isBookmarked {
                                Button {
                                    books[i].isBookmarked.toggle()
                                    bookmarkedBook?(books[i])
                                } label: {
                                    Label("Remove", systemImage: "bookmark.slash")
                                }
                                .tint(.red)
                            } else {
                                Button {
                                    books[i].isBookmarked.toggle()
                                    bookmarkedBook?(books[i])
                                } label: {
                                    Label("Bookmark", systemImage: "bookmark")
                                }
                                .tint(.green)
                            }
                        }
                        .padding(.vertical, 20)
                        .onAppear {
                            if i+1 == books.count {
                                loadMoreContent?()
                            }
                        }
                }
                .listStyle(PlainListStyle())
            } header: {
                
            } footer: {
                if isLoading {
                    HStack {
                        Spacer()
                        Text("Loading...")
                        Spacer()
                    }
                    .background(.red)
                } else {
                    EmptyView()
                }
            }
            
            
        }
    }
}
