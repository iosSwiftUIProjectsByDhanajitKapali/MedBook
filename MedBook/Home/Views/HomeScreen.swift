//
//  HomeScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @StateObject private var viewModel = HomeScreenViewModel()
    
    @State var searchText: String = "game"
    @State var isSearching: Bool = false
    
    @State private var selectedSegment: BooksSortType = .title
    
    var body: some View {
        VStack(alignment: .leading) {
            title()
                .background(.red)
                .padding(.top, 20)
             
            SearchBar(text: $searchText, isSearching: $isSearching) {
                viewModel.getBookListing(forTitle: searchText)
            }
            
            if viewModel.books.count > 0 {
                sortSegement()
                .padding(.horizontal, 40)
            }
            
            
            bookList()
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: navTitleImage(),
            trailing: bookMarkAndLogout()
        )
        .onAppear {
            //viewModel.getBookListing(forTitle: searchText)
        }
        .onChange(of: selectedSegment) { oldValue, newValue in
            viewModel.sortBooks(by: newValue)
        }
    }
    
    
    
}

enum BooksSortType: String, CaseIterable {
    case title = "Title"
    case average = "Average"
    case hits = "Hits"
}

extension HomeScreen {
    @ViewBuilder func navTitleImage() -> some View {
        HStack {
            Image(systemName: "book.fill")
                .resizable()
                .frame(width: 50, height: 30)
            Text("MedBook")
                .fontWeight(.bold)
                .font(.system(size: 34))
        }
    }
    
    @ViewBuilder func bookMarkAndLogout() -> some View {
        HStack {
            bookMarkButton()
            logOutButton()
        }
    }
    
    @ViewBuilder func bookMarkButton() -> some View {
        NavigationLink(destination: BookmarkScreen()) {
            Image(systemName: "bookmark.fill")
                .foregroundStyle(.black)
        }
    }
    
    @ViewBuilder func logOutButton() -> some View {
        Button(action: {
            //Pop to LandingScreen
            viewModel.markUserAsLoggedOut()
        }, label: {
            Image(systemName: "delete.left")
                .foregroundStyle(.red)
        })
    }
    
    @ViewBuilder func title() -> some View {
        Text("Which topic interests you today?")
            .fontWeight(.bold)
            .font(.system(size: 30))
            .foregroundStyle(.black)
    }
    
    @ViewBuilder func sortSegement() -> some View {
        HStack {
            Text("Sort By: ")
            Picker("SortBy", selection: $selectedSegment) {
                ForEach(BooksSortType.allCases, id: \.self) { index in
                    Text(index.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    @ViewBuilder func bookList() -> some View {
        BookListView(books: $viewModel.books, bookmarkedBook: { book in
            viewModel.updateBookMarkedBookStatus(book: book)
            print(book.coverI)
            print(book.isBookmarked)
        }, loadMoreContent: {
            viewModel.getBookListing(forTitle: searchText)
        }, isLoading: $viewModel.isBooksLoading)
    }
}

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

#Preview {
    NavigationStack {
        HomeScreen()
    }
}



