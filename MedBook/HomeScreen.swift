//
//  HomeScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @StateObject private var viewModel = HomeScreenViewModel()
    
    @State var books: [BookListModel] = []
    @State var searchText: String = ""
    @State var isSearching: Bool = false
    
    @State private var selectedSegmentIndex = 0
    let segments = ["Title", "Average", "Hits"]
    
    var body: some View {
        VStack(alignment: .leading) {
            title()
                .background(.red)
                .padding(.top, 20)
             
            SearchBar(text: $searchText, isSearching: $isSearching)
            
            if !isSearching {
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
            viewModel.getBookListing(forTitle: "game")
        }
    }
    
    
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
        Button(action: {
            
        }, label: {
            Image(systemName: "bookmark.fill")
                .foregroundStyle(.black)
        })
    }
    
    @ViewBuilder func logOutButton() -> some View {
        Button(action: {
            //Pop to LandingScreen
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
            Text("SortBy: ")
            Picker(selection: $selectedSegmentIndex, label: Text("Segments")) {
                ForEach(0..<segments.count) { index in
                    Text(segments[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    @ViewBuilder func bookList() -> some View {
        List {
            ForEach(0..<books.count, id: \.self) { i in
                Text("LOL")
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    NavigationStack {
        HomeScreen(books: BookListModel.mockBookListModels())
    }
}



