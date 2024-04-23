//
//  SearchBar.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 23/04/24.
//

import SwiftUI

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
        SearchBar(
            text: .constant("Test"),
            isSearching: .constant(true)
        )
    }
}
