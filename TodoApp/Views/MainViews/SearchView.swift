//
//  SearchView.swift
//  TodoApp
//
//  Created by Vishnu on 05/12/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchVM = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ListView(item: searchVM.filteredTasks)
                .searchable(text: $searchVM.searchText, prompt: "Search tasks")
                .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchView()
}
