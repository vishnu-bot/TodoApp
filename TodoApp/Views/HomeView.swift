//
//  HomeView.swift
//  TodoApp
//
//  Created by Vishnu on 04/12/25.
//

import SwiftUI

<<<<<<< HEAD:TodoApp/Views/MainViews/SearchView.swift
struct SearchView: View {
    @StateObject private var searchVM = SearchViewModel()
    
=======
struct HomeView: View {
>>>>>>> parent of 6cd9ae3 (UI improvements and SearchView):TodoApp/Views/HomeView.swift
    var body: some View {
        NavigationStack {
            ListView(item: searchVM.filteredTasks)
                .searchable(text: $searchVM.searchText, prompt: "Search tasks")
                .navigationTitle("Search")
        }
    }
}

#Preview {
    HomeView()
}
