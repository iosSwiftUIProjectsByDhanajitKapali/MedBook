//
//  HomeScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

struct HomeScreen: View {
    @Binding var path: NavigationPath
    @StateObject private var viewModel = HomeScreenViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            title()
                .padding(.top, 20)
                .padding(.leading, 15)
             
            SearchBar(text: $viewModel.searchText, isSearching: $viewModel.isSearching) {
                viewModel.getBookListing(forTitle: viewModel.searchText)
            }
            .padding(.horizontal, 8)
            
            if viewModel.books.count > 0 {
                sortSegement()
                .padding(.horizontal, 20)
            }
            bookList()
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: navTitleImage(),
            trailing: bookMarkAndLogout()
        )
        .onChange(of: viewModel.selectedSegment) { oldValue, newValue in
            viewModel.sortBooks(by: newValue)
        }
        .onTapGesture {
            // End editing (dismiss keyboard) when tapped
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

//MARK: - ViewBuilders
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
            viewModel.logout()
            path.append(NavigationDestination.landingScreen)
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
            Picker("SortBy", selection: $viewModel.selectedSegment) {
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
            viewModel.paginateBookListing()
        }, isLoading: $viewModel.isBooksLoading)
    }
}


#Preview {
    NavigationStack {
        HomeScreen(path: .constant(NavigationPath()))
    }
}



