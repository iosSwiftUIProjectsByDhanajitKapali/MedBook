//
//  HomeScreen.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 22/04/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @State var books: [String] = ["1", "2", "3", "4"]
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
            
            List {
                ForEach(books, id: \.self) { ids in
                    Text(ids)
                        .listRowSeparator(.hidden, edges: .all)
                }
                .listStyle(.plain)
            }
            
            
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: navTitleImage(), trailing: bookMarkAndLogout())
    }
    
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
}

#Preview {
    NavigationStack {
        HomeScreen()
    }
}


struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var isSearching: Bool

        init(text: Binding<String>, isSearching: Binding<Bool>) {
            _text = text
            _isSearching = isSearching
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            isSearching = true
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            isSearching = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isSearching: $isSearching)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search"
        searchBar.backgroundImage = UIImage()
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Test"), isSearching: .constant(true))
    }
}
